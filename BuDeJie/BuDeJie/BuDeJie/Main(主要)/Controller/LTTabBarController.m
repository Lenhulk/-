//
//  LTTabBarController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/15.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTTabBarController.h"
#import "LTEssenceViewController.h"
#import "LTMeViewController.h"
#import "LTNewViewController.h"
#import "LTPublishViewController.h"
#import "LTFriendTrendViewController.h"
#import "UIImage+LTRender.h"
#import "UITabBarItem+LTFont.h"

@interface LTTabBarController ()

@end

@implementation LTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor darkGrayColor];
    [self addAllChildViewController];
    
}

- (void)addAllChildViewController{
    
    //精华
    LTEssenceViewController *essenceVc = [[LTEssenceViewController alloc] init];
    [self setNavVc:essenceVc image:[UIImage imageNamed:@"tabBar_essence_icon"] selectedImage:[UIImage imageNamedWithOriginalMode:@"tabBar_essence_click_icon"] title:@"精华"];
    
    //新帖
    LTNewViewController *newVc = [[LTNewViewController alloc] init];
    [self setNavVc:newVc image:[UIImage imageNamed:@"tabBar_new_icon"] selectedImage:[UIImage imageNamedWithOriginalMode:@"tabBar_new_click_icon"] title:@"新帖"];
    
    //发布
    LTPublishViewController *publishVc = [[LTPublishViewController alloc] init];
    publishVc.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
    publishVc.tabBarItem.selectedImage = [UIImage imageNamedWithOriginalMode:@"tabBar_publish_click_icon"];
    [self addChildViewController:publishVc];
    
    //关注
    LTFriendTrendViewController *friendTVc = [[LTFriendTrendViewController alloc]init];
    [self setNavVc:friendTVc image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectedImage:[UIImage imageNamedWithOriginalMode:@"tabBar_friendTrends_click_icon"] title:@"关注"];
    
    //我
    LTMeViewController *meVc = [[LTMeViewController alloc] init];
    [self setNavVc:meVc image:[UIImage imageNamed:@"tabBar_me_icon"] selectedImage:[UIImage imageNamedWithOriginalMode:@"tabBar_me_click_icon"] title:@"我"];
}

- (void)setNavVc:(UIViewController *)ChildVc image:(UIImage *)image selectedImage:(UIImage *)selImage title:(NSString *)title{
    
    //设置子导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ChildVc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = image;
    nav.tabBarItem.selectedImage = selImage;
    [nav.tabBarItem setupTabBarButtonFont:12];
    
    //设置TabBar按钮的文字大小属性
//    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]} forState:UIControlStateNormal];
    //设置按钮被选中时不会被渲染成默认的蓝色(原始图片样式)
//    nav.tabBarItem.selectedImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    [self addChildViewController:nav];
}


@end
