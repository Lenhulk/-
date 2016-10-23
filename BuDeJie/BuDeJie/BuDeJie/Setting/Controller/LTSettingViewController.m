//
//  LTSettingViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/17.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTSettingViewController.h"
#import <SDImageCache.h>
#define KCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
static NSString * const ID = @"cell";

@interface LTSettingViewController ()

@end


@implementation LTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSInteger fileSize = [[SDImageCache sharedImageCache] getSize];//获取的是Cache文件夹中default(存放的是图片缓存)的文件夹尺寸
//    LTLog(@"%ld--%ld", fileSize, mySize);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = [self sizeStr];
    
    return cell;
}

//点击时清理缓存
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[NSFileManager defaultManager] removeItemAtPath:KCachePath error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:KCachePath withIntermediateDirectories:YES attributes:nil error:nil];
    [self.tableView reloadData];
}

//清除缓存cell文字显示数据
- (NSString *)sizeStr{
    NSString *str = @"清除缓存";
    NSInteger size = [self getSize];  //获取的是整个Cache(缓存)文件夹的尺寸
    if (size >= 1000 * 1000) {
        CGFloat sizeF = size / 1000.0 / 1000.0;
        str = [NSString stringWithFormat:@"%@(%.1fMB)", str, sizeF];
    } else if (size >= 1000) {
        CGFloat sizeF = size / 1000.0;
        str = [NSString stringWithFormat:@"%@(%.1fKB)", str, sizeF];
    } else if (size > 0){
        str = [NSString stringWithFormat:@"%@(%ldB)", str, size];
    }
    str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
    return str;
}

//获取缓存文件夹总大小
- (NSInteger)getSize{
    //获取缓存路径
    NSString *cachePath = KCachePath;
//    LTLog(@"%@", cachePath);
    //获取文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    //获取路径下的子文件夹
    NSArray *subPath = [manager subpathsAtPath:cachePath];
    
    NSUInteger totalSize = 0;
    //遍历
    for (NSString *file in subPath) {
        NSString *fullPath = [cachePath stringByAppendingPathComponent:file];
        //隐藏文件不处理
        if ([fullPath containsString:@".DS"]) continue;
        //判断是否是文件夹
        BOOL isDirectory = NO;
        BOOL isExists = [manager fileExistsAtPath:fullPath isDirectory:&isDirectory];
        if (isDirectory || !isExists) continue;
        
        NSDictionary *attr = [manager attributesOfItemAtPath:fullPath error:nil];
        totalSize += [attr fileSize];
    }
    return totalSize;
}


@end
