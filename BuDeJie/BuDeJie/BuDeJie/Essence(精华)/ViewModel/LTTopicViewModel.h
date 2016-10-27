//
//  LTTopicViewModel.h
//  BuDeJie
//
//  Created by Lenhulk on 16/10/25.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTTopicItem;

@interface LTTopicViewModel : NSObject

@property (nonatomic, strong) LTTopicItem *item;

@property (nonatomic, assign) CGRect topViewFrame;
@property (nonatomic, assign) CGFloat cellH;
@property (nonatomic, assign) CGRect middleViewFrame;
@property (nonatomic, assign) CGRect commentViewFrame;
@property (nonatomic, assign) CGRect bottomViewFrame;
@end
