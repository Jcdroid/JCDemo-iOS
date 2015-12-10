//
//  JCSwitchTextViewController.m
//  JCDemo
//
//  Created by mac on 15/12/8.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCSwitchTextViewController.h"
#import "JCSwitchTextView.h"

@interface JCSwitchTextViewController ()

@property (strong, nonatomic) JCSwitchTextView *switchTextView;

@end

@implementation JCSwitchTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *textArray = @[@"#主要看气质#", @"#郑恺回应摔衣#", @"#空气污染红色预警#", @"#亚洲新歌榜#", @"#整容当网红#"];
    
    _switchTextView = ({
        JCSwitchTextView *switchTextView = [[JCSwitchTextView alloc] initWithFrame:CGRectMake(10, 80, kScreenWidth - 2 * 10, 40) iconImage:[UIImage imageNamed:@"search"] textArray:textArray timeInterval:2.0];
        [switchTextView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
        [self.view addSubview:switchTextView];
        switchTextView;
    });
}

- (void)dealloc {
    [_switchTextView endTimer];
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

#pragma mark - Private M

- (void)click:(id)sender {
    NSLog(@"click");
}

@end
