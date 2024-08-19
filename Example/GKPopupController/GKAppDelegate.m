//
//  GKAppDelegate.m
//  GKPopupController
//
//  Created by QuintGao on 01/12/2024.
//  Copyright (c) 2024 QuintGao. All rights reserved.
//

#import "GKAppDelegate.h"
#import <GKNavigationBar/GKNavigationBar.h>

@implementation GKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupNavBarStyle];
    
    return YES;
}

- (void)setupNavBarStyle {
    [GKConfigure setupDefaultConfigure];
}

@end
