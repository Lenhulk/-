//
//  LTNewViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/15.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTNewViewController.h"
#import "LTSubTagViewController.h"
#import "LTBaseTopicViewController.h"

#import "LTAllViewController.h"
#import "LTPictureViewController.h"
#import "LTTextViewController.h"
#import "LTVoiceViewController.h"
#import "LTVideoViewController.h"

@interface LTNewViewController ()

@end

@implementation LTNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    [self setupNavBar];
    
    [self setupAllChildViewController];
    
}

- (void)setupNavBar{
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] hightLightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(subClick)];
}

//点击订阅
- (void)subClick{
    LTSubTagViewController *subTagVc = [[LTSubTagViewController alloc] init];
    [self.navigationController pushViewController:subTagVc animated:YES];
}

- (void)setupAllChildViewController{
    LTAllViewController *allVc = [[LTAllViewController alloc] init];
    allVc.title = @"所有";
    [self addChildViewController:allVc];
    
    LTVideoViewController *videoVc = [[LTVideoViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    LTVoiceViewController *voiceVc = [[LTVoiceViewController alloc] init];
    voiceVc.title = @"声音";
    [self addChildViewController:voiceVc];
    
    LTPictureViewController *pictureVc = [[LTPictureViewController alloc] init];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
    LTTextViewController *textVc = [[LTTextViewController alloc] init];
    textVc.title = @"段子";
    [self addChildViewController:textVc];
}

@end
