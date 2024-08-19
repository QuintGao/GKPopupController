//
//  GKDouyinViewCell.h
//  Example
//
//  Created by QuintGao on 2024/7/24.
//  Copyright © 2024 QuintGao. All rights reserved.
//

#import <GKVideoScrollView/GKVideoScrollView.h>
#import "GKDouyinControlView.h"

NS_ASSUME_NONNULL_BEGIN

@class GKDouyinViewCell;

@protocol GKDoyinViewCellDelegate <NSObject>

- (void)cellDidClickComment:(GKDouyinViewCell *)cell;
- (void)cellDidClickShare:(GKDouyinViewCell *)cell;

@end

@interface GKDouyinViewCell : GKVideoViewCell

@property (nonatomic, weak) id<GKDoyinViewCellDelegate> delegate;

@property (nonatomic, strong) UIImageView *coverImgView;

@property (nonatomic, strong) GKDouyinControlView *controlView;

@end

NS_ASSUME_NONNULL_END
