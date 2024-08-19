//
//  GKDYCommentView.h
//  Example
//
//  Created by QuintGao on 2024/1/15.
//  Copyright © 2024 QuintGao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GKPopupController/GKPopupController.h>
#import "GKDouyinViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface GKDYCommentView : UIView

- (void)showWithContainerView:(UIView *)containerView cell:(GKDouyinViewCell *)cell;

@end

NS_ASSUME_NONNULL_END
