//
//  UIImage+LTRender.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/16.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "UIImage+LTRender.h"

@implementation UIImage (LTRender)
+ (UIImage *)imageNamedWithOriginalMode:(NSString *)name{
    UIImage *selImage = [UIImage imageNamed:name];
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return selImage;
}
@end
