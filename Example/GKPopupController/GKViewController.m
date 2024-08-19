//
//  GKViewController.m
//  GKPopupController
//
//  Created by QuintGao on 01/12/2024.
//  Copyright (c) 2024 QuintGao. All rights reserved.
//

#import "GKViewController.h"
#import "GKDouyinViewController.h"
#import <GKNavigationBar/GKNavigationBar.h>

@interface GKViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *lists;

@end

@implementation GKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self requestData];
}

- (void)initUI {
    self.gk_navTitle = @"GKPopupController";
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.gk_navigationBar.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.gk_navigationBar.frame));
}

- (void)requestData {
    self.lists = @[
        @{@"title": @"普通弹窗", @"class": @"GKNormalViewController"},
        @{@"title": @"抖音评论", @"class": @"GKDouyinViewController"},
        @{@"title": @"微博评论", @"class": @"GKWeiboViewController"}];
    [self.tableView reloadData];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.lists[indexPath.row] valueForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class cls = NSClassFromString([self.lists[indexPath.row] valueForKey:@"class"]);
    if (cls) {
        UIViewController *vc = [[cls alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

@end
