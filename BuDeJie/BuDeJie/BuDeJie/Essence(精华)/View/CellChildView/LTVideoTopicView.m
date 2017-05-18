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
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

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

//点击打开视频
- (IBAction)playBtnClick:(id)sender {
    
    LTLog(@"点击了视频");
    
    //1 获取元素
    NSString *videoUrlStr = self.item.videouri;
    
    NSURL *videoUrl = [NSURL URLWithString:videoUrlStr];
    
    //2 创建播放器
    AVPlayer *player = [AVPlayer playerWithURL:videoUrl];
    
    //3 创建视频播放器控制器
    AVPlayerViewController *playVC = [[AVPlayerViewController alloc] init];
    playVC.player = player;
    playVC.view.frame = CGRectMake(0, 0, KScreenW, KScreenH);
    player.externalPlaybackVideoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:playVC animated:YES completion:nil];
    
    //4 播放
    [player play];
}


@end
