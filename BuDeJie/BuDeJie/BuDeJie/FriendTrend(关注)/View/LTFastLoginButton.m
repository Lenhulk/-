//
//  LTFastLoginButton.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/21.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTFastLoginButton.h"

@implementation LTFastLoginButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.lh_centerX = self.lh_width * 0.5;
    self.imageView.lh_y = 3;
    
    //要设置中心点，一定要先设置尺寸
    [self.titleLabel sizeToFit];
    
    self.titleLabel.lh_centerX = self.lh_width * 0.5;
    self.titleLabel.lh_y = self.lh_height - self.titleLabel.lh_height;
}

@end
