//
//  LTNavigationBar.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/17.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTNavigationBar.h"
#import "LTBackView.h"

@implementation LTNavigationBar

- (void)layoutSubviews{
    [super layoutSubviews];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[LTBackView class]]) {
            view.lh_x = 6;
        }
    }
}

@end
