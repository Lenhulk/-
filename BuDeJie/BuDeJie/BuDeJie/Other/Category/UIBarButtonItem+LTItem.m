//
//  UIBarButtonItem+LTItem.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/16.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "UIBarButtonItem+LTItem.h"

@implementation UIBarButtonItem (LTItem)

+ (instancetype)itemWithImage:(UIImage *)image hightLightImage:(UIImage *)hightImage target:(id)target action:(SEL)action{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:hightImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //将按钮包装在view中
    UIView *view = [[UIView alloc] initWithFrame:btn.bounds];
    [view addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

@end
