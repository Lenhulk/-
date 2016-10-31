//
//  LTHeaderRefreshView.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/29.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTHeaderRefreshView.h"
@interface LTHeaderRefreshView ()
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelView;
@property (weak, nonatomic) IBOutlet UIView *loadView;

@end

@implementation LTHeaderRefreshView

- (void)setIsRefreshing:(BOOL)isRefreshing{
    _isRefreshing = isRefreshing;
    _arrowImageView.hidden = isRefreshing;
    _labelView.hidden = isRefreshing;
    _loadView.hidden = !isRefreshing;
}

- (void)setIsNeedLoading:(BOOL)isNeedLoading{
    _isNeedLoading = isNeedLoading;
    _labelView.text = isNeedLoading?@"松开手我就刷新":@"你再下拉我就刷新了";
    [UIView animateWithDuration:0.25 animations:^{
        _arrowImageView.transform = isNeedLoading?CGAffineTransformMakeRotation(M_PI + 0.0001):CGAffineTransformIdentity;
    }];
}

+ (instancetype)headerRefreshView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}
@end
