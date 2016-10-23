//
//  LTMeViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/15.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTMeViewController.h"
#import "LTSettingViewController.h"
#import "LTSquareCell.h"
#import <MJExtension/MJExtension.h>
#import "LTSquareItem.h"
#import <SafariServices/SafariServices.h>
#import "LTWebViewController.h"

#define itemWH ((KScreenW - 3 * margin)/ cols)
static NSString * const ID = @"Cell";
static NSInteger const cols = 4;
static CGFloat const margin = 1;

@interface LTMeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, SFSafariViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *squareList;
@property (nonatomic, weak) UICollectionView *collectionView;
@end


@implementation LTMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNavBar];
    
    //设置collectionView
    [self setupFooterView];
    
    //请求网络数据
    [self loadData];
    
    //设置组间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

- (void)setupNavBar{
    
    self.navigationItem.title = @"我";
    
    UIBarButtonItem *nightMode = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(nightClick:)];
    
    UIBarButtonItem *setting = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] hightLightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingClick)];
    
    self.navigationItem.rightBarButtonItems = @[setting, nightMode];
}

- (void)setupFooterView{
    
    //初始化流水布局
    UICollectionViewFlowLayout *flowLayout = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
        flowLayout.minimumLineSpacing = margin;
        flowLayout.minimumInteritemSpacing = margin;
        flowLayout;
    });
    
    //创建collectionView
    UICollectionView *collectionV = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.dataSource = self;
        collectionView.delegate =  self;
        [collectionView registerNib:[UINib nibWithNibName:@"LTSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];   //注册cell
        _collectionView = collectionView;
        collectionView;
    });
    
    
    //添加到父控件到FoolerView
    self.tableView.tableFooterView = collectionV;
    
}

- (void)loadData{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager lh_manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";

    [mgr GET:KBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
        _squareList = [LTSquareItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        //补齐缺口
        [self resloveData];
        
        //计算总行数，得出总高度，让tableview的子控件collectionview内容的高度和自身高度相同，就不会出现划动页面导致子控件collectionview滚动令父控件不动的问题
        NSInteger rows = (self.squareList.count - 1) / cols + 1;
        CGFloat collectionH = rows * itemWH + (rows - 1) * margin;
        self.collectionView.lh_height = collectionH;
        
        //传给子控件间接设置滚动范围
        self.tableView.tableFooterView = self.collectionView;
        
        //刷新表格
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LTLog(@"ERROR--%@", error);
    }];
}

- (void)resloveData{
    NSInteger count = self.squareList.count;
    NSInteger extraC = count % cols;    //多出的cell是几个
    if (extraC) {
        extraC = cols - extraC;  //余出的空位是几个
        for (int i = 0; i < extraC; i++) {
            //添加空模型补齐空位
            LTSquareItem *item = [[LTSquareItem alloc] init];
            [self.squareList addObject:item];
        }
    }
}

//夜间模式
- (void)nightClick:(UIButton *)btn{
    btn.selected = !btn.selected;
}

//进入设置页面
- (void)settingClick{
    
    LTSettingViewController *settingVc = [[LTSettingViewController alloc] init];
    settingVc.hidesBottomBarWhenPushed = YES;   //设置隐藏底部TabBar
    [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark - UICollectionViewDataSource & Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LTSquareItem *item = self.squareList[indexPath.row];
    NSURL *url = [NSURL URLWithString:item.url];

    if (KSystemVersion >= 9.0) {
        
        SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:url];
        [self presentViewController:safariVc animated:YES completion:nil];
        
    } else if (KSystemVersion >= 8.0){
    
        LTWebViewController *webVc = [[LTWebViewController alloc] init];
        webVc.url = url;
        [self.navigationController pushViewController:webVc animated:YES];
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.squareList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LTSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.squareItem = _squareList[indexPath.row];

    return cell;
}



@end
