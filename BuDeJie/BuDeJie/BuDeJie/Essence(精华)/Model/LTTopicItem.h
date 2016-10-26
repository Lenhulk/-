//
//  LTTopicItem.h
//  BuDeJie
//
//  Created by Lenhulk on 16/10/25.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    LTTopicItemTypeAll = 1,
    LTTopicItemTypePicture = 10,
    LTTopicItemTypeText = 29,
    LTTopicItemTypeVoice = 31,
    LTTopicItemTypeVideo = 41
} LTTopicItemType;

@interface LTTopicItem : NSObject
//Type
@property (nonatomic, assign) LTTopicItemType type;
/*
 TopView: profile_image，screen_name，text，create_time
 */
@property (nonatomic, strong) NSString *profile_image;
@property (nonatomic, strong) NSString *screen_name;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *create_time;
/*
 MiddleView: View image0 is_gif width height
 */
@property (nonatomic, assign) BOOL is_gif;
@property (nonatomic, assign) BOOL is_bigPicture;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSString *image0;     //主图
/*
 playcount videouri videotime cdn_img playcount voiceuri voicetime
 */
@property (nonatomic, strong) NSString *videouri;
@property (nonatomic, assign) NSInteger videotime;
@property (nonatomic, strong) NSString *playcount;
@property (nonatomic, strong) NSString *cdn_img;

@property (nonatomic, strong) NSString *voiceuri;
@property (nonatomic, assign) NSInteger voicelength;
@end
