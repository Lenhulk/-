//
//  LTBaseTopicView.h
//  BuDeJie
//
//  Created by Lenhulk on 16/10/25.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTTopicItem;
@interface LTBaseTopicView : UIView
@property (nonatomic, strong) LTTopicItem *item;
+ (instancetype)viewForXib;

@end
