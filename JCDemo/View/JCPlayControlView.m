//
//  JCPlayControlView.m
//  JCDemo
//
//  Created by mac on 15/12/2.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCPlayControlView.h"

@interface JCPlayControlView () {
    BOOL isPlaying;// 是否正在播放
    BOOL isStarting;// 是否开始
    NSTimer *timer;// 计时器
    
    float delta;// 每一次跳动的距离
}

@property (nonatomic) CGFloat progress;// 当前进度

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation JCPlayControlView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *view = [[NSBundle mainBundle] loadNibNamed:@"JCPlayControlView" owner:self options:nil].firstObject;
        view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        [self addSubview:view];
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    isPlaying = NO;
    
    self.totalTime = 10;
    delta = self.slider.maximumValue / self.totalTime;
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.playButton addTarget:self action:@selector(controlPlay:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)controlPlay:(UIButton *)button {
    
    if (isStarting) {
        if (isPlaying) {
            [self pauseTimer];
        } else {
            [self continueTimer];
        }
    } else {
        [self startTimer];
    }
    
}

#pragma mark - Delegate M

- (void)startTimer {
    if (!isPlaying) {
        isStarting = !isStarting;
        isPlaying = !isPlaying;
        [self.playButton setTitle:isStarting?(isPlaying?@"暂停":@"继续"):@"开始" forState:UIControlStateNormal];
        
        if (!timer) {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
        }
        if (self.delegate) {
            [self.delegate playControlView:self beginPlaying:self.progress];
        }
    }
}

- (void)endTimer {
    if (isStarting) {
        isPlaying = !isPlaying;
        isStarting = !isStarting;
        [self.playButton setTitle:isStarting?(isPlaying?@"暂停":@"继续"):@"开始" forState:UIControlStateNormal];
        
        [timer invalidate];
        timer = nil;
        [self resetSlider];
        if (self.delegate) {
            [self.delegate playControlView:self endPlaying:self.progress];
        }
    }
}

- (void)pauseTimer {
    if (isPlaying) {
        isPlaying = !isPlaying;
        [self.playButton setTitle:isStarting?(isPlaying?@"暂停":@"继续"):@"开始" forState:UIControlStateNormal];
        
        [timer setFireDate:[NSDate distantFuture]];
        if (self.delegate) {
            [self.delegate playControlView:self pausePlaying:self.progress];
        }
    }
}

- (void)continueTimer {
    if (!isPlaying) {
        isPlaying = !isPlaying;
        [self.playButton setTitle:isStarting?(isPlaying?@"暂停":@"继续"):@"开始" forState:UIControlStateNormal];
        
        [timer setFireDate:[NSDate distantPast]];
        if (self.delegate) {
            [self.delegate playControlView:self continuePlaying:self.progress];
        }
    }
}

#pragma mark - Common M & Control Action

// reset sider
- (void)resetSlider {
    self.progress = 0;
    [self.slider setValue:self.progress animated:YES];
}

- (void)updateSlider {
    if (self.progress >= 0 && self.progress < 100) {
        self.progress += delta;
        [self.slider setValue:self.progress animated:YES];
        if (self.delegate) {
            [self.delegate playControlView:self bePlaying:self.progress];
        }
    } else {
        [self endTimer];
    }
}

- (void)sliderValueChanged:(UISlider *)slider {
    
    int quotient = self.slider.value / delta;
    self.progress = quotient * delta;
    [self.slider setValue:self.progress animated:YES];

    [self pauseTimer];
}

@end
