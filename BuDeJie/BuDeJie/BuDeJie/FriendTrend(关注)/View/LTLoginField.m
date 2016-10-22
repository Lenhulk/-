//
//  LTLoginField.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/21.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTLoginField.h"

@implementation LTLoginField

- (void)awakeFromNib{
    [super awakeFromNib];
    
    //设置光标颜色
    self.tintColor = [UIColor whiteColor];
    
    //打断点找属性
//    UITextField *t;
    
    //自己设置placeholder的颜色
    self.placeholderColor = [UIColor lightGrayColor];

}

- (BOOL)becomeFirstResponder{
    self.placeholderColor = [UIColor whiteColor];
    
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    self.placeholderColor = [UIColor lightGrayColor];
    
    return [super resignFirstResponder];
}

@end
