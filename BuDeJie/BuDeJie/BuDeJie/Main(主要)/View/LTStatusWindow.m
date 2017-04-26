//
//  LTStatusWindow.m
//  BuDeJie
//
//  Created by Lenhulk on 2016/10/31.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTStatusWindow.h"
//@interface LTStatusWindow ()
////@property (nonatomic, strong) UIView *statusWindow;
//@end

static LTStatusWindow *_statusWindow;

@implementation LTStatusWindow
+ (void)show{
    LTStatusWindow *statusWindow = [[LTStatusWindow alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 20)];
    statusWindow.rootViewController = [[UIViewController alloc] init];
    statusWindow.windowLevel = UIWindowLevelAlert;
    statusWindow.backgroundColor = [UIColor clearColor];
    statusWindow.hidden = NO;
    //类方法中不能获取属性，只能定义静态变量保存
    _statusWindow = statusWindow;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //遍历窗口子控件，看有没有tableview
    UIWindow *keyWidow = [UIApplication sharedApplication].keyWindow;
    UITableView *tableView = [self fetchTableView:keyWidow];
    //回到顶部
    [tableView setContentOffset:CGPointMake(0, -99) animated:YES];
}

- (UITableView *)fetchTableView:(UIView *)view{
    //获取窗口的所有子控件
    for (UIView *childView in view.subviews) {
        if ([childView isKindOfClass:[UITableView class]]) {
            return (UITableView *)childView;   //如果是tableview就返回这个view
        }
        UITableView *tableView = [self fetchTableView:childView];   //如果不是继续用进入子类查找（递归）
        if (tableView) {        //当获取到了tableview的时候
            return tableView;
        }
    }
    return nil;
}


@end
