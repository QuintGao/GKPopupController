//
//  GKDouyinViewController.m
//  Example
//
//  Created by QuintGao on 2024/7/24.
//  Copyright © 2024 QuintGao. All rights reserved.
//

#import "GKDouyinViewController.h"
#import <GKVideoScrollView/GKVideoViewCell.h>
#import <SDWebImage/SDWebImage.h>
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import "GKDouyinViewCell.h"
#import "GKDouyinModel.h"
#import <GKNavigationBar/GKNavigationBar.h>
#import <Masonry/Masonry.h>
#import "GKDYCommentView.h"

@interface GKDouyinViewController ()<GKVideoScrollViewDataSource, GKVideoScrollViewDelegate, GKDoyinViewCellDelegate>

@property (nonatomic, strong) GKVideoScrollView *scrollView;

@property (nonatomic, strong) ZFPlayerController *player;

@property (nonatomic, strong) NSMutableArray *models;

@property (nonatomic, assign) CGSize videoSize;

@property (nonatomic, strong) UIView *containerView;

@end

@implementation GKDouyinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initPlayer];
    [self reqeustData];
}

- (void)initUI {
    self.gk_navTitle = @"抖音";
    self.gk_navBackgroundColor = UIColor.clearColor;
    self.gk_navShadowColor = UIColor.clearColor;
    self.gk_backStyle = GKNavigationBarBackStyleWhite;
    self.gk_navTitleColor = UIColor.whiteColor;
    self.gk_statusBarStyle = UIStatusBarStyleLightContent;
    
    self.view.backgroundColor = UIColor.blackColor;
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(self.scrollView.mas_width).multipliedBy(16/9.0);
    }];
}

- (void)initPlayer {
    ZFAVPlayerManager *manager = [[ZFAVPlayerManager alloc] init];
    manager.shouldAutoPlay = NO;
    
    ZFPlayerController *player = [[ZFPlayerController alloc] init];
    player.currentPlayerManager = manager;
    player.disableGestureTypes = ZFPlayerDisableGestureTypesPan | ZFPlayerDisableGestureTypesPinch;
    player.allowOrentitaionRotation = NO;
    self.player = player;
    
    @weakify(self);
    player.playerDidToEnd = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
        @strongify(self);
        [self.player.currentPlayerManager replay];
    };
    
    player.presentationSizeChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, CGSize size) {
        @strongify(self);
        self.videoSize = size;
    };
}

- (void)reqeustData {
    GKDouyinModel *m1 = [[GKDouyinModel alloc] init];
    m1.video_id = @"001";
    m1.thumb = @"https://images.pexels.com/videos/9947059/pexels-photo-9947059.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
    m1.play_url = @"https://videos.pexels.com/video-files/9947059/9947059-sd_360_640_30fps.mp4";
    m1.ratio = 1;
    [self.models addObject:m1];
    
    GKDouyinModel *m2 = [[GKDouyinModel alloc] init];
    m2.video_id = @"002";
    m2.thumb = @"https://images.pexels.com/videos/9974047/drone-lake-mountains-switzerland-9974047.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
    m2.play_url = @"https://videos.pexels.com/video-files/9974047/9974047-sd_640_360_30fps.mp4";
    m2.ratio = 2;
    [self.models addObject:m2];
    
    GKDouyinModel *m3 = [[GKDouyinModel alloc] init];
    m3.video_id = @"003";
    m3.thumb = @"https://images.pexels.com/videos/11025444/pexels-photo-11025444.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
    m3.play_url = @"https://videos.pexels.com/video-files/11025444/11025444-sd_960_506_30fps.mp4";
    m3.ratio = 2;
    [self.models addObject:m3];
    
    GKDouyinModel *m4 = [[GKDouyinModel alloc] init];
    m4.video_id = @"004";
    m4.thumb = @"https://images.pexels.com/videos/10433263/pexels-photo-10433263.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
    m4.play_url = @"https://videos.pexels.com/video-files/10433263/10433263-sd_360_640_30fps.mp4";
    m4.ratio = 1;
    [self.models addObject:m4];
    
    GKDouyinModel *m5 = [[GKDouyinModel alloc] init];
    m5.video_id = @"005";
    m5.thumb = @"https://images.pexels.com/videos/9909171/pexels-photo-9909171.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
    m5.play_url = @"https://videos.pexels.com/video-files/9909171/9909171-sd_506_960_25fps.mp4";
    m5.ratio = 1;
    [self.models addObject:m5];
    
    GKDouyinModel *m6 = [[GKDouyinModel alloc] init];
    m6.video_id = @"005";
    m6.thumb = @"https://images.pexels.com/videos/10079385/milky-way-sun-10079385.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
    m6.play_url = @"https://videos.pexels.com/video-files/10079385/10079385-sd_540_360_25fps.mp4";
    m6.ratio = 2;
    [self.models addObject:m6];
    
    GKDouyinModel *m7 = [[GKDouyinModel alloc] init];
    m7.video_id = @"005";
    m7.thumb = @"https://images.pexels.com/videos/9871351/pexels-photo-9871351.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
    m7.play_url = @"https://videos.pexels.com/video-files/9871351/9871351-sd_360_640_30fps.mp4";
    m7.ratio = 1;
    [self.models addObject:m7];
    
    GKDouyinModel *m8 = [[GKDouyinModel alloc] init];
    m8.video_id = @"005";
    m8.thumb = @"https://images.pexels.com/videos/10297369/pexels-photo-10297369.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
    m8.play_url = @"https://videos.pexels.com/video-files/10297369/10297369-sd_640_360_24fps.mp4";
    m8.ratio = 2;
    [self.models addObject:m8];
    
    [self.scrollView reloadData];
}

#pragma mark - <GKVideoScrollViewDataSource, GKVideoScrollViewDelegate>
- (NSInteger)numberOfRowsInScrollView:(GKVideoScrollView *)scrollView {
    return self.models.count;
}

- (GKVideoViewCell *)scrollView:(GKVideoScrollView *)scrollView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GKDouyinViewCell *cell = [scrollView dequeueReusableCellWithIdentifier:@"GKDouyinViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell.coverImgView sd_setImageWithURL:[NSURL URLWithString:[self.models[indexPath.row] thumb]]];
    NSInteger ratio = [self.models[indexPath.row] ratio];
    cell.coverImgView.contentMode = ratio == 1 ? UIViewContentModeScaleAspectFill : UIViewContentModeScaleAspectFit;
    return cell;
}

- (void)scrollView:(GKVideoScrollView *)scrollView didEndScrollingCell:(GKDouyinViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    GKDouyinModel *model = self.models[indexPath.row];
    
    // 设置播放内容视图
    if (self.player.containerView != cell.coverImgView) {
        self.player.containerView = cell.coverImgView;
    }
    
    // 设置播放器控制层视图
    if (self.player.controlView != cell.controlView) {
        self.player.controlView = cell.controlView;
    }
    
    // 设置封面图片
    id<ZFPlayerMediaPlayback> manager = self.player.currentPlayerManager;
    [manager.view.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    
    // 播放内容一致，直接返回
    if ([self.player.assetURL.absoluteString isEqualToString:model.play_url]) {
        return;
    }
    
    // 开始播放
    self.player.assetURL = [NSURL URLWithString:model.play_url];
    [self.player.currentPlayerManager play];
}

- (void)scrollView:(GKVideoScrollView *)scrollView didEndDisplayingCell:(GKDouyinViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    GKDouyinModel *model = self.models[indexPath.row];
    if (![self.player.assetURL.absoluteString isEqualToString:model.play_url]) return;
    
    [self.player stop];
}

#pragma mark - GKDoyinViewCellDelegate
- (void)cellDidClickComment:(GKDouyinViewCell *)cell {
    self.containerView = [[UIView alloc] init];
    self.containerView.frame = cell.controlView.bounds;
    self.containerView.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.containerView];
    
    GKDYCommentView *commentView = [[GKDYCommentView alloc] init];
    [commentView showWithContainerView:self.containerView cell:cell];
}

- (void)cellDidClickShare:(GKDouyinViewCell *)cell {
    
}

#pragma mark - Lazy
- (GKVideoScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[GKVideoScrollView alloc] init];
        _scrollView.dataSource = self;
        _scrollView.delegate = self;
        [_scrollView registerClass:GKDouyinViewCell.class forCellReuseIdentifier:@"GKDouyinViewCell"];
    }
    return _scrollView;
}

- (NSMutableArray *)models {
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

@end
