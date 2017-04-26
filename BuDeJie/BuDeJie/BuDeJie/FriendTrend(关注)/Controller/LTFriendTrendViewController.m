//
//  LTFriendTrendViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/15.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTFriendTrendViewController.h"
#import "LTLoginViewController.h"
#import "LTRecommandViewController.h"

@interface LTFriendTrendViewController ()
@end

@implementation LTFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];

    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] hightLightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(attentionClick)];
}

- (void)attentionClick{
    LTRecommandViewController *recommandVc = [[LTRecommandViewController alloc] init];
    [self.navigationController pushViewController:recommandVc animated:YES];
}

- (IBAction)loginClick:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LTLoginViewController" bundle:nil];
    //加载箭头指向控制器
    LTLoginViewController *loginVc = [storyBoard instantiateInitialViewController];
    //弹出登录界面
    [self presentViewController:loginVc animated:YES completion:nil];
}




@end
