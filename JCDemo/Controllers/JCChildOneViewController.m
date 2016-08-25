//
//  JCChildOneViewController.m
//  JCDemo
//
//  Created by mac on 15/12/10.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCChildOneViewController.h"

@interface JCChildOneViewController ()

@end

@implementation JCChildOneViewController

+ (instancetype)initWithColor:(UIColor *)color {
    JCChildOneViewController *vc = [JCChildOneViewController new];
    vc.view.backgroundColor = color;
    return vc;
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
