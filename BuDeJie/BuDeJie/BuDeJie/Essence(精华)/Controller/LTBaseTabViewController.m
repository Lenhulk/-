//
//  LTBaseTabViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/24.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTBaseTabViewController.h"
#import "LTBaseTopicViewController.h"

@interface LTBaseTabViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

/**自定义的TabView*/
@property (nonatomic, weak) UIView *topTitleView;
/**容器view*/
@property (nonatomic, weak) UICollectionView *bottomCollectionView;
/**选中的按钮type*/
@property (nonatomic, weak) UIButton *selBtn;
/**type按钮数组*/
@property (nonatomic, strong) NSMutableArray *titleBtns;
/**底部滑动的红线*/
@property (nonatomic, weak) UIView *underLineView;

@property (nonatomic, assign) BOOL isInitial;

@end

static NSString * const ID = @"CollectionCell";

@implementation LTBaseTabViewController

- (NSMutableArray *)titleBtns{
    if (_titleBtns == nil) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航条
//    [self setupNavBar];
    
    //添加底部的View(collectionV)
    [self setupBottomContainerView];
    
    //添加顶部自定义导航的View(scrollView)
    [self setupTopTitleView];
    
    //添加子控制器
//    [self setupAllChildViewController];

    //取消自动添加额外的滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}

//view将要显示的时候才加载
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_isInitial == NO) {
        [self setupTopTitleButton];
        _isInitial = YES;
    }
}

#pragma mark - Setup
- (void)setupBottomContainerView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    collectionV.backgroundColor = [UIColor lightGrayColor];
    
    //XCode8新特性，取消这个属性可以防止离屏渲染，同时解决了重复点击Tabbutton不刷新页面的问题
    collectionV.prefetchingEnabled = NO;
    
    collectionV.showsVerticalScrollIndicator = NO;
    collectionV.showsHorizontalScrollIndicator = NO;
    collectionV.bounces = NO;
    collectionV.pagingEnabled = YES;
    collectionV.scrollsToTop = NO;
    
    collectionV.dataSource = self;
    collectionV.delegate = self;
    
    [collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    [self.view addSubview:collectionV];
    _bottomCollectionView = collectionV;
}

- (void)setupTopTitleView{
    CGFloat y = self.navigationController.navigationBarHidden==YES?20:64;
    
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, KScreenW, 35)];
    scrollV.scrollsToTop = NO;
    scrollV.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    
    [self.view addSubview:scrollV];
    
    _topTitleView = scrollV;
}

- (void)setupTopTitleButton{
    
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = KScreenW / count;
    CGFloat btnH = self.topTitleView.lh_height;
    CGFloat btnX = 0;
    
    for (int i = 0; i < count; i++) {
        btnX = i * btnW;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topTitleView addSubview:btn];
        [self.titleBtns addObject:btn];
        
        if (i == 0) {
            //默认选中第一个按钮
            [self titleBtnClick:btn];
            //添加下划线
            UIView *underLine = [[UIView alloc] init];
            self.underLineView = underLine;
            underLine.backgroundColor = [UIColor redColor];
            [btn.titleLabel sizeToFit]; //必须先设置按钮的label宽度
            underLine.lh_width = btn.titleLabel.lh_width;
            underLine.lh_centerX = btn.lh_centerX;
            underLine.lh_height = 2;
            underLine.lh_y = self.topTitleView.lh_height - underLine.lh_height;
            [self.topTitleView addSubview:underLine];
        }
    }
}

//点击按钮和滚动页面都会调用这个方法切换选择按钮，移动下划线
- (void)selectedButton:(UIButton *)btn{
    _selBtn.selected = NO;
    btn.selected = YES;
    _selBtn = btn;
    [UIView animateWithDuration:0.25 animations:^{
        _underLineView.lh_centerX = btn.lh_centerX;
    }];
}


#pragma mark - UICollectionViewDelegate
//滚动完成时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / KScreenW;
    UIButton *btn = self.titleBtns[page];
    [self selectedButton:btn];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childViewControllers.count;
}

//每次有新的cell出现就会调用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    //移除上一个控制器，防止出现cell重用问题
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //切换子控制器
    UITableViewController *tableVc = self.childViewControllers[indexPath.row];
    tableVc.view.frame = [UIScreen mainScreen].bounds;
    //不让内容被挡住
    tableVc.tableView.contentInset = UIEdgeInsetsMake(64 + self.topTitleView.lh_height, 0, 49, 0);
    [cell.contentView addSubview:tableVc.view];
    
    return cell;
}


#pragma mark - TitleButtonClick事件

- (void)titleBtnClick:(UIButton *)btn{
    
    NSInteger i = btn.tag;
    
    //判断是否重复点击了type按钮
    if (btn == _selBtn) {
        //获取当前控制器->刷新
        LTBaseTopicViewController *topicVc = self.childViewControllers[i];
        LTLog(@"%@重复点击了按钮", topicVc);
        [topicVc reload];
    }
    
    //记录选择的按钮
    [self selectedButton:btn];
    
    //点击按钮切换到对应的页面
    CGFloat offset = i * KScreenW;
    self.bottomCollectionView.contentOffset = CGPointMake(offset, 0);
    
}



@end
