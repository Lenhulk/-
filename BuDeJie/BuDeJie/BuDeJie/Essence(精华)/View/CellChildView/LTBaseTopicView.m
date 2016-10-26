//
//  LTBaseTopicView.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/25.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTBaseTopicView.h"

@implementation LTBaseTopicView

//Cell的基类

+ (instancetype)viewForXib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] [0];
}

@end
