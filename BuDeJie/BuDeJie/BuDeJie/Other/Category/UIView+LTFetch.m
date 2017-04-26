//
//  UIView+LTFetch.m
//  BuDeJie
//
//  Created by Lenhulk on 2016/10/31.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "UIView+LTFetch.h"

@implementation UIView (LTFetch)
- (UITableView *)fetchTableView{
    //获取窗口的所有子控件
    for (UIView *childView in self.subviews) {
        if ([childView isKindOfClass:[UITableView class]]) {
            return (UITableView *)childView;   //如果是tableview就返回这个view
        }
        UITableView *tableView = [childView fetchTableView];   //如果不是继续用进入子类查找（递归）
        if (tableView) {        //当获取到了tableview的时候
            return tableView;
        }
    }
    return nil;
}
@end
