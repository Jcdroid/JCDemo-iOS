//
//  CircleSiderView.m
//  JCDemo
//
//  Created by mac on 15/11/26.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#define ToRad(args) (args * M_PI / 180)

#import "CircleSiderView.h"

CGFloat const CS_RADIUS = 50.0f;
CGFloat const CS_CIRCLE_WIDTH = 10;
CGFloat const CS_LINE_WIDTH = 5;
CGFloat const CS_COMPONENTS[8] = {0.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0};

@implementation CircleSiderView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, CS_RADIUS, 0, 2 * M_PI, 0);
    CGContextSetLineWidth(ctx, CS_CIRCLE_WIDTH);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    UIGraphicsBeginImageContext(CGSizeMake(320, 320));
    CGContextRef imgCtxRef = UIGraphicsGetCurrentContext();
    CGContextAddArc(imgCtxRef, self.frame.size.width/2, self.frame.size.height/2, CS_RADIUS, 0, ToRad(self.angle), 0);
    CGContextSetShadowWithColor(imgCtxRef, CGSizeZero, self.angle/20, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(imgCtxRef, CS_LINE_WIDTH);
    CGContextDrawPath(imgCtxRef, kCGPathStroke);
    CGImageRef mask = CGBitmapContextCreateImage(imgCtxRef);
    UIGraphicsEndImageContext();
    CGContextClipToMask(imgCtxRef, self.bounds, mask);
    
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpaceRef, CS_COMPONENTS, NULL, 2);
    CGPoint startPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGColorSpaceRelease(colorSpaceRef), colorSpaceRef = NULL;
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient), gradient = NULL;
}

@end
