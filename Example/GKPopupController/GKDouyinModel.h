//
//  GKDouyinModel.h
//  Example
//
//  Created by QuintGao on 2024/7/24.
//  Copyright © 2024 QuintGao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKDouyinModel : NSObject

@property (nonatomic, copy) NSString *video_id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *play_url;

// 比例 1: 9:16 2: 16:9
@property (nonatomic, assign) NSInteger ratio;

@end

NS_ASSUME_NONNULL_END
