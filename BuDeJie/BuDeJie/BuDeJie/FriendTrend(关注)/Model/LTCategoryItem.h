//
//  LTCategoryItem.h
//  BuDeJie
//
//  Created by Lenhulk on 2016/11/3.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTCategoryItem : NSObject
//分类的名字
@property (nonatomic, strong) NSString *name;
//记录选中的用户组
@property (nonatomic, strong) NSString *id;
//保存当前分类对应的用户的模型数组
@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger total_page;
@end
