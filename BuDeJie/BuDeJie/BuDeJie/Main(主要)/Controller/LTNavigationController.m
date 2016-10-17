//
//  LTNavigationController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/17.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTNavigationController.h"
#import "LTNavigationBar.h"

@interface LTNavigationController ()

@end

@implementation LTNavigationController

+ (void)load{
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //导航条字体
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    bar.titleTextAttributes = attr;
    
    //导航条背景
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建自定义导航条
    LTNavigationBar *bar = [[LTNavigationBar alloc] initWithFrame:self.navigationBar.frame];
    //导航条控件是只读控件（没有setter方法），通过KVC设置替换
//    self.navigationBar = bar;
    [self setValue:bar forKey:@"navigationBar"];
    
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
