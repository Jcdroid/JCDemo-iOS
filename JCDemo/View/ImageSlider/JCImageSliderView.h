//
//  JCImageSliderView.h
//  JCDemo
//
//  Created by mac on 15/12/4.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCImageSliderView;

@protocol JCImageSliderViewDelegate <NSObject>

- (void)imageSliderView:(nullable JCImageSliderView *)imageSliderView didSelectAtIndex:(NSInteger)index;

@end

@interface JCImageSliderView : UIView

- (instancetype)initWithFrame:(CGRect)frame withImages:(NSArray *)images;

@property (strong, nonatomic, nonnull) NSArray *images;

@property (nonatomic, weak, nullable) id <JCImageSliderViewDelegate> delegate;

@end
