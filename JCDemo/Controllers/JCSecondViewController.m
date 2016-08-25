//
//  JCSecondViewController.m
//  JCDemo
//
//  Created by mac on 15/11/20.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCSecondViewController.h"
#import "JCContainerViewController.h"

@interface JCSecondViewController ()

@end

@implementation JCSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toNextVC:(id)sender {
    JCContainerViewController *vc = [JCContainerViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
