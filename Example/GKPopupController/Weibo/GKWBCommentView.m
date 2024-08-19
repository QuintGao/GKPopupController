//
//  GKWBCommentView.m
//  Example
//
//  Created by QuintGao on 2024/7/30.
//  Copyright © 2024 QuintGao. All rights reserved.
//

#import "GKWBCommentView.h"
#import <Masonry/Masonry.h>
#import <GKPopupController/GKPopupController.h>

static GKPopupController *_popupVC;

@interface GKWBCommentView()

@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation GKWBCommentView

+ (void)show {
    [[GKWBCommentView new] show];
}

- (void)show {
    GKPopupController *popupVC = [[GKPopupController alloc] initWithContentView:self];
    popupVC.dismissType = GKRightSlideDismissType_Right;
    popupVC.contentHeight = (SCREEN_HEIGHT - SAFE_AREA_TOP);
    popupVC.dismissBlock = ^{
        _popupVC = nil;
    };
    [popupVC show];
    _popupVC = popupVC;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.closeBtn];
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(15);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
    }
    return self;
}

- (void)closeAction {
    [_popupVC dismiss];
}

#pragma mark - lazy
- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _closeBtn.backgroundColor = UIColor.blackColor;
        [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

@end
