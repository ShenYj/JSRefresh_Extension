//
//  JSRefresh.m
//  JSRefresh_Extension
//
//  Created by ShenYj on 2016/12/6.
//  Copyright © 2016年 ShenYj. All rights reserved.
//


#import "JSRefreshControl.h"
#import "JSRefreshView.h"


static NSString * const kKeyPath = @"contentOffset";


@interface JSRefreshControl ()

/** 刷新控件的父视图 */
@property (nonatomic,weak) UIScrollView *superScrollView;
/** 自定义视图 */
@property (nonatomic,strong) JSRefreshView *refreshView;

@end

@implementation JSRefreshControl

- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareRefreshView];
    }
    return self;
}

// 准备视图
- (void)prepareRefreshView {
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor orangeColor];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
    
    [self addSubview:self.refreshView];
    self.refreshView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLayoutConstraint *refreshViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.refreshView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self addConstraint:refreshViewBottomConstraint];
    NSLayoutConstraint *refreshViewCenterXConstraint = [NSLayoutConstraint constraintWithItem:self.refreshView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self addConstraint:refreshViewCenterXConstraint];
    NSLayoutConstraint *refreshViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.refreshView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.refreshView.bounds.size.height];
    [self addConstraint:refreshViewHeightConstraint];
    NSLayoutConstraint *refreshViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.refreshView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.refreshView.bounds.size.width];
    [self addConstraint:refreshViewWidthConstraint];
}

// 将要被添加到父视图中时进行监听
-(void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
        self.superScrollView = (UIScrollView *)newSuperview;
        [self.superScrollView addObserver:self forKeyPath:kKeyPath options:NSKeyValueObservingOptionNew context:nil];
        
    }
}
// 从父视图移除时移除监听
- (void)removeFromSuperview {
    [self.superview removeObserver:self forKeyPath:kKeyPath];
    [super removeFromSuperview];
}
// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    CGPoint point = [change[@"new"] CGPointValue];
    CGFloat height = -(self.superScrollView.contentInset.top + point.y);
    if (height >= 0) {
        self.frame = CGRectMake(0, -height, [UIScreen mainScreen].bounds.size.width, height);
    }
    
}
// 开始刷新
- (void)beginRefresh {
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}
// 停止刷新
- (void)endRefresh {
    
}

#pragma mark
#pragma mark - lazy

- (JSRefreshView *)refreshView {
    if (!_refreshView) {
        _refreshView = [[JSRefreshView alloc] init];
        //_refreshView.frame = CGRectMake(0, 0, 200, 50);
    }
    return _refreshView;
}



@end
