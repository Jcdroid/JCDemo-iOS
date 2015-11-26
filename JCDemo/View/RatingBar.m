//
//  RatingBar.m
//  JCDemo
//
//  Created by mac on 15/11/25.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "RatingBar.h"

@interface RatingBar () {
    NSMutableArray *_imageViews;
}

@end

@implementation RatingBar

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (self.delegate) {
        [self.delegate ratingBar:self didRatingChanged:self.rating];
    }
}

@end
