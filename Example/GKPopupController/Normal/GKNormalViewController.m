//
//  GKNormalViewController.m
//  Example
//
//  Created by QuintGao on 2024/7/30.
//  Copyright © 2024 QuintGao. All rights reserved.
//

#import "GKNormalViewController.h"
#import "GKNormalView.h"

@interface GKNormalViewController ()

@property (nonatomic, strong) UIButton *shareBtn;

@end

@implementation GKNormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.gk_navTitle = @"普通弹窗";
    
    self.shareBtn = [[UIButton alloc] init];
    [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.shareBtn.backgroundColor = UIColor.blackColor;
    self.shareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.shareBtn];
    [self.shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    self.shareBtn.frame = CGRectMake((self.view.frame.size.width - 100)/2, 150, 100, 40);
}

- (void)shareAction {
    [GKNormalView show];
}

@end
