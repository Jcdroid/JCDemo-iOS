//
//  JCPlayControlView.h
//  JCDemo
//
//  Created by mac on 15/12/2.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCPlayControlView;

@protocol JCPlayControlViewDelegate <NSObject>

@optional

- (void)playControlView:(nullable JCPlayControlView *)playControlView beginPlaying:(CGFloat)progress;
- (void)playControlView:(nullable JCPlayControlView *)playControlView bePlaying:(CGFloat)progress;
- (void)playControlView:(nullable JCPlayControlView *)playControlView continuePlaying:(CGFloat)progress;
- (void)playControlView:(nullable JCPlayControlView *)playControlView pausePlaying:(CGFloat)progress;
- (void)playControlView:(nullable JCPlayControlView *)playControlView endPlaying:(CGFloat)progress;

@end


@interface JCPlayControlView : UIView

@property (nonatomic) IBInspectable CGFloat totalTime;// 播放总时长

@property (nonatomic, weak, nullable) IBOutlet id <JCPlayControlViewDelegate> delegate;

- (void)pauseTimer;
- (void)endTimer;

@end
