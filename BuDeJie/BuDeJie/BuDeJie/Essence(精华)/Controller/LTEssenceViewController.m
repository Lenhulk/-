//
//  LTEssenceViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/15.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTEssenceViewController.h"
#import "LTBaseTopicViewController.h"

#import "LTAllViewController.h"
#import "LTPictureViewController.h"
#import "LTTextViewController.h"
#import "LTVoiceViewController.h"
#import "LTVideoViewController.h"

@interface LTEssenceViewController ()

@end

@implementation LTEssenceViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupNavBar];
    [self setupAllChildViewController];
}

- (void)setupNavBar{
    //标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] hightLightImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(gameClick)];
    //右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] hightLightImage:[UIImage imageNamed:@"navigationButtonRandomClick" ] target:self action:@selector(randomClick)];
}

- (void)setupAllChildViewController{
    
    LTAllViewController *allVc = [[LTAllViewController alloc] init];
    allVc.title = @"所有";
//    allVc.type = @(LTTopicItemTypeAll);
    [self addChildViewController:allVc];
    
    LTVideoViewController *videoVc = [[LTVideoViewController alloc] init];
    videoVc.title = @"视频";
//    videoVc.type = @(LTTopicItemTypeVideo);
    [self addChildViewController:videoVc];
    
    LTVoiceViewController *voiceVc = [[LTVoiceViewController alloc] init];
    voiceVc.title = @"声音";
//    videoVc.type = @(LTTopicItemTypeVoice);
    [self addChildViewController:voiceVc];
    
    LTPictureViewController *pictureVc = [[LTPictureViewController alloc] init];
    pictureVc.title = @"图片";
//    videoVc.type = @(LTTopicItemTypePicture);
    [self addChildViewController:pictureVc];
    
    LTTextViewController *textVc = [[LTTextViewController alloc] init];
    textVc.title = @"段子";
//    videoVc.type = @(LTTopicItemTypeText);
    [self addChildViewController:textVc];
}

//- (void)setupAllChildViewController{
//    
//    LTBaseTopicViewController *allVc = [[LTBaseTopicViewController alloc] init];
//    allVc.title = @"所有";
//    allVc.type = @(LTTopicItemTypeAll);
//    [self addChildViewController:allVc];
//    
//    LTBaseTopicViewController *videoVc = [[LTBaseTopicViewController alloc] init];
//    videoVc.title = @"视频";
//    videoVc.type = @(LTTopicItemTypeVideo);
//    [self addChildViewController:videoVc];
//    
//    LTBaseTopicViewController *voiceVc = [[LTBaseTopicViewController alloc] init];
//    voiceVc.title = @"声音";
//    videoVc.type = @(LTTopicItemTypeVoice);
//    [self addChildViewController:voiceVc];
//    
//    LTBaseTopicViewController *pictureVc = [[LTBaseTopicViewController alloc] init];
//    pictureVc.title = @"图片";
//    videoVc.type = @(LTTopicItemTypePicture);
//    [self addChildViewController:pictureVc];
//    
//    LTBaseTopicViewController *textVc = [[LTBaseTopicViewController alloc] init];
//    textVc.title = @"段子";
//    videoVc.type = @(LTTopicItemTypeText);
//    [self addChildViewController:textVc];
//}

- (void)gameClick{
    LTLog(@"点击🎮游戏");
}

- (void)randomClick{
    LTLog(@"随机推荐");
}


@end
