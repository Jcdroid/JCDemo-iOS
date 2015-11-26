//
//  FingerBallView.m
//  JCDemo
//
//  Created by mac on 15/11/25.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "FingerBallView.h"

static CGFloat const kBallRadius = 20.0f;

CGFloat lastX = 100;
CGFloat lastY = 100;

@implementation FingerBallView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self calculateLastPoint:touches];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self calculateLastPoint:touches];
    [self setNeedsDisplay];
}

- (void)calculateLastPoint:(NSSet<UITouch *> *)touches {
    CGPoint lastPoint = [[touches anyObject] locationInView:self];
    lastX = lastPoint.x;
    lastY = lastPoint.y;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, [UIColor blueColor].CGColor);
    CGContextFillEllipseInRect(contextRef, CGRectMake(lastX - kBallRadius / 2, lastY - kBallRadius / 2, kBallRadius, kBallRadius));
}

@end
