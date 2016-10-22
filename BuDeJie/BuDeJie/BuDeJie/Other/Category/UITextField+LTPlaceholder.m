//
//  UITextField+LTPlaceholder.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/22.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "UITextField+LTPlaceholder.h"

@implementation UITextField (LTPlaceholder)

- (UIColor *)placeholderColor{
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    return placeholderLabel.textColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    //给空的placeholder赋空格，好让它能在未输入前就设置颜色
    if (self.placeholder.length == 0) {
        self.placeholder = @" ";
    }
    //苹果系统控件定义的成员变量是私有的，只能KVC设置
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

@end
