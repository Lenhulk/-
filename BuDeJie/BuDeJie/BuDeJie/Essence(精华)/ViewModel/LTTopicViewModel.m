//
//  LTTopicViewModel.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/25.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTTopicViewModel.h"
#import "LTTopicItem.h"

@implementation LTTopicViewModel

- (void)setItem:(LTTopicItem *)item{
    
    _item = item;
    
    //计算TopView高
    CGFloat margin = 10;
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = KScreenW;
    CGFloat textY = 55;
    CGFloat textW = KScreenW - 2 * margin;
    CGFloat textH = [item.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(textW, MAXFLOAT)].height;
    CGFloat topH = textY + textH;
    
    _topViewFrame = CGRectMake(topX, topY, topW, topH);
    _cellH = CGRectGetMaxY(self.topViewFrame) + margin;
    
    //计算MiddleView高，只有非段子才需要计算
    if (item.type != LTTopicItemTypeText) {
        CGFloat middleX = margin;
        CGFloat middleY = _cellH;
        CGFloat middleW = textW;
        CGFloat middleH = textW / item.width * item.height;
        if (middleH > KScreenH) {
            middleH = 300;
            item.is_bigPicture = YES;
        }
        
        _middleViewFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellH = CGRectGetMaxY(self.middleViewFrame) + margin;
    }
}



@end
