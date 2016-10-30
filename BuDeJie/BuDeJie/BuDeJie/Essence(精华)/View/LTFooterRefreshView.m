//
//  LTFooterRefreshView.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/29.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTFooterRefreshView.h"

@interface LTFooterRefreshView ()
@property (weak, nonatomic) IBOutlet UILabel *labelView;
@property (weak, nonatomic) IBOutlet UIView *refreshView;
@end

@implementation LTFooterRefreshView

- (void)setIsRefreshing:(BOOL)isRefreshing{
    _isRefreshing = isRefreshing;
    _labelView.hidden = isRefreshing;
    _refreshView.hidden = !isRefreshing;
}

+ (instancetype)footerRefreshView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

@end
