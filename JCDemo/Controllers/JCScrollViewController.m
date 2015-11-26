//
//  JCScrollViewController.m
//  JCDemo
//
//  Created by mac on 15/11/26.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCScrollViewController.h"

@interface JCScrollViewController () <UIScrollViewDelegate>

@end

@implementation JCScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2);
    scrollView.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
}

#pragma mark - UIScrollViewDelegate M

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%0.2f", scrollView.contentOffset.y);
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScrollToTop");
}

@end
