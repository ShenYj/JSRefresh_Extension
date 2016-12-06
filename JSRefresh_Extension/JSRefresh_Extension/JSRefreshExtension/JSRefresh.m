//
//  JSRefresh.m
//  JSRefresh_Extension
//
//  Created by ShenYj on 2016/12/6.
//  Copyright © 2016年 ShenYj. All rights reserved.
//


#import "JSRefresh.h"
// 自身高度
static CGFloat const kRefreshControlToolHeight = 0.f;

@interface JSRefresh ()

//刷新控件的父视图
@property (nonatomic,weak) UIScrollView *superView;

@end

@implementation JSRefresh

- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareRefreshView];
    }
    return self;
}

// 准备视图
- (void)prepareRefreshView {
    self.backgroundColor = [UIColor orangeColor];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kRefreshControlToolHeight);
}

// 将要被添加到父视图中时
-(void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
        self.superView = (UIScrollView *)newSuperview;
        [self.superView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    CGPoint point = [change[@"new"] CGPointValue];
    CGFloat height = -(self.superView.contentInset.top + point.y);
    self.frame = CGRectMake(0, -height, [UIScreen mainScreen].bounds.size.width, height);
    
}

- (void)beginRefresh {
    
}

- (void)endRefresh {
    
}

- (void)dealloc {
    [self.superView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
