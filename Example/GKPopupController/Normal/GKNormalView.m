//
//  GKNormalView.m
//  Example
//
//  Created by QuintGao on 2024/7/30.
//  Copyright © 2024 QuintGao. All rights reserved.
//

#import "GKNormalView.h"
#import <Masonry/Masonry.h>
#import <GKPopupController/GKPopupController.h>

static GKPopupController *_popupVC;

@interface GKNormalView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UILabel *cancelLabel;

@end

@implementation GKNormalView

+ (void)show {
    [[[GKNormalView alloc] init] show];
}

- (void)show {
    GKPopupController *vc = [[GKPopupController alloc] initWithContentView:self];
    vc.contentHeight = 500;
    vc.dismissBlock = ^{
        _popupVC = nil;
    };
    [vc show];
    _popupVC = vc;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.topView];
    [self addSubview:self.tableView];
    [self addSubview:self.cancelBtn];
    [self.cancelBtn addSubview:self.cancelLabel];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(6);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.topView.mas_bottom).offset(5);
        make.bottom.equalTo(self.cancelBtn.mas_top);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(SAFE_AREA_BTM + 40);
    }];
    
    [self.cancelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.cancelBtn);
        make.height.mas_equalTo(40);
    }];
}

- (void)cancelAction {
    [_popupVC dismiss];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行", indexPath.row + 1];
    return cell;
}

#pragma mark - lazy
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = UIColor.lightGrayColor;
        _topView.layer.cornerRadius = 3;
        _topView.layer.masksToBounds = YES;
    }
    return _topView;
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

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = UIColor.grayColor;
        [_cancelBtn addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self->_cancelBtn);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _cancelBtn;
}

- (UILabel *)cancelLabel {
    if (!_cancelLabel) {
        _cancelLabel = [[UILabel alloc] init];
        _cancelLabel.font = [UIFont systemFontOfSize:14];
        _cancelLabel.textColor = UIColor.blackColor;
        _cancelLabel.text = @"取消";
        _cancelLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _cancelLabel;
}

@end
