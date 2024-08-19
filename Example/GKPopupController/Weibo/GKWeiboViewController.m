//
//  GKWeiboViewController.m
//  Example
//
//  Created by QuintGao on 2024/7/30.
//  Copyright © 2024 QuintGao. All rights reserved.
//

#import "GKWeiboViewController.h"
#import "GKWBCommentView.h"
#import "GKWBShareView.h"

@interface GKWeiboViewController ()

@end

@implementation GKWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.gk_navTitle = @"微博评论";
    
    UIButton *cmtBtn = [[UIButton alloc] init];
    [cmtBtn setTitle:@"评论" forState:UIControlStateNormal];
    [cmtBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    cmtBtn.backgroundColor = UIColor.blackColor;
    cmtBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cmtBtn addTarget:self action:@selector(cmtAction) forControlEvents:UIControlEventTouchUpInside];
    cmtBtn.frame = CGRectMake((self.view.bounds.size.width - 100)/2, 150, 100, 30);
    [self.view addSubview:cmtBtn];
    
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    shareBtn.backgroundColor = UIColor.blackColor;
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.frame = CGRectMake((self.view.bounds.size.width - 100)/2, 200, 100, 30);
    [self.view addSubview:shareBtn];
}

- (void)cmtAction {
    [GKWBCommentView show];
}

- (void)shareAction {
    [GKWBShareView show];
}

@end
