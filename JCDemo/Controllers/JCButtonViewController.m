//
//  JCButtonViewController.m
//  JCDemo
//
//  Created by mac on 15/12/1.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCButtonViewController.h"
#import "JCButton.h"

@interface JCButtonViewController ()

@property (weak, nonatomic) IBOutlet JCButton *jcButton;

@end

@implementation JCButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_jcButton addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test:(JCButton *)button {
    NSLog(@"点击");
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
