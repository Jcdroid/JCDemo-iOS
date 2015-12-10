//
//  JCImageSliderViewController.m
//  JCDemo
//
//  Created by mac on 15/12/4.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCImageSliderViewController.h"
#import "JCImageSliderView.h"

@interface JCImageSliderViewController () <JCImageSliderViewDelegate>

@property (strong, nonatomic) JCImageSliderView *imageSliderView;

@property (strong, nonatomic) NSArray *imageSliderItems;

@end

@implementation JCImageSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // local images
    NSArray *images = @[[UIImage imageNamed:@"JCImageSliderView.bundle/pic01.png"],
                        [UIImage imageNamed:@"JCImageSliderView.bundle/pic02.png"],
                        [UIImage imageNamed:@"JCImageSliderView.bundle/pic03.png"],
                        [UIImage imageNamed:@"JCImageSliderView.bundle/pic04.png"],
                        [UIImage imageNamed:@"JCImageSliderView.bundle/pic05.gif"],
                        ];
    
    // net images
    _imageSliderItems = @[[JCImageSliderItem initWithTitle:@"图片1" withUrl:@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=92546421,3275861884&fm=116&gp=0.jpg"],
                          [JCImageSliderItem initWithTitle:@"图片2" withUrl:@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3808166566,2350527241&fm=116&gp=0.jpg"],
                          [JCImageSliderItem initWithTitle:@"图片3" withUrl:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1122689527,866239497&fm=116&gp=0.jpg"],
                          [JCImageSliderItem initWithTitle:@"图片4" withUrl:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=301723372,3034119661&fm=116&gp=0.jpg"],
                          [JCImageSliderItem initWithTitle:@"图片5" withUrl:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1145600071,3894742496&fm=116&gp=0.jpg"],
                                  ];
    
    _imageSliderView = ({
        JCImageSliderView *imageSliderView = [[JCImageSliderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 3 / 4) imageSliderItems:_imageSliderItems pageControlPosition:JCPageControlPositionRight];
        /* 需要注意这种写法将在new的时候不会设置frame。
        JCImageSliderView *imageSliderView = [JCImageSliderView new];
        imageSliderView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * 3 / 4);
         */
        imageSliderView.delegate = self;
        [self.view addSubview:imageSliderView];
        imageSliderView;
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_imageSliderView continueTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_imageSliderView pauseTimer];
}

- (void)dealloc {
    [_imageSliderView endTimer];
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

#pragma mark - JCImageSliderViewDelegate

- (void)imageSliderView:(JCImageSliderView *)imageSliderView didSelectAtIndex:(NSInteger)index {
    JCImageSliderItem *item = _imageSliderItems[index];
    NSLog(@"%@", item.title);
}

@end
