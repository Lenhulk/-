//
//  LTRecommandViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 2016/11/3.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTRecommandViewController.h"
#import "LTCategoryItem.h"
#import <MJExtension/MJExtension.h>
#import "LTCategoryCell.h"
#import "LTUserCell.h"
#import "LTUserItem.h"
#import <MJRefresh/MJRefresh.h>

@interface LTRecommandViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic, strong) NSArray *categorys;
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) LTCategoryItem *selectedCategory;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

static NSString * const categoryID = @"category";
static NSString * const userID = @"user";

@implementation LTRecommandViewController

- (AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager lh_manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐关注";
    [self setupTableView];
    [self loadCategoryData];
    [self setupRefreshView];
}

#pragma mark - Setup

/// 设置刷新控件
- (void)setupRefreshView{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsersData)];
    header.automaticallyChangeAlpha = YES;
    _userTableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUserData)];
    footer.automaticallyHidden = YES;
    _userTableView.mj_footer = footer;
}

/// 设置tableView
- (void)setupTableView{
    self.categoryTableView.delegate = self;
    self.categoryTableView.dataSource = self;
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:@"LTCategoryCell" bundle:nil] forCellReuseIdentifier:categoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:@"LTUserCell" bundle:nil] forCellReuseIdentifier:userID];
    
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setExtraCellLineHidden:_categoryTableView];
}

/// 隐藏分类tableView底部空cell的分割线
- (void)setExtraCellLineHidden:(UITableView *)tableView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - LoadData

- (void)loadCategoryData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager lh_manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    
    [manager GET:KBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        //        LTLog(@"%@", responseObject);
        //        [responseObject writeToFile:@"/Users/Lenhulk/Desktop/Recommand.plist" atomically:YES];
        
        _categorys = [LTCategoryItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [_categoryTableView reloadData];
        
        //默认选中分类tableView第0个cell
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_categoryTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            //主动去调用方法(加载数据)
        [self tableView:_categoryTableView didSelectRowAtIndexPath:indexPath];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LTLog(@"ERROR - %@", error);
    }];
}

- (void)loadNewUsersData{
    //记得设置页数为1！！
    _selectedCategory.page = 1;
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = _selectedCategory.id;
    
    [self.manager GET:KBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //记录页数
        _selectedCategory.total_page = [responseObject[@"total_page"] integerValue];
        _selectedCategory.page ++;
        
        [_userTableView.mj_header endRefreshing];
        
        _selectedCategory.users = [LTUserItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [_userTableView reloadData];
        
        //记录的页数超出总页数 隐藏上拉刷新
        _userTableView.mj_footer.hidden = _selectedCategory.page > _selectedCategory.total_page;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LTLog(@"ERROR - %@", error);
    }];
}

- (void)loadMoreUserData{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    //获取当前分类的ID
    parameters[@"category_id"] = _selectedCategory.id;
    parameters[@"page"] = @(_selectedCategory.page);  //需要请求哪一页的内容
    
    [self.manager GET:KBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //结束上拉刷新
        [_userTableView.mj_footer endRefreshing];
        _selectedCategory.page++;
        
        //结束下拉刷新
        [_userTableView.mj_header endRefreshing];
        
        //字典转模型
        NSArray *arr = [LTUserItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //添加下一页的用户组
        [_selectedCategory.users addObjectsFromArray:arr];
        
        [_userTableView reloadData];
        
        //记录的页数超出总页数 隐藏上拉刷新
        _userTableView.mj_footer.hidden = _selectedCategory.page > _selectedCategory.total_page;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LTLog(@"ERROR--%@", error);
    }];
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _categoryTableView){
        //记录选中的分类类型
        _selectedCategory = _categorys[indexPath.row];
        [_userTableView reloadData];
        //隐藏底部的刷新控件
        _userTableView.mj_footer.hidden = _selectedCategory.page > _selectedCategory.total_page;
        
        //判断之前有没有加载过对应的数据
        if (!_selectedCategory.users.count) {
            //如果没有，加载用户数据
            [_userTableView.mj_header beginRefreshing];
    
//            [self loadNewUsersData];
            
//            LTLog(@"%@", _selectedCategory.name);
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _categoryTableView) return 44;
    return 60;
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == _categoryTableView) return _categorys.count;
    return _selectedCategory.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _categoryTableView) {
        LTCategoryCell *cell = [_categoryTableView dequeueReusableCellWithIdentifier:categoryID];
        cell.categoryItem = _categorys[indexPath.row];
        return cell;
    }
    
    LTUserCell *cell = [_userTableView dequeueReusableCellWithIdentifier:userID];
    cell.user = _selectedCategory.users[indexPath.row];
    return cell;
}



@end
