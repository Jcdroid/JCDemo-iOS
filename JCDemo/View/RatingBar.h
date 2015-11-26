//
//  RatingBar.h
//  JCDemo
//
//  Created by mac on 15/11/25.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RatingBar;

@protocol RatingBarDelegate <NSObject>

- (void)ratingBar:(RatingBar *)ratingBar didRatingChanged:(float)rating;

@end

IB_DESIGNABLE

@interface RatingBar : UIView

@property (nonatomic, unsafe_unretained) IBOutlet id <RatingBarDelegate> delegate;

@property (assign, nonatomic) IBInspectable NSInteger maxRating;
@property (nonatomic, assign) IBInspectable NSInteger rating;
@property (nonatomic, assign) IBInspectable BOOL isIndicator;
@property (nonatomic, strong) IBInspectable UIImage *progressImage;
@property (nonatomic, strong) IBInspectable UIImage *secondaryProgressImage;

@end
