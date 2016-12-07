//
//  JCVerticalPageViewController.m
//  JCDemo
//
//  Created by mzy on 16/12/2.
//  Copyright © 2016年 Jcdroid. All rights reserved.
//

#import "JCVerticalPageViewController.h"

static NSString * const kCellIdentifier = @"cell";

@interface JCVerticalPageViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIWebView *webView;

@property (assign, nonatomic) CGFloat preY;
@property (assign, nonatomic) CGFloat curY;

@end

@implementation JCVerticalPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.view = self.scrollView;
    [self.scrollView addSubview:self.tableView];
    [self.scrollView addSubview:self.webView];
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset = scrollView.contentOffset;
    CGFloat y = contentOffset.y;
    NSLog(@"scrollView = %@", scrollView);
    
    if ([scrollView isKindOfClass:[UITableView class]]) {
        
        self.curY = y;
        
        if (self.isScrollDown) {
            if (self.isTableViewBottom) {
                scrollView.scrollEnabled = NO;
                self.scrollView.scrollEnabled = YES;
            } else {
                scrollView.scrollEnabled = YES;
                self.scrollView.scrollEnabled = NO;
            }
        } else {
            scrollView.scrollEnabled = YES;
            self.scrollView.scrollEnabled = NO;
        }
        
        self.preY = y;
        
    } else if([scrollView.superview isKindOfClass:[UIWebView class]]) {
        
        self.curY = y;
        
        if (self.isScrollUp) {
            if (self.isWebViewTop) {
                scrollView.scrollEnabled = NO;
                self.scrollView.scrollEnabled = YES;
            } else {
                scrollView.scrollEnabled = YES;
                self.scrollView.scrollEnabled = NO;
            }
        } else {
            scrollView.scrollEnabled = YES;
            self.scrollView.scrollEnabled = NO;
        }
        
        self.preY = y;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > self.view.frame.size.height) {// 到达webView
        self.webView.scrollView.scrollEnabled = YES;
    } else if (scrollView.contentOffset.y < self.view.frame.size.height) {// 到达tableView
        self.tableView.scrollEnabled = YES;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > self.view.frame.size.height) {// 到达webView
        self.webView.scrollView.scrollEnabled = YES;
    } else if (scrollView.contentOffset.y < self.view.frame.size.height) {// 到达tableView
        self.tableView.scrollEnabled = YES;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

#pragma mark - public method

#pragma mark - private method

/**
 上滑下滚
 */
- (BOOL)isScrollDown {
    return self.curY - self.preY > 0;
}

/**
 下滑上滚
 */
- (BOOL)isScrollUp {
    return self.curY - self.preY < 0;
}

- (BOOL)isTableViewBottom {
    return self.tableView.contentSize.height - self.tableView.contentOffset.y < self.tableView.frame.size.height;
}

- (BOOL)isWebViewTop {
    CGPoint contentOffset = self.webView.scrollView.contentOffset;
    return contentOffset.y < 0;
}

#pragma mark - getters && setters

- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.frame = self.view.frame;
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2);
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = self.view.frame;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
}

- (UIWebView *)webView {
    if(!_webView) {
        _webView = [UIWebView new];
        _webView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        [_webView loadRequest:request];
        _webView.scrollView.delegate = self;
    }
    return _webView;
}

@end
