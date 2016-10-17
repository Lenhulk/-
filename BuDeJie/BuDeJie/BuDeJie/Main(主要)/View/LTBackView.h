//
//  LTBackView.h
//  BuDeJie
//
//  Created by Lenhulk on 16/10/17.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTBackView : UIView

//自定义返回按钮
+ (instancetype)backViewWithImage:(UIImage *)image highLightedImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;

@end
