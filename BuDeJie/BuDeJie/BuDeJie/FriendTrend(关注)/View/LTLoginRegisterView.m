//
//  LTLoginRegisterView.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/21.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTLoginRegisterView.h"

@interface LTLoginRegisterView ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LTLoginRegisterView

+ (instancetype)loginView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)registerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    //解决按钮背景边角拉伸问题
    UIImage *image = self.loginBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal];
}

@end
