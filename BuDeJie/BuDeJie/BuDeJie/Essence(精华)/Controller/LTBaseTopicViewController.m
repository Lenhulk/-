//
//  LTBaseTopicViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/30.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTBaseTopicViewController.h"
#import "LTNewViewController.h"
#import "LTTopicCell.h"

#import <MJExtension/MJExtension.h>
#import "LTTopicViewModel.h"
#import "LTPhotoManager.h"
#import "UIView+LTFetch.h"

//#import <MJRefresh/MJRefresh.h>
#import "LTFooterRefreshView.h"
#import "LTHeaderRefreshView.h"


static NSString *const ID = @"cell";

@interface LTBaseTopicViewController ()
@property (nonatomic, strong) NSMutableArray *topicsVM;
@property (nonatomic, strong) NSString *maxTime;
@property (nonatomic, weak) LTFooterRefreshView *footerRefreshView;
@property (nonatomic, weak) LTHeaderRefreshView *headerRefreshView;
@property (nonatomic, assign) UIEdgeInsets oriInsets;
@property (nonatomic, weak) AFHTTPSessionManager *mgr;
@end

@implementation LTBaseTopicViewController

#pragma mark - LazyLoading

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

#pragma mark - 重复点击Tab时调用reload

- (void)reload{

    //取到当前窗口上的TableView刷新（防止全部刷新）
//    UITableView *tableView = [[UIApplication sharedApplication].keyWindow fetchTableView];
    //    [tableView.mj_header beginRefreshing];
    
    //iOS10中没法用self.view.window判断控件是否在当前窗口
//    if (self.view.window){    // 只要一个View在窗口上，肯定能拿到窗口
//        [self.tableView.mj_header beginRefreshing];
//                LTLog(@"%@", self);//检验哪个控制器刷新
//    }
}

#pragma mark - 控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消分割线
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    // 只要通过registerClass，TableViewCell就是通过initWithStyle
    [self.tableView registerClass:[LTTopicCell class] forCellReuseIdentifier:ID];
    
    //网络数据
    [self loadNewData];
    
    //设置滚动插入
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    _oriInsets = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    
    //添加刷新控件
//    [self setupRefreshView];
    [self setupHeadRefreshView];
    [self setupFootRefreshView];
    
    //监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload) name:@"repeatClickTab" object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 刷新控件的SETUP方法

//- (void)setupRefreshView{
//    MJRefreshNormalHeader *headerView = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    headerView.automaticallyChangeAlpha = YES;
//    self.tableView.mj_header = headerView;
//
//    MJRefreshAutoNormalFooter *footerView = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    footerView.automaticallyHidden = YES;
//    self.tableView.mj_footer = footerView;
//}

- (void)setupHeadRefreshView{
    LTHeaderRefreshView *headerView = [LTHeaderRefreshView headerRefreshView];
    headerView.lh_y = -headerView.lh_height;
    _headerRefreshView = headerView;
    [self.tableView addSubview:headerView];
}

- (void)setupFootRefreshView{
    LTFooterRefreshView *footerView = [LTFooterRefreshView footerRefreshView];
    footerView.isRefreshing = NO;
    _footerRefreshView = footerView;
    self.tableView.tableFooterView = footerView;
}
 
#pragma mark - ScrollView（Delegate） 处理刷新方法

///在拉动的时候实现刷新
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 处理上拉控件
    [self dealFootRefreshView];
    // 处理下拉控件
    [self dealHeaderRefreshView];
}

- (void)dealHeaderRefreshView{
    //计算偏移量
    CGFloat offsetY = self.tableView.contentOffset.y;   //负值
    CGFloat fullViewY = self.tableView.contentInset.top + _headerRefreshView.lh_height;     //HeaderView完全显示时的偏移量
    
    //计算透明度，设置渐变透明
    CGFloat a = -(99.0 + offsetY) * 0.02;
    self.headerRefreshView.alpha = a;
    
    //是否需要加载数据
    if (-offsetY >= fullViewY) {    //HeaderView完全显示
        _headerRefreshView.isNeedLoading = YES;
    } else {
        _headerRefreshView.isNeedLoading = NO;
    }
}

- (void)dealFootRefreshView{
    if (self.topicsVM.count == 0) return;   //没有数据的时候，控件不出现（加载前隐藏）
    if (_footerRefreshView.isRefreshing == YES) return;   //正在加载数据的时候不加载
    //判断控件是否全部显示
    CGFloat offsetY = self.tableView.contentOffset.y;
    if (offsetY > self.tableView.contentSize.height + self.tableView.contentInset.bottom - KScreenH) {
        _footerRefreshView.isRefreshing = YES;
        [self loadMoreData];
    }
}
 
//松开手指才刷新数据，悬停效果
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_headerRefreshView.isNeedLoading) {
        _headerRefreshView.isRefreshing = YES;
        //悬停：设置额外滚动区域
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(_oriInsets.top + _headerRefreshView.lh_height, 0, _oriInsets.bottom, 0);
        }];
        [self loadNewData];
        _headerRefreshView.isNeedLoading = NO;
    }
}


#pragma mark - LoadData

- (void)loadNewData{
    
    //取消之前的网络请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * a = @"list";
    //判断是否是新帖控制器
    if ([self.parentViewController isKindOfClass:[LTNewViewController class]]) {
        a = @"newlist";
    }
    
    parameters[@"a"] = a;
    parameters[@"c"] = @"data";
    parameters[@"type"] = self.type;
    
    [self.mgr GET:KBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        LTLog(@"RESPONSEOBJ\n\n\n%@", responseObject);
        //结束刷新
//        [self.tableView.mj_header endRefreshing];
        
        //结束刷新
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.contentInset = _oriInsets;
        }];
        _headerRefreshView.isRefreshing = NO;
        _footerRefreshView.hidden = NO;
        
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
        LTLog(@"ERROR-\n\n\n%@", error);
    }];
}

- (void)loadMoreData{
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString * a = @"list";
    if ([self.parentViewController isKindOfClass:[LTNewViewController class]]) {
        a = @"newlist";
    }
    parameters[@"a"] = a;
//    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = _type;
    parameters[@"maxtime"] = _maxTime;
    
    [self.mgr GET:KBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
        //结束尾部刷新
//        [self.tableView.mj_footer endRefreshing];
        
        //结束尾部刷新
        _footerRefreshView.isRefreshing = NO;
        
        //保存下一页的最大ID
        _maxTime = responseObject[@"info"][@"maxtime"];
        
        NSArray *topics = [LTTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        for (LTTopicItem *item in topics) {
            LTTopicViewModel *topicVm = [[LTTopicViewModel alloc] init];
            topicVm.item = item;
            [self.topicsVM addObject:topicVm];
        }
        
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
    
//    LTTopicCell *cell = [[LTTopicCell alloc] init];
    cell.vm = self.topicsVM[indexPath.row] ;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_topicsVM[indexPath.row] cellH] + 10;
}


@end
