//
//  GKDouyinControlView.h
//  Example
//
//  Created by QuintGao on 2024/7/29.
//  Copyright © 2024 QuintGao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZFPlayer/ZFPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKDouyinControlView : UIView<ZFPlayerMediaControl>

@property (nonatomic, copy) void(^commentBlock)(void);
@property (nonatomic, copy) void(^shareBlock)(void);

@end

NS_ASSUME_NONNULL_END
