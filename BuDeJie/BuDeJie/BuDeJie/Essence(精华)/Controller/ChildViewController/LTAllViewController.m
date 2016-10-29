//
//  LTAllViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/23.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTAllViewController.h"
#import "LTTopicCell.h"
#import "LTTopicItem.h"
#import <MJExtension/MJExtension.h>
#import "LTTopicViewModel.h"
#import "LTPhotoManager.h"
#import <MJRefresh/MJRefresh.h>

static NSString *const ID = @"cell";

@interface LTAllViewController ()
@property (nonatomic, strong) NSMutableArray *topicsVM;
@property (nonatomic, strong) NSString *maxTime;
@property (nonatomic, weak) AFHTTPSessionManager *mgr;
@end

@implementation LTAllViewController

- (AFHTTPSessionManager *)mgr{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager lh_manager];
    }
    return _mgr;
}

- (NSMutableArray *)topicsVM{
    if (_topicsVM == nil) {
        _topicsVM = [NSMutableArray array];
    }
    return _topicsVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    // 只要通过registerClass，TableViewCell就是通过initWithStyle
    [self.tableView registerClass:[LTTopicCell class] forCellReuseIdentifier:ID];
    
    //网络数据
    [self loadNewData];
    
    //设置供拉动刷新的额外滚动范围
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    
    //添加上下拉刷新
    [self setupRefreshView];
}

- (void)setupRefreshView{
    
    //下拉刷新
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    refreshHeader.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = refreshHeader;
    
    //上拉加载
    MJRefreshAutoNormalFooter *refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    refreshFooter.automaticallyHidden = YES;
    self.tableView.mj_footer = refreshFooter;
}

- (void)loadMoreData{
    //取消之前的网络请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager lh_manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(LTTopicItemTypePicture);
    parameters[@"maxtime"] = _maxTime;
    
    [self.mgr GET:KBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
        //        [responseObject writeToFile:@"/Users/Lenhulk/Desktop/voice.plist" atomically:YES];
        
        //结束头部刷新
        [self.tableView.mj_footer endRefreshing];
        
        //保存下一页的最大ID
        _maxTime = responseObject[@"info"][@"maxtime"];
        
        //字典数组 转 模型数组
        NSArray *topics = [LTTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //模型 转 视图模型
        for (LTTopicItem *item in topics) {
            LTTopicViewModel *topicVm = [[LTTopicViewModel alloc] init];
            topicVm.item = item;            //赋值，在set方法计算cell高度
            [self.topicsVM addObject:topicVm];  //保存记录VM
        }
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LTLog(@"ERROR-%@", error);
    }];
}

- (void)loadNewData{
    //取消之前的网络请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];

//    AFHTTPSessionManager *manager = [AFHTTPSessionManager lh_manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(LTTopicItemTypePicture);
    
    [self.mgr GET:KBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
//        [responseObject writeToFile:@"/Users/Lenhulk/Desktop/voice.plist" atomically:YES];
        
        //结束头部刷新
        [self.tableView.mj_header endRefreshing];
        
        //保存下一页的最大ID
        _maxTime = responseObject[@"info"][@"maxtime"];
        
        //字典数组 转 模型数组
        NSArray *topics = [LTTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //模型 转 视图模型
        NSMutableArray *arr = [NSMutableArray array];
        for (LTTopicItem *item in topics) {
            LTTopicViewModel *topicVm = [[LTTopicViewModel alloc] init];
            topicVm.item = item;            //赋值，在set方法计算cell高度
            [arr addObject:topicVm];  //保存新记录VM
        }
        self.topicsVM = arr;    //用新内容代替旧内容
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LTLog(@"ERROR-%@", error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicsVM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LTTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];

//    cell.item = [self.topics[indexPath.row] item];
    cell.vm = self.topicsVM[indexPath.row] ;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_topicsVM[indexPath.row] cellH] + 10;
}


@end
