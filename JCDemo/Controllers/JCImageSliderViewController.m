//
//  JCImageSliderViewController.m
//  JCDemo
//
//  Created by mac on 15/12/4.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCImageSliderViewController.h"
#import "JCImageSliderView.h"

@interface JCImageSliderViewController ()

@property (strong, nonatomic) JCImageSliderView *imageSliderView;

@end

@implementation JCImageSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageSliderView = ({
        JCImageSliderView *imageSliderView = [[JCImageSliderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 3 / 4)];
        /* 需要注意这种写法将在new的时候不会设置frame。
        JCImageSliderView *imageSliderView = [JCImageSliderView new];
        imageSliderView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * 3 / 4);
         */
        [self.view addSubview:imageSliderView];
        imageSliderView;
    });
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
