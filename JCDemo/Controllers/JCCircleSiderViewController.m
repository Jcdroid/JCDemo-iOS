//
//  JCCircleSiderViewController.m
//  JCDemo
//
//  Created by mac on 15/11/26.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCCircleSiderViewController.h"
#import "CircleSiderView.h"

@interface JCCircleSiderViewController ()

@property (weak, nonatomic) IBOutlet CircleSiderView *circleSiderView;

@end

@implementation JCCircleSiderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_circleSiderView addTarget:self action:@selector(changed:) forControlEvents:UIControlEventValueChanged];
}

- (void)changed:(id)sender {
    CircleSiderView *circleSiderView = sender;
    NSLog(@"%0.2f", circleSiderView.angle);
}

@end
