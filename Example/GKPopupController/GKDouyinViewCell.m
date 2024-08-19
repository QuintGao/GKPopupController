//
//  GKDouyinViewCell.m
//  Example
//
//  Created by QuintGao on 2024/7/24.
//  Copyright © 2024 QuintGao. All rights reserved.
//

#import "GKDouyinViewCell.h"

@implementation GKDouyinViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier  {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.coverImgView];
        [self.coverImgView addSubview:self.controlView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.coverImgView.frame = self.bounds;
    self.controlView.frame = self.bounds;
}

#pragma mark - lazy
- (UIImageView *)coverImgView {
    if (!_coverImgView) {
        _coverImgView = [[UIImageView alloc] init];
        _coverImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _coverImgView;
}

- (GKDouyinControlView *)controlView {
    if (!_controlView) {
        _controlView = [[GKDouyinControlView alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        _controlView.commentBlock = ^{
            __strong __typeof(weakSelf) self = weakSelf;
            if ([self.delegate respondsToSelector:@selector(cellDidClickComment:)]) {
                [self.delegate cellDidClickComment:self];
            }
        };
        
        _controlView.shareBlock = ^{
            __strong __typeof(weakSelf) self = weakSelf;
            if ([self.delegate respondsToSelector:@selector(cellDidClickShare:)]) {
                [self.delegate cellDidClickShare:self];
            }
        };
    }
    return _controlView;
}

@end
