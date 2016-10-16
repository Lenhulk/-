//
//  UIBarButtonItem+LTItem.h
//  BuDeJie
//
//  Created by Lenhulk on 16/10/16.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LTItem)
+ (instancetype)itemWithImage:(UIImage *)image hightLightImage:(UIImage *)hightImage target:(id)target action:(SEL)action;
@end
