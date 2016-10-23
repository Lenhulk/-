//
//  LTSquareCell.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/22.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTSquareCell.h"
#import "LTSquareItem.h"
#import <UIImageView+WebCache.h>

@interface LTSquareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation LTSquareCell

- (void)setSquareItem:(LTSquareItem *)squareItem{
    _squareItem = squareItem;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:squareItem.icon]];
    self.label.text = squareItem.name;
    
}

@end
