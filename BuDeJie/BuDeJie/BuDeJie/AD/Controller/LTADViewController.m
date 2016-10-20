//
//  LTADViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/18.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//


#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

#import "LTADViewController.h"
#import <AFNetworking.h>
#import "LTADItem.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "LTTabBarController.h"

#define LTScreenW [UIScreen mainScreen].bounds.size.width
#define LTScreenH [UIScreen mainScreen].bounds.size.height
#define iPhone6P (LTScreenH == 736)
#define iPhone6 (LTScreenH == 667)
#define iPhone5 (LTScreenH == 568)
#define iPhone4 (LTScreenH == 480)

@interface LTADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
@property (nonatomic, strong) LTADItem *adItem;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation LTADViewController

//进入主界面
- (IBAction)jump:(id)sender {
    LTTabBarController *tabBarVc = [[LTTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
    //销毁定时器
    [_timer invalidate];
    _timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载启动图片
    [self setupLaunchImageView];
    //加载广告
    [self loadADData];
    //创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}

//倒计时
- (void)countDown{
//    LTLog(@"%s", __func__);
    
    static int count = 3;   //静态变量能保持上次修改的数
    count--;
    
    [_jumpButton setTitle:[NSString stringWithFormat:@"跳过(%d)", count] forState:UIControlStateNormal];
    
    if (count == -1) {
        [self jump:nil];
    }
}

- (void)setupLaunchImageView{
    UIImage *image = nil;
    //抽取宏，增加代码可阅读性
    if (iPhone6P) {
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iPhone6) {
        image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iPhone5) {
        image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    } else if (iPhone4) {
        image = [UIImage imageNamed:@"LaunchImage"];
    }
    _launchImageView.image = image;
}

- (void)loadADData{
    //创建请求会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager lh_manager];
    
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    
    //发送请求
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        LTLog(@"%@", responseObject);
        //可数据转plist方便对照解析
//        [responseObject writeToFile:@"/Users/Lenhulk/Desktop/ad.plist" atomically:YES];
        
        //获取广告字典，转模型
        NSDictionary *adDict = [responseObject[@"ad"] firstObject];
        LTADItem *item = [LTADItem mj_objectWithKeyValues:adDict];
        _adItem = item;
        
        //创建UIImageView
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        CGFloat height = LTScreenW / item.w * item.h;   //图片高度不确定，通过比例得出高度
        imageView.frame = CGRectMake(0, 0, LTScreenW, height);
        
            //设置网络图片并添加手势
        [imageView sd_setImageWithURL:[NSURL URLWithString:item.w_picurl]];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tapGR];
        
        [_contentView addSubview:imageView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        LTLog(@"ERROR----%@", error);
    }];
}

- (void)tap{
    NSURL *url = [NSURL URLWithString:_adItem.ori_curl];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}



@end
