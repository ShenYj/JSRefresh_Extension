//
//  JSRefreshView.m
//  JSRefresh_Extension
//
//  Created by ShenYj on 2016/12/6.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSRefreshView.h"

/** 最左侧控件距离父控件的间距(LeftImageView) */
static CGFloat const kLeftMargin = 20.f;
/** 左侧图片框的宽高 */
static CGFloat const kLeftImageViewWidth = 15.f;
static CGFloat const kLeftImageViewHeight = 40.f;
/** 文本描述内容 */
static NSString * const kDetailTextLabelContent = @"下拉刷新...";
/** 下拉刷新视图(JSRefreshView)自身宽高参数 */
static CGFloat const kRefreshViewWidth = 220.f;
static CGFloat const kRefreshViewHeight = 60.f;
/** 右侧图片框的宽高 */
static CGFloat const kRightImageViewWidth = 60.f;
static CGFloat const kRigthImageViewHeight = 60.f;

@interface JSRefreshView ()

/** 左侧图片框 */
@property (nonatomic,strong) UIImageView *leftImageView;
/** 文字描述 */
@property (nonatomic,strong) UILabel *descriptionLabel;
/** 指示器 */
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;
/** 右侧图片框 */
@property (nonatomic,strong) UIImageView *rightImageView;

@end

@implementation JSRefreshView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareRefreshView];
    }
    return self;
}

- (void)setRefreshStatus:(JSRefreshStatus)refreshStatus {
    _refreshStatus = refreshStatus;
    
    switch (refreshStatus) {
        case JSRefreshStatusNormal:
            self.descriptionLabel.text = @"继续使劲拉...";
            break;
        case JSRefreshStatusPulling:
            self.descriptionLabel.text = @"松手将刷新...";
            break;
        case JSRefreshStatusWillRefresh:
            self.descriptionLabel.text = @"正在刷新中...";
            [self.indicatorView startAnimating];
            
            break;
        default:
            break;
    }
}

- (void)prepareRefreshView {
    
    self.frame = CGRectMake(0, 0, kRefreshViewWidth, kRefreshViewHeight);
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.leftImageView];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.indicatorView];
    [self addSubview:self.rightImageView];
    
    // 设置刷新控件初始状态
    self.refreshStatus = JSRefreshStatusNormal;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.leftImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    self.rightImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *leftImageViewLeftConstraint = [NSLayoutConstraint constraintWithItem:self.leftImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:kLeftMargin];
    [self addConstraint:leftImageViewLeftConstraint];
    NSLayoutConstraint *leftImageViewCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.leftImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraint:leftImageViewCenterYConstraint];
    NSLayoutConstraint *leftImageViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.leftImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:kLeftImageViewWidth];
    [self addConstraint:leftImageViewWidthConstraint];
    NSLayoutConstraint *leftImageViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.leftImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:kLeftImageViewHeight];
    [self addConstraint:leftImageViewHeightConstraint];
    
    NSLayoutConstraint *descriptionLabelLeftConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.leftImageView attribute:NSLayoutAttributeRight multiplier:1 constant:kLeftMargin];
    [self addConstraint:descriptionLabelLeftConstraint];
    NSLayoutConstraint *descriptionLabelCenterYConstrait = [NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraint:descriptionLabelCenterYConstrait];
    
    NSLayoutConstraint *indicatorViewCenterX = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.leftImageView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self addConstraint:indicatorViewCenterX];
    NSLayoutConstraint *indicatorViewCenterY = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.leftImageView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraint:indicatorViewCenterY];
    
    NSLayoutConstraint *rightImageViewLeftConstraint = [NSLayoutConstraint constraintWithItem:self.rightImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.descriptionLabel attribute:NSLayoutAttributeRight multiplier:1 constant:kLeftMargin];
    [self addConstraint:rightImageViewLeftConstraint];
    NSLayoutConstraint *rightImageViewCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.rightImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.leftImageView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraint:rightImageViewCenterYConstraint];
    NSLayoutConstraint *rightImageViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.rightImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:kRightImageViewWidth];
    [self addConstraint:rightImageViewWidthConstraint];
    NSLayoutConstraint *rightImageViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.rightImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:kRigthImageViewHeight];
    [self addConstraint:rightImageViewHeightConstraint];
    
}


#pragma mark 
#pragma mark - lazy

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"arrow"];
    }
    return _leftImageView;
}
- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont systemFontOfSize:16];
        _descriptionLabel.textColor = [UIColor blackColor];
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel.text = kDetailTextLabelContent;
        [_descriptionLabel sizeToFit];
    }
    return _descriptionLabel;
}
- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _indicatorView;
}
- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"assets.bundle" ofType:nil];
        NSBundle *assetsBundle = [NSBundle bundleWithPath:path];
        _rightImageView.image = [UIImage imageNamed:@"refreshImg.gif" inBundle:assetsBundle compatibleWithTraitCollection:nil];
    }
    return _rightImageView;
}

@end
