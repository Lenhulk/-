//
//  LTTopTopicView.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/25.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTTopTopicView.h"
#import "LTTopicItem.h"
#import <UIImageView+WebCache.h>

@interface LTTopTopicView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

@implementation LTTopTopicView

+ (instancetype)viewForXib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}

- (void)setItem:(LTTopicItem *)item{

    _item = item;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.profile_image]];
    _nameLabel.text = item.screen_name;
    _timeLabel.text = item.create_time;
    _textLabel.text = item.text;
    
}

@end
