//
//  UITabBarItem+LTFont.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/16.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "UITabBarItem+LTFont.h"

@implementation UITabBarItem (LTFont)
- (void)setupTabBarButtonFont:(CGFloat)fontSize{
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    
    //设置字体大小属性
    UIFont *myfontSize = [UIFont systemFontOfSize:fontSize];
    attr[NSFontAttributeName] = myfontSize;
    
    [self setTitleTextAttributes:attr forState:UIControlStateNormal];
}
@end
