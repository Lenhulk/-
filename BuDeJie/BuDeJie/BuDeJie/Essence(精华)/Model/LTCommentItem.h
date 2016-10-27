//
//  LTCommentItem.h
//  BuDeJie
//
//  Created by Lenhulk on 16/10/27.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LTUserItem;
@interface LTCommentItem : NSObject
/**
 *  voicetime voiceuri user(d) conntent
 */
@property (nonatomic, strong) NSString *voicetime;
@property (nonatomic, strong) NSString *voiceuri;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) LTUserItem *user;

@property (nonatomic, strong) NSString *totalContent;
@end
