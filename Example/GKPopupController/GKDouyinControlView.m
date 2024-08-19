//
//  GKDouyinControlView.m
//  Example
//
//  Created by QuintGao on 2024/7/29.
//  Copyright © 2024 QuintGao. All rights reserved.
//

#import "GKDouyinControlView.h"
#import <Masonry/Masonry.h>

@interface GKDouyinControlView()

@property (nonatomic, strong) UIButton *commentBtn;

@property (nonatomic, strong) UIButton *shareBtn;

@end

@implementation GKDouyinControlView

@synthesize player;

- (instancetype)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.commentBtn];
    [self addSubview:self.shareBtn];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self.shareBtn.mas_top).offset(-20);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-80);
        make.width.height.mas_offset(40);
    }];
}

- (void)commentAction {
    !self.commentBlock ?: self.commentBlock();
}

- (void)shareAction {
    !self.shareBlock ?: self.shareBlock();
}

#pragma mark - lazy
- (UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [[UIButton alloc] init];
        [_commentBtn setImage:[UIImage imageNamed:@"ss_icon_comment"] forState:UIControlStateNormal];
        [_commentBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] init];
        [_shareBtn setImage:[UIImage imageNamed:@"ss_icon_share"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

@end
