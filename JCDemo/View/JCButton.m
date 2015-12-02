//
//  JCButton.m
//  JCDemo
//
//  Created by mac on 15/12/1.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCButton.h"

@interface JCButton () {
    UIColor *_oldColor;
}

@end

@implementation JCButton

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 6;
}
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    
    [self handleTouch:touch];
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    NSLog(@"end touch.");
    [self resetBackgroundColor];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    NSLog(@"user cancel tracking.");
    [self resetBackgroundColor];
}

- (void)handleTouch:(UITouch *)touch {
    _oldColor = self.backgroundColor;
    
    CGPoint rangePoint = CGPointMake(self.frame.size.width, self.frame.size.height);
    CGPoint touchPoint = [touch locationInView:self];
    
    CGFloat x = touchPoint.x;
    CGFloat y = touchPoint.y;
    
    if (x >= 0 && x <= rangePoint.x && y >= 0 && y <= rangePoint.y) {// 坐标在自己的frame中，也就是手指落在frame中
        self.backgroundColor = [self darkerColorForColor:self.backgroundColor];
    } else {
        [self resetBackgroundColor];
    }
}

- (void)resetBackgroundColor {
    self.backgroundColor = _oldColor;
}

- (UIColor *)darkerColorForColor:(UIColor *)color {
    CGFloat r, g, b, a;
    if ([color getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.1, 0.0)
                               green:MAX(g - 0.1, 0.0)
                                blue:MAX(b - 0.1, 0.0)
                               alpha:a];
    return nil;
}

@end
