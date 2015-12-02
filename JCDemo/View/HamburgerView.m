//
//  HamburgerView.m
//  JCDemo
//
//  Created by mac on 15/12/2.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "HamburgerView.h"

@interface HamburgerView () {
    CAShapeLayer *topLayer;
    CAShapeLayer *middleLayer;
    CAShapeLayer *bottomLayer;
}

@end

@implementation HamburgerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.lineColor = [UIColor whiteColor];
    self.lineHeight = 1.5;
    self.lineSpace = 3.5;
    self.lineWidth = 24.;
    
    self.animationDuration = .3;
    [self updateAppearance];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)updateAppearance {
    [topLayer removeFromSuperlayer];
    [middleLayer removeFromSuperlayer];
    [bottomLayer removeFromSuperlayer];
    
    CGFloat x = CGRectGetWidth(self.frame) / 2.;
    {
        CGFloat y = CGRectGetHeight(self.frame) / 2. - self.lineHeight - self.lineSpace;
        topLayer = [self createLayer];
        topLayer.position = CGPointMake(x, y);
    }
    
    {
        CGFloat y = CGRectGetHeight(self.frame) / 2.;
        middleLayer = [self createLayer];
        middleLayer.position = CGPointMake(x, y);
    }
    
    {
        CGFloat y = CGRectGetHeight(self.frame) / 2. + self.lineHeight + self.lineSpace;
        bottomLayer = [self createLayer];
        bottomLayer.position = CGPointMake(x, y);
    }
    
    switch (self.currentMode) {
        case HamburgerViewModeHamburger:
            [self transformModeHamburger];
            break;
            
        case HamburgerViewModeCross:
            [self transformModeCross];
            break;
            
        default:
            break;
    }
}

- (CAShapeLayer *)createLayer {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.lineWidth, 0)];
    
    layer.path = path.CGPath;
    layer.lineWidth = self.lineHeight;
    layer.strokeColor = self.lineColor.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    
    [self.layer addSublayer:layer];
    
    return layer;
}

- (void)transformModeHamburger {
    topLayer.transform = CATransform3DIdentity;
    middleLayer.transform = CATransform3DIdentity;
    bottomLayer.transform = CATransform3DIdentity;
}

- (void)transformModeCross {
    {
        CGFloat angle = M_PI_4;
        
        CGFloat translateY = middleLayer.position.y - topLayer.position.y;
        
        CATransform3D t = CATransform3DIdentity;
        t = CATransform3DTranslate(t, 0, translateY, 0);
        t = CATransform3DRotate(t, angle, 0, 0, 1);
        
        topLayer.transform = t;
    }
    
    {
        CATransform3D t = CATransform3DIdentity;
        t = CATransform3DScale(t, 0, 1., 1.);
        
        middleLayer.transform = t;
    }
    
    {
        CGFloat angle = - M_PI_4;
        
        CGFloat translateY = middleLayer.position.y - bottomLayer.position.y;
        
        CATransform3D t = CATransform3DIdentity;
        t = CATransform3DTranslate(t, 0, translateY, 0);
        t = CATransform3DRotate(t, angle, 0, 0, 1);
        
        bottomLayer.transform = t;
    }
}

@end
