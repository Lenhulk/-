//
//  LTUserCell.m
//  BuDeJie
//
//  Created by Lenhulk on 2016/11/3.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTUserCell.h"
#import "LTUserItem.h"
#import <UIImageView+WebCache.h>

@interface LTUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerCountLabel;

@end

@implementation LTUserCell

- (void)setUser:(LTUserItem *)user{
    _user = user;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:user.header]];
    _userNameLabel.text = user.screen_name;
    
    CGFloat fansNum = [user.fans_count floatValue];
    NSString *numStr = [NSString stringWithFormat:@"%@人关注", user.fans_count];
    if (fansNum > 10000) {
        fansNum = fansNum / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人关注", fansNum];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    _followerCountLabel.text = numStr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
