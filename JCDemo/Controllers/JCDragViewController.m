//
//  JCDragViewController.m
//  JCDemo
//
//  Created by mac on 15/11/26.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCDragViewController.h"

@interface JCDragViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *dragImgView;

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIAttachmentBehavior *attachmentBehavior;
@property (strong, nonatomic) UIPushBehavior *pushBehavior;
@property (strong, nonatomic) UIDynamicItemBehavior *itemBehavior;

@end

@implementation JCDragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)handleAttachmentGesture:(id)sender {
    UIPanGestureRecognizer *gesture = sender;
    CGPoint location = [gesture locationInView:self.view];
    NSLog(@"x = %0.2f; y = %0.2f", location.x, location.y);
}


@end
