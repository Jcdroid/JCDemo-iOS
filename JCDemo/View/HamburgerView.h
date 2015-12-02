//
//  HamburgerView.h
//  JCDemo
//
//  Created by mac on 15/12/2.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//
//  https://github.com/jonathantribouharet/JTHamburgerButton/blob/master/JTHamburgerButton/JTHamburgerButton.h

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HamburgerViewMode) {
    HamburgerViewModeHamburger,
    HamburgerViewModeCross
};

@interface HamburgerView : UIButton

@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) CGFloat lineHeight;
@property (nonatomic) CGFloat lineSpace;
@property (nonatomic) UIColor *lineColor;

@property (nonatomic) CGFloat animationDuration;

@property (nonatomic) HamburgerViewMode currentMode;

@end
