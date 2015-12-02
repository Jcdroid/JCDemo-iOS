//
//  JCHomeViewController.m
//  JCDemo
//
//  Created by mac on 15/11/25.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCHomeViewController.h"
#import "JCFingerballViewController.h"
#import "JCScrollViewController.h"
#import "JCCoreTextViewController.h"
#import "JCDragViewController.h"
#import "JCCircleSiderViewController.h"
#import "JCButtonViewController.h"
#import "JCHamburgerViewController.h"

static NSString * const kIdentifierHomeCell = @"HomeCell";

@interface JCHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *names;
@property (strong, nonatomic) NSMutableArray *classNames;
@property (strong, nonatomic) NSMutableArray *isNibs;

@end

@implementation JCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.names = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    self.isNibs = @[].mutableCopy;
    
    [self addName:@"小球跟随手指" className:@"JCFingerballViewController" isNibs:YES];
    [self addName:@"ScrollView" className:@"JCScrollViewController" isNibs:NO];
    [self addName:@"CoreText" className:@"JCCoreTextViewController" isNibs:YES];
    [self addName:@"拖拽（探探）" className:@"JCDragViewController" isNibs:YES];
    [self addName:@"圆盘进度条控制器" className:@"JCCircleSiderViewController" isNibs:YES];
    [self addName:@"自定义Button" className:@"JCButtonViewController" isNibs:YES];
    [self addName:@"HamburgerView" className:@"JCHamburgerViewController" isNibs:NO];
}

- (void)addName:(NSString *)name className:(NSString *)className isNibs:(BOOL)isNib {
    [self.names addObject:name];
    [self.classNames addObject:className];
    [self.isNibs addObject:[NSNumber numberWithBool:isNib]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Tab M

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifierHomeCell forIndexPath:indexPath];
    
    cell.textLabel.text = self.names[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSNumber *number = self.isNibs[indexPath.row];
    UIViewController *vc;
    if (number.boolValue) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:self.classNames[indexPath.row]];
    } else {
        Class class = NSClassFromString(self.classNames[indexPath.row]);
        if (class) {
            vc = class.new;
        }
    }
    vc.title = self.names[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
