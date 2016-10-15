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

@interface LTTabBarController ()

@end

@implementation LTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addAllChildViewController];
    
}

- (void)addAllChildViewController{
    
    //精华
    LTEssenceViewController *essenceVc = [[LTEssenceViewController alloc] init];
    [self setNavVc:essenceVc];
    
    //新帖
    LTNewViewController *newVc = [[LTNewViewController alloc] init];
    [self setNavVc:newVc];
    
    //发布
    LTPublishViewController *publishVc = [[LTPublishViewController alloc] init];
    [self addChildViewController:publishVc];
    
    //关注
    LTFriendTrendViewController *friendTVc = [[LTFriendTrendViewController alloc]init];
    [self setNavVc:friendTVc];
    
    //我
    LTMeViewController *meVc = [[LTMeViewController alloc] init];
    [self setNavVc:meVc];
}

- (void)setNavVc:(UIViewController *)ChildVc{
    //设置子导航控制器
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ChildVc];
    
    [self addChildViewController:nav];
}


@end
