//
//  LTNewViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/15.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTNewViewController.h"
#import "UIBarButtonItem+LTItem.h"

@interface LTNewViewController ()

@end

@implementation LTNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)setupNavBar{
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] hightLightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(subClick)];
}

- (void)subClick{
    NSLog(@"订阅标签");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
