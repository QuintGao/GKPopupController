//
//  GKSecondViewController.m
//  Example
//
//  Created by QuintGao on 2024/8/1.
//  Copyright © 2024 QuintGao. All rights reserved.
//

#import "GKSecondViewController.h"

@interface GKSecondViewController ()

@end

@implementation GKSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.title = @"二级页面";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

@end
