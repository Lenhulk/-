//
//  LTHeaderRefreshView.h
//  BuDeJie
//
//  Created by Lenhulk on 16/10/29.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTHeaderRefreshView : UIView

/**是否正在刷新*/
@property (nonatomic, assign) BOOL isRefreshing;
/**是否需要加载*/
@property (nonatomic, assign) BOOL isNeedLoading;

+ (instancetype)headerRefreshView;

@end
