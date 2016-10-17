//
//  LTBackView.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/17.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTBackView.h"

@implementation LTBackView

+ (instancetype)backViewWithImage:(UIImage *)image highLightedImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title{
    
    //设置返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:title forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backBtn setImage:image forState:UIControlStateNormal];
    [backBtn setImage:highImage forState:UIControlStateHighlighted];
    [backBtn sizeToFit];
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //设置导航条左边按钮左偏
    //发现问题，按钮的frame可以改变，但是包装的view位置并不移动（即可点击部位仍处于默认位置）
//    backBtn.lh_x -= 11;
    //自定义NavBar实现
    
    //用view将按钮包装起来（减少点击范围）
//    UIView *view = [[UIView alloc] initWithFrame:backBtn.bounds];
//    [view addSubview:backBtn];
    
    LTBackView *view = [[self alloc] initWithFrame:backBtn.frame];
    [view addSubview:backBtn];
    
    return view;
}

@end
