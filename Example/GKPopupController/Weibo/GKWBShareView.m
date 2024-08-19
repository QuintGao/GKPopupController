//
//  GKWBShareView.m
//  Example
//
//  Created by QuintGao on 2024/7/31.
//  Copyright © 2024 QuintGao. All rights reserved.
//

#import "GKWBShareView.h"
#import <GKPopupController/GKPopupController.h>
#import <Masonry/Masonry.h>

static GKPopupController *_popupVC;

@interface GKWBShareView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GKWBShareView

+ (void)show {
    [[[GKWBShareView alloc] init] show];
}

- (void)show {
    GKPopupController *popupVC = [[GKPopupController alloc] initWithContentView:self];
//    popupVC.popupType = GKPopupType_Scroll;
    popupVC.contentHeight = 500;
    popupVC.topCornerRadius = 10;
    [popupVC show];
    popupVC.dismissBlock = ^{
        _popupVC = nil;
    };
    _popupVC = popupVC;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.bottom.equalTo(self).offset(-(20 + GK_SAFEAREA_BTM));
        make.left.right.equalTo(self);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.redColor;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"");
}

#pragma mark - lazy
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 300);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = UIColor.clearColor;
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
        _collectionView.alwaysBounceHorizontal = YES;
    }
    return _collectionView;
}

@end
