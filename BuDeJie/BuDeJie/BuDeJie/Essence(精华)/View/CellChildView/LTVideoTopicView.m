//
//  LTVideoTopicView.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/26.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTVideoTopicView.h"
#import "LTTopicItem.h"
#import <UIImageView+WebCache.h>

@interface LTVideoTopicView ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation LTVideoTopicView

- (void)setItem:(LTTopicItem *)item{
    [super setItem:item];
    
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:item.cdn_img]];
    _playCountLabel.text = [NSString stringWithFormat:@"%@播放", item.playcount];
    
    NSInteger second = item.videotime % 60;
    NSInteger minute = item.videotime / 60;
    
    _timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", minute, second];//不够补0，长度为2
}

@end
