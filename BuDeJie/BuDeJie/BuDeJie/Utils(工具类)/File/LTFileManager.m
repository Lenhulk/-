//
//  LTFileManager.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/23.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTFileManager.h"

@implementation LTFileManager

+ (void)removeDirectoryPath:(NSString *)directoryPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL isExists = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isDirectory || !isExists) {
        //抛出异常
        NSException *excp = [NSException exceptionWithName:directoryPath reason:[NSString stringWithFormat:@"小笨蛋，\"%@\"路径不存在，或者不是一个文件夹路径", directoryPath] userInfo:nil];
        [excp raise];
    }
    
    [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (void)getDirectorySize:(NSString *)directoryPath completion:(void (^)(NSInteger ))completion{
    
    //开子线程处理计算，防止点击时当前页面卡顿
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //容错处理
        //获取文件管理者
        NSFileManager *manager = [NSFileManager defaultManager];
        BOOL isDirectory = NO;
        BOOL isExists = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
        if (!isDirectory || !isExists) {
            //抛出异常
            @throw [NSException exceptionWithName:directoryPath reason:[NSString stringWithFormat:@"小笨蛋，\"%@\"路径不存在，或者不是一个文件夹路径", directoryPath] userInfo:nil];
        }
        //总大小
        NSUInteger totalSize = 0;
        //获取路径下的子文件夹
        NSArray *subPaths = [manager subpathsAtPath:directoryPath];
        //遍历
        for (NSString *fileName in subPaths) {
            NSString *fullPath = [directoryPath stringByAppendingPathComponent:fileName];
            //隐藏文件不处理
            if ([fullPath containsString:@".DS"]) continue;
            //判断是否是文件夹
            BOOL isDirectory = NO;
            BOOL isExists = [manager fileExistsAtPath:fullPath isDirectory:&isDirectory];
            if (isDirectory || !isExists) continue;
            
            NSDictionary *attr = [manager attributesOfItemAtPath:fullPath error:nil];
            totalSize += [attr fileSize];
        }
        
        //在主线程刷新UI
        dispatch_sync(dispatch_get_main_queue(), ^{
            //当totalSize有结果时才调用completion这个block方法同时传值
            if (completion) {
                completion(totalSize);
            }
        });
    });
}

+ (void)directorySizeString:(NSString *)directoryPath completion:(void (^)(NSString *))strCompletion{
    
    [LTFileManager getDirectorySize:directoryPath completion:^(NSInteger totalSize) {
        
        NSString *str = @"清除缓存";
        
        NSInteger size = totalSize;
        
        if (size >= 1000 * 1000) {
            CGFloat sizeF = size / 1000.0 / 1000.0;
            str = [NSString stringWithFormat:@"%@(%.1fMB)", str, sizeF];
            
        } else if (size >= 1000) {
            CGFloat sizeF = size / 1000.0;
            str = [NSString stringWithFormat:@"%@(%.1fKB)", str, sizeF];
            
        } else if (size > 0){
            str = [NSString stringWithFormat:@"%@(%ldB)", str, (long)size];
        }
        
        str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
        
        if (strCompletion) {
            strCompletion(str);
        }
    }];

}
@end
