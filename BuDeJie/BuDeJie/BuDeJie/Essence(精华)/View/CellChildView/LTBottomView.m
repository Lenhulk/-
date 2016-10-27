//
//  LTBottomView.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/27.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTBottomView.h"
#import "LTTopicItem.h"

@interface LTBottomView()
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButtom;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation LTBottomView

- (void)setItem:(LTTopicItem *)item{

    [super setItem:item];
   
    [self setupButton:_dingButton title:@"顶" count:item.ding];
    [self setupButton:_caiButton title:@"踩" count:item.cai];
    [self setupButton:_shareButtom title:@"分享" count:item.repost];
    [self setupButton:_commentButton title:@"评论" count:item.comment];
    
}

- (void)setupButton:(UIButton *)btn title:(NSString *)title count:(CGFloat)count{
    //默认显示文字
    NSString *str = title;
    //有数值显示数值
    if (count >= 10000) {
        count = count / 10000;
        str = [NSString stringWithFormat:@"%.1f万", count];
    } else if (count > 0) {
        str = [NSString stringWithFormat:@"%.f", count];
    }
    [str stringByReplacingOccurrencesOfString:@".0" withString:@" "];
    [btn setTitle:str forState:UIControlStateNormal];
}

@end
