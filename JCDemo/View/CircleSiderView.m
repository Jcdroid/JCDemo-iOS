//
//  CircleSiderView.m
//  JCDemo
//
//  Created by mac on 15/11/26.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#define ToRad(args) (args * M_PI / 180)
#define ToAngle(args) (args * 180 / M_PI)
#define SQR(args) (args * args)

#import "CircleSiderView.h"

/** Parameters **/
CGFloat const CS_SLIDER_SIZE = 320.0f;//The width and the heigth of the slider
CGFloat const CS_RADIUS = 50.0f;
CGFloat const CS_BACKGROUND_WIDTH = 60.0f;//The width of the dark background
CGFloat const CS_LINE_WIDTH = 40.0f;//The width of the active area (the gradient) and the width of the handle
CGFloat const CS_COMPONENTS[8] = {
    0.0, 0.0, 1.0, 1.0,// RGBA
    1.0, 0.0, 1.0, 1.0};

@implementation CircleSiderView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    
    /* draw background */
    CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, CS_RADIUS, 0, 2 * M_PI, 0);
    
    [[UIColor blackColor] setStroke];
    
    CGContextSetLineWidth(ctx, CS_BACKGROUND_WIDTH);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    
    /* draw mask */
    UIGraphicsBeginImageContext(CGSizeMake(CS_SLIDER_SIZE, CS_SLIDER_SIZE));
    CGContextRef imgCtxRef = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(imgCtxRef, self.frame.size.width/2, self.frame.size.height/2, CS_RADIUS, 0, ToRad(self.angle), 0);
    [[UIColor redColor] set];
    
    CGContextSetShadowWithColor(imgCtxRef, CGSizeZero, self.angle/20, [UIColor blackColor].CGColor);
    
    CGContextSetLineWidth(imgCtxRef, CS_LINE_WIDTH);
    CGContextDrawPath(imgCtxRef, kCGPathStroke);
    
    CGImageRef mask = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
    UIGraphicsEndImageContext();
    
    
    
    /* clip mask */
    CGContextSaveGState(ctx);
    
    CGContextClipToMask(ctx, self.bounds, mask);// 裁剪
    CGImageRelease(mask);
    
    
    
    /* draw gradient color */
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, CS_COMPONENTS, NULL, 2);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient), gradient = NULL;
    
    CGContextRestoreGState(ctx);
    
    
    /*
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    //Draw the outside light
    CGContextBeginPath(ctx);
    CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, CS_RADIUS + CS_BACKGROUND_WIDTH/2, 0, ToRad(-self.angle), 1);
    [[UIColor colorWithWhite:1.0 alpha:0.05]set];
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //draw the inner light
    CGContextBeginPath(ctx);
    CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, CS_RADIUS - CS_BACKGROUND_WIDTH/2, 0, ToRad(-self.angle), 1);
    [[UIColor colorWithWhite:1.0 alpha:0.05]set];
    CGContextDrawPath(ctx, kCGPathStroke);
     */
    
    
    /* draw handle */
    CGContextSaveGState(ctx);
    
    CGContextSetShadowWithColor(ctx, CGSizeZero, 3, [UIColor blackColor].CGColor);
    
    CGPoint handleCenter = [self pointFromAngle:self.angle];
    
    [[UIColor colorWithWhite:1.0 alpha:0.7] set];
    CGContextFillEllipseInRect(ctx, CGRectMake(handleCenter.x, handleCenter.y, CS_LINE_WIDTH, CS_LINE_WIDTH));
    
    CGContextRestoreGState(ctx);
}

#pragma mark - UIControl M

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    
    [self handleTouch:touch];
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];
    
    [self handleTouch:touch];
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
}

#pragma mark - Private M

- (void)handleTouch:(UITouch *)touch {
    
    CGPoint lastPoint = [touch locationInView:self];
    
    [self moveHandle:lastPoint];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (CGPoint)pointFromAngle:(CGFloat)angle {
    
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2 - CS_LINE_WIDTH/2, self.frame.size.height/2 - CS_LINE_WIDTH/2);
    CGPoint result;
    result.x = round(centerPoint.x + CS_RADIUS * cos(ToRad(-angle)));
    result.y = round(centerPoint.y + CS_RADIUS * sin(ToRad(-angle)));
    
    
    return result;
}

- (void)moveHandle:(CGPoint)lastPoint {
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    float currentAngle = AngleFromNorth(centerPoint, lastPoint, NO);
    int angle = floor(currentAngle);
    
    //Store the new angle
    self.angle = 360 - angle;
    //Update the textfield
    //_textField.text =  [NSString stringWithFormat:@"%d", self.angle];
    
    //Redraw
    [self setNeedsDisplay];
}

static inline float AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped) {
    CGPoint v = CGPointMake(p2.x-p1.x, p2.y-p1.y);
    float vmag = sqrt(SQR(v.x) + SQR(v.y)), result = 0;
    v.x /= vmag;
    v.y /= vmag;
    double radians = atan2(v.y, v.x);
    result = ToAngle(radians);
    return (result >=0  ? result : result + 360.0);
}

@end
