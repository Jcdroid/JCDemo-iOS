//
//  JCHamburgerViewController.m
//  JCDemo
//
//  Created by mac on 15/12/2.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCHamburgerViewController.h"
#import "HamburgerView.h"

@interface JCHamburgerViewController ()

@end

@implementation JCHamburgerViewController

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.613 blue:1.000 alpha:1.000];
    
    HamburgerView *hamburgerView = [[HamburgerView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:hamburgerView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
