//
//  JCScaleTableCellViewController.m
//  JCDemo
//
//  Created by mac on 15/12/4.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCScaleTableCellViewController.h"

#define kCellHeight [UIScreen mainScreen].bounds.size.width * 3 /4

static NSString * const kReuseIdentifier = @"reuseIdentifier";

@interface ColorTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *colorImageView;

@end

@implementation ColorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, kCellHeight);
        self.colorImageView = [UIImageView new];
        self.colorImageView.frame = self.contentView.frame;
        [self addSubview:self.colorImageView];
    }
    return self;
}

@end

@interface JCScaleTableCellViewController () {
    NSArray *_bgColors;
}

@end

@implementation JCScaleTableCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ColorTableViewCell class] forCellReuseIdentifier:kReuseIdentifier];
    
    NSArray *colors = @[
                        [UIColor redColor], [UIColor greenColor], [UIColor blueColor],
                        [UIColor grayColor], [UIColor brownColor], [UIColor blackColor],
                        [UIColor purpleColor], [UIColor darkGrayColor], [UIColor cyanColor],
                        [UIColor yellowColor], [UIColor orangeColor], [UIColor magentaColor]];// 12
    _bgColors = colors;
    [self.tableView reloadData];
    [self scrollViewDidScroll:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _bgColors.count * 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ColorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
    if (!cell) cell = [[ColorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReuseIdentifier];

    cell.colorImageView.image = [self imageWithColor:_bgColors[indexPath.row % _bgColors.count]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat viewHeight = scrollView.frame.size.height + scrollView.contentInset.top;
    
    for (ColorTableViewCell *cell in self.tableView.visibleCells) {
        CGFloat y = cell.center.y - scrollView.contentOffset.y;
        CGFloat p = y - viewHeight / 2;
        CGFloat scale = cos(p / viewHeight * 0.8) * 0.95;
        cell.colorImageView.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

// color to image
- (UIImage *)imageWithColor:(UIColor *)color {
    CGSize size = (CGSize){1, 1};
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
