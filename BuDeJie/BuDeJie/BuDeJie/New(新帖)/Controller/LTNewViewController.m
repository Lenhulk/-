//
//  LTNewViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/15.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTNewViewController.h"
#import "LTSubTagViewController.h"



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
    

}

@end
