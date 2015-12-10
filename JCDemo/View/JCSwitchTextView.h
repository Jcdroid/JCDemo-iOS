//
//  JCSwitchTextLabel.h
//  JCDemo
//
//  Created by Jcdroid on 15/12/8.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCSwitchTextView : UIView

- (instancetype)initWithFrame:(CGRect)frame iconImage:(UIImage *)image textArray:(NSArray *)textArray timeInterval:(NSTimeInterval)timeInterval;

- (void)endTimer;

@end
