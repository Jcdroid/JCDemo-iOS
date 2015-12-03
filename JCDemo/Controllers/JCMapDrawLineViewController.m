//
//  JCMapDrawLineViewController.m
//  JCDemo
//
//  Created by mac on 15/12/2.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCMapDrawLineViewController.h"
#import <MapKit/MapKit.h>
#import "JCPlayControlView.h"

@interface JCMapDrawLineViewController () <JCPlayControlViewDelegate>

@property (weak, nonatomic) IBOutlet JCPlayControlView *playControlView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@interface JCMapDrawLineViewController ()

@end

@implementation JCMapDrawLineViewController

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

#pragma mark JCPlayControlViewDelegate

- (void)playControlView:(JCPlayControlView *)playControlView beginPlaying:(CGFloat)progress {
    NSLog(@"开始播放，当前进度%.2f", progress);
}

- (void)playControlView:(JCPlayControlView *)playControlView bePlaying:(CGFloat)progress {
    NSLog(@"正在播放，当前进度%.2f", progress);
}

- (void)playControlView:(JCPlayControlView *)playControlView continuePlaying:(CGFloat)progress {
    NSLog(@"继续播放，当前进度%.2f", progress);
}

- (void)playControlView:(JCPlayControlView *)playControlView pausePlaying:(CGFloat)progress {
    NSLog(@"暂停播放，当前进度%.2f", progress);
}

- (void)playControlView:(JCPlayControlView *)playControlView endPlaying:(CGFloat)progress {
    NSLog(@"结束播放，当前进度%.2f", progress);
}

@end
