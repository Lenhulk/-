//
//  LTHeaderRefreshView.h
//  BuDeJie
//
//  Created by Lenhulk on 16/10/29.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTHeaderRefreshView : UIView
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isNeedLoading;
+ (instancetype)headerRefreshView;
@end
