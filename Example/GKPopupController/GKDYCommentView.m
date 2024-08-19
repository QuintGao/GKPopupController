//
//  GKDYCommentView.m
//  Example
//
//  Created by QuintGao on 2024/1/15.
//  Copyright © 2024 QuintGao. All rights reserved.
//

#import "GKDYCommentView.h"
#import "GKDYCommentControlView.h"
#import <Masonry/Masonry.h>
#import "GKSecondViewController.h"

@interface GKDYCommentView()<GKPopupProtocol, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *expendBtn;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UITableView *tableView;

#pragma mark - 播放器缩放
@property (nonatomic, weak) UIView *containerView;

@property (nonatomic, weak) GKDouyinViewCell *cell;

@property (nonatomic, weak) ZFPlayerController *player;

@property (nonatomic, assign) CGRect playerFrame;

@property (nonatomic, assign) CGFloat playerW;
@property (nonatomic, assign) CGFloat playerH;

@end

@implementation GKDYCommentView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.expendBtn];
        [self addSubview:self.closeBtn];
        [self addSubview:self.tableView];
        
        [self.expendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(30);
            make.right.equalTo(self.mas_centerX).offset(-30);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
        
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(30);
            make.left.equalTo(self.mas_centerX).offset(30);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.expendBtn.mas_bottom).offset(30);
            make.bottom.equalTo(self.mas_bottom).offset(-SAFE_AREA_BTM);
        }];
    }
    return self;
}

- (void)showWithContainerView:(UIView *)containerView cell:(GKDouyinViewCell *)cell {
    self.containerView = containerView;
    self.cell = cell;
    self.player = cell.controlView.player;
    self.playerFrame = self.player.currentPlayerManager.view.frame;
    
    GKDYCommentControlView *controlView = [[GKDYCommentControlView alloc] init];
    self.player.controlView = controlView;
    self.player.containerView = containerView;
    
    ZFPlayerView *playView = self.player.currentPlayerManager.view;
    playView.playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    playView.coverImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    CGSize videoSize = self.player.currentPlayerManager.presentationSize;
    if (CGSizeEqualToSize(videoSize, CGSizeZero)) {
        videoSize = playView.coverImageView.image.size;
    }
    if (CGSizeEqualToSize(videoSize, CGSizeZero)) {
        videoSize = playView.playerView.frame.size;
    }
    CGRect frame = playView.frame;
    frame.size.height = frame.size.width * videoSize.height / videoSize.width;
    frame.origin.y = (containerView.bounds.size.height - frame.size.height) / 2;
    playView.frame = frame;
    [playView setNeedsLayout];
    [playView layoutIfNeeded];
    
    self.playerW = videoSize.width;
    self.playerH = videoSize.height;
    
    GKPopupController *controller = [[GKPopupController alloc] initWithContentView:self];
    controller.delegate = self;
    controller.bgColor = UIColor.clearColor;
    controller.topCornerRadius = 10;
    controller.needNavigationController = YES;
    [controller show];
}

- (void)expendAction {
    self.expendBtn.selected = !self.expendBtn.isSelected;
    [self.popupController refreshContentHeight];
}

- (void)closeAction {
    [self.popupController dismiss];
}

#pragma mark - uitableviewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"评论列表----%zd", indexPath.row + 1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GKSecondViewController *vc = [[GKSecondViewController alloc] init];
    [self.popupController.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Lazy
- (UIButton *)expendBtn {
    if (!_expendBtn) {
        _expendBtn = [[UIButton alloc] init];
        _expendBtn.backgroundColor = UIColor.blackColor;
        [_expendBtn setTitle:@"展开" forState:UIControlStateNormal];
        [_expendBtn setTitle:@"收起" forState:UIControlStateSelected];
        _expendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_expendBtn addTarget:self action:@selector(expendAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expendBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        _closeBtn.backgroundColor = UIColor.blackColor;
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

#pragma mark - GKPopupProtocol
@synthesize popupController;

// 最小高度 165
// 最小宽度 124
- (CGFloat)contentHeight {
    if (self.expendBtn.isSelected) {
        return (SCREEN_HEIGHT - SAFE_AREA_TOP);
    }
    return (SCREEN_HEIGHT - SAFE_AREA_TOP - 165);
}

- (void)contentViewShowAnimation {
    UIView *playView = self.player.currentPlayerManager.view;
    CGRect frame = playView.frame;
    frame.origin.y = SAFE_AREA_TOP;
    frame.size.height = 165;
    frame.size.width = frame.size.height * self.playerW / self.playerH;
    if (frame.size.width > self.containerView.frame.size.width) {
        frame.size.width = self.containerView.frame.size.width;
        frame.size.height = frame.size.width * self.playerH / self.playerW;
    }
    if (frame.size.width < 124) {
        frame.size.width = 124;
        frame.size.height = frame.size.width * self.playerH / self.playerW;
    }
    if (self.expendBtn.isSelected) {
        frame.size.width = 1;
        frame.size.height = frame.size.width * self.playerH / self.playerW;
    }
    
    playView.frame = frame;
    
    CGPoint center = playView.center;
    center.x = self.containerView.frame.size.width * 0.5;
    playView.center = center;
}

- (void)contentViewDismissAnimation {
    UIView *playView = self.player.currentPlayerManager.view;
    CGRect frame = playView.frame;
    frame.size.width = self.containerView.frame.size.width;
    frame.size.height = frame.size.width * self.playerH / self.playerW;
    frame.origin.y = (self.containerView.frame.size.height - frame.size.height) * 0.5;
    frame.origin.x = 0;
    playView.frame = frame;
}

- (void)contentViewDidDismiss {
    self.player.containerView = self.cell.coverImgView;
    self.player.controlView = self.cell.controlView;
    [self.containerView removeFromSuperview];
    self.containerView = nil;
}

- (void)contentViewRefreshAnimation {
    UIView *playView = self.player.currentPlayerManager.view;
    CGRect frame = playView.frame;
    frame.origin.y = SAFE_AREA_TOP;
    if (self.expendBtn.isSelected) {
        frame.size.width = 1;
        frame.size.height = frame.size.width * self.playerH / self.playerW;
    }else {
        frame.size.height = 165;
        frame.size.width = frame.size.height * self.playerW / self.playerH;
        if (frame.size.width > self.containerView.frame.size.width) {
            frame.size.width = self.containerView.frame.size.width;
            frame.size.height = frame.size.width * self.playerH / self.playerW;
        }
        if (frame.size.width < 124) {
            frame.size.width = 124;
            frame.size.height = frame.size.width * self.playerH / self.playerW;
        }
    }
    playView.frame = frame;
    
    CGPoint center = playView.center;
    center.x = self.containerView.frame.size.width * 0.5;
    playView.center = center;
}

- (void)panSlideChangeWithRatio:(CGFloat)ratio {
    CGFloat minY = 0;
    CGFloat minH = 165;
    CGFloat minW = minH * self.playerW / self.playerH;
    if (minW < 124) {
        minW = 124;
        minH = minW * self.playerH / self.playerW;
    }
    if (self.expendBtn.isSelected) {
        minW = 1;
        minH = minW * self.playerH / self.playerW;
    }
    
    
    CGFloat maxW = self.containerView.bounds.size.width;
    CGFloat maxH = maxW * self.playerH / self.playerW;
    CGFloat maxY = (self.containerView.bounds.size.height - maxH) / 2;
    if (maxY > SAFE_AREA_TOP) {
        minY = SAFE_AREA_TOP;
    }
    
    UIView *playView = self.player.currentPlayerManager.view;
    CGRect frame = playView.frame;
    if (maxY > SAFE_AREA_TOP) {
        frame.origin.y = MAX(minY, minY + (maxY - minY) * ratio);
    }else {
        maxY = SAFE_AREA_TOP;
        frame.origin.y = MAX(minY, minY + (maxY - minY) * (1 - ratio));
    }
    frame.size.width = MAX(minW, minW + (maxW - minW) * ratio);
    frame.size.height = frame.size.width * self.playerH / self.playerW;
    playView.frame = frame;
    
    CGPoint center = playView.center;
    center.x = self.containerView.bounds.size.width * 0.5;
    playView.center = center;
}

@end
