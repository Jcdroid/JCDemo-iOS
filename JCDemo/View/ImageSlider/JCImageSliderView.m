//
//  JCImageSliderView.m
//  JCDemo
//
//  Created by mac on 15/12/4.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCImageSliderView.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define kPageControlHeight 24.0f

@interface JCImageSliderView () <UIScrollViewDelegate> {
    NSMutableArray *_imageViewsContiner;
    
    CGFloat _allImageWidth, _singleImageWidth;
}

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation JCImageSliderView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    self.backgroundColor = (YES)?[UIColor whiteColor]:[UIColor colorWithRed:0.0 green:0.8 blue:1.0 alpha:1.0];// test
    
    _images = @[[UIImage imageNamed:@"JCImageSliderView.bundle/pic01.png"],
                [UIImage imageNamed:@"JCImageSliderView.bundle/pic02.png"],
                [UIImage imageNamed:@"JCImageSliderView.bundle/pic03.png"],
                [UIImage imageNamed:@"JCImageSliderView.bundle/pic04.png"],
                [UIImage imageNamed:@"JCImageSliderView.bundle/pic05.gif"],
                ];
    
    _scrollView =  ({
        UIScrollView *scrollView = [UIScrollView new];
        scrollView.frame = self.frame;
        scrollView.bounces = NO;
        scrollView.pagingEnabled = YES;
        scrollView.alwaysBounceVertical = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake(kScreenWidth * _images.count * 3, 0);
        scrollView.delegate = self;
        [self addSubview:scrollView];
        scrollView;
    });
    
    _pageControl = ({
        UIPageControl *pageControl = [UIPageControl new];
        pageControl.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.500];
        pageControl.numberOfPages = _images.count;
        //pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        //pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
        pageControl.currentPage = 0;
        pageControl.enabled = NO;
        pageControl.frame = CGRectMake(0, self.frame.size.height - kPageControlHeight, kScreenWidth, kPageControlHeight);
        [self addSubview:pageControl];
        pageControl;
    });
    
    _imageViewsContiner = @[].mutableCopy;
    for (int i = 0; i < 3; i++) {
        NSMutableArray *imageViews = @[].mutableCopy;
        for (int j = 0; j < _images.count; j++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * _images.count * i + kScreenWidth * j, 0, kScreenWidth, self.frame.size.height)];
            UIImage *image = _images[j];
            imageView.image = image;
            [imageViews addObject:imageView];
            [self.scrollView addSubview:imageView];
        }
        [_imageViewsContiner addObject:imageViews];
    }
    
    _singleImageWidth = self.scrollView.frame.size.width;
    _allImageWidth = _singleImageWidth * _images.count;
    [_scrollView setContentOffset:CGPointMake(_allImageWidth, 0)];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(scrollToNext:) userInfo:nil repeats:YES];
}

#pragma mark - UIScrollViewDelegate M

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x >= _allImageWidth * 2) {
        _pageControl.currentPage = 0;
    } else if (scrollView.contentOffset.x < _allImageWidth) {
        _pageControl.currentPage = _images.count - 1;
    } else {
        _pageControl.currentPage = (scrollView.contentOffset.x - _allImageWidth) / _singleImageWidth;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x >= _allImageWidth * 2) {
        [_scrollView setContentOffset:CGPointMake(_allImageWidth, 0)];
        _pageControl.currentPage = 0;
    } else if (scrollView.contentOffset.x < _allImageWidth) {
        [_scrollView setContentOffset:CGPointMake(_allImageWidth * 2, 0)];
        _pageControl.currentPage = _images.count - 1;
    } else {
        _pageControl.currentPage = (scrollView.contentOffset.x - _allImageWidth) / _singleImageWidth;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [self pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    [self continueTimer];
}

#pragma mark - Private M

- (void)scrollToNext:(NSTimer *)timer {
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + _singleImageWidth, 0) animated:YES];
}

- (void)pauseTimer {
    if (_timer && [_timer isValid]) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)continueTimer {
    if (_timer && [_timer isValid]) {
        [_timer setFireDate:[NSDate distantPast]];
    }
}

- (void)endTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
