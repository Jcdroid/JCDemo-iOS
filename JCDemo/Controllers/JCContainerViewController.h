//
//  JCContainerViewController.h
//  JCDemo
//
//  Created by mac on 15/12/10.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//
//
// http://objccn.io/issue-12-3/
// https://github.com/objcio/issue-12-custom-container-transitions

#import <UIKit/UIKit.h>

@class JCContainerViewController;

@protocol JCContainerViewControllerDelegate <NSObject>

@optional

- (void)containerViewCOntroller:(JCContainerViewController *)containerViewController didSelectViewController:(UIViewController *)viewController;
- (nullable id <UIViewControllerAnimatedTransitioning>)containerViewController:(JCContainerViewController *)containerViewController animationControllerForTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController;

@end

@interface JCContainerViewController : UIViewController

@property(nullable, nonatomic, weak) id<JCContainerViewControllerDelegate> delegate;

@end
