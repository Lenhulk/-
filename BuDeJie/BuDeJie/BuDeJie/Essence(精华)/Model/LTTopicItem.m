//
//  LTTopicItem.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/25.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTTopicItem.h"
#import "LTCommentItem.h"
#import <MJExtension/MJExtension.h>

@implementation LTTopicItem


+ (NSDictionary *)mj_objectClassInArray{
    return @{@"top_cmt" : @"LTCommentItem"};
}

- (void)setTop_cmt:(NSArray *)top_cmt{
    
    _top_cmt = top_cmt;
    
    if (_top_cmt.count) {
//        NSDictionary *dict = _top_cmt.firstObject;
//        _topComment = [LTCommentItem mj_objectWithKeyValues:dict];
        
        _topComment = top_cmt.firstObject;
    }
    
}

@end
