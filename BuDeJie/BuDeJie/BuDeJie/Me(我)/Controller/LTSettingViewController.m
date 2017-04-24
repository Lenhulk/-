//
//  LTSettingViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/17.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTSettingViewController.h"
#import <SDImageCache.h>
#import "LTFileManager.h"
#import <SVProgressHUD.h>

static NSString * const ID = @"cell";

@interface LTSettingViewController ()
@property (nonatomic, strong) NSString *str;
@end


@implementation LTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD showWithStatus:@"正在计算缓存大小..."];
    
    [LTFileManager directorySizeString:KCachePath completion:^(NSString *str) {
        
        LTLog(@"%@", KCachePath);
        
        [SVProgressHUD dismiss];
        _str = str;
        [self.tableView reloadData];
    }];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSInteger fileSize = [[SDImageCache sharedImageCache] getSize];//获取的是Cache文件夹中default(存放的是图片缓存)的文件夹尺寸
//    LTLog(@"%ld--%ld", fileSize, mySize);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = _str;
    
    return cell;
}

//点击时清理缓存
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [LTFileManager removeDirectoryPath:@"nimei"];//测试容错处理
    
    if(indexPath.section == 0)
        [LTFileManager removeDirectoryPath:KCachePath];
    
    _str = @"缓存清理完毕";
    
    //刷新表格
    [self.tableView reloadData];
}




@end
