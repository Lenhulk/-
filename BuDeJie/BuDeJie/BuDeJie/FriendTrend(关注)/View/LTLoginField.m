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
    
    self.tintColor = [UIColor whiteColor];
    
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    //自己设置placeholder的颜色
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
    self.attributedPlaceholder = attrStr;
}

- (void)textBegin{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
    self.attributedPlaceholder = attrStr;
}

- (void)textEnd{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
    self.attributedPlaceholder = attrStr;
}

@end
