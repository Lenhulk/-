//
//  LTSubTagViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/20.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTSubTagViewController.h"
#import "LTSubTagItem.h"
#import "LTTagCell.h"
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD.h>

#define SystemVersion [[UIDevice currentDevice].systemVersion floatValue]

@interface LTSubTagViewController ()
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, weak) AFHTTPSessionManager *sessionMgr;
@end

static NSString *const ID = @"cell1";

@implementation LTSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载网络数据
    [self loadData];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LTTagCell" bundle:nil] forCellReuseIdentifier:ID];
    
//    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    //取消系统分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置tableView背景色
    self.tableView.backgroundColor = [UIColor lightGrayColor];
}

- (void)loadData{
    [SVProgressHUD showWithStatus:@"正在以吃翔的力气加载数据..."];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    _sessionMgr = manager;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    
    //模拟网络延迟
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        [manager GET:KBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray * _Nullable responseObject) {
            //        LTLog(@"%@", responseObject);
            //        [responseObject writeToFile:@"/Users/Lenhulk/Desktop/sub.plist" atomically:YES];
            [SVProgressHUD dismiss];
            
            //通过查看数据可知responseObject原来是数组类型，直接在上面参数中修改为NSArray
            _tags = [LTSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
            
            //刷新表格
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            LTLog(@"%@", error);
            
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"数据加载失败！请检查网络"];
        }];
        
//    });
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    //取消会话请求
    [_sessionMgr.tasks makeObjectsPerformSelector:@selector(cancel)];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LTTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
//    if (SystemVersion >= 8.0) {
//        cell.layoutMargins = UIEdgeInsetsZero;
//    }
    
    cell.subTagItem = _tags[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60 + 5;
}


@end
