//
//  LTCommentItem.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/27.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTCommentItem.h"
#import "LTUserItem.h"

@implementation LTCommentItem

- (NSString *)totalContent{
    NSString* totalContent = [NSString stringWithFormat:@"%@: %@",self.user.username, self.content];

    return totalContent;
}

@end
