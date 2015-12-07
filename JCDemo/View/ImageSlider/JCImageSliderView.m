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
    NSMutableArray *_imageViewsContainer;
    
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

- (instancetype)initWithFrame:(CGRect)frame withImages:(NSArray *)images {
    self = [super initWithFrame:frame];
    if (self) {
        self.images = images;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    if (!_images || _images.count == 0) {
        NSLog(@"图片数组不能为空或数量不能为0");
        return;
    }
    
    self.backgroundColor = (YES)?[UIColor whiteColor]:[UIColor colorWithRed:0.0 green:0.8 blue:1.0 alpha:1.0];// test
    
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
    
    _imageViewsContainer = @[].mutableCopy;
    for (int i = 0; i < 3; i++) {
        NSMutableArray *imageViews = @[].mutableCopy;
        for (int j = 0; j < _images.count; j++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * _images.count * i + kScreenWidth * j, 0, kScreenWidth, self.frame.size.height)];
            UIImage *image = _images[j];
            imageView.image = image;
            imageView.contentMode = UIViewContentModeScaleToFill;
            [imageViews addObject:imageView];
            [self.scrollView addSubview:imageView];
        }
        [_imageViewsContainer addObject:imageViews];
    }
    
    _singleImageWidth = self.scrollView.frame.size.width;
    _allImageWidth = _singleImageWidth * _images.count;
    [_scrollView setContentOffset:CGPointMake(_allImageWidth, 0)];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(scrollToNext:) userInfo:nil repeats:YES];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIndex:)]];
}

#pragma mark - UIScrollViewDelegate M

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x >= _allImageWidth * 2) {// 到达第三组ImageViews
        [_scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x - _allImageWidth, 0)];
    } else if (scrollView.contentOffset.x < _allImageWidth) {// 到达第一组ImageViews
        [_scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x + _allImageWidth, 0)];
    }
    _pageControl.currentPage = (scrollView.contentOffset.x - _allImageWidth) / _singleImageWidth;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x >= _allImageWidth * 2) {// 到达第三组ImageViews
        [_scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x - _allImageWidth, 0)];
    } else if (scrollView.contentOffset.x < _allImageWidth) {// 到达第一组ImageViews
        [_scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x + _allImageWidth, 0)];
    }
    _pageControl.currentPage = (scrollView.contentOffset.x - _allImageWidth) / _singleImageWidth;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self continueTimer];
}

#pragma mark - Action M

- (void)selectIndex:(id)sender {
    if (self.delegate) {
        [self.delegate imageSliderView:self didSelectAtIndex:_pageControl.currentPage];
    }
}

#pragma mark - Private M

- (void)scrollToNext:(NSTimer *)timer {
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + _singleImageWidth, 0) animated:YES];
}

- (void)pauseTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)continueTimer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(scrollToNext:) userInfo:nil repeats:YES];
    }
}

- (void)endTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
