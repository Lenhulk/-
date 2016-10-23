//
//  LTFileManager.h
//  BuDeJie
//
//  Created by Lenhulk on 16/10/23.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  处理文件
 */
@interface LTFileManager : NSObject

/**
 *  指定一个文件夹并删除其所有内容
 *  @param directoryPath 文件夹路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

/**
 *  获取一个文件夹内容总大小
 *  @param directoryPath 文件夹路径
 *  @return 文件夹内容大小
 */
+ (void)getDirectorySize:(NSString *)directoryPath completion:(void(^)(int))completion;

/**
 指定一个文件夹路径，直接帮你获取当前文件夹尺寸字符串
 */
+ (void)directorySizeString:(NSString *)directoryPath completion:(void(^)(NSString *))strCompletion;

@end
