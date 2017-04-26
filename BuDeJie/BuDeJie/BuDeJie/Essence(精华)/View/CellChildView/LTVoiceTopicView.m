//
//  LTVoiceTopicView.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/26.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTVoiceTopicView.h"
#import "LTTopicItem.h"
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
#import <DACircularProgressView.h>

@interface LTVoiceTopicView ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;  //封面图片
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;   //播放次数
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;    //时间标签
@property (weak, nonatomic) IBOutlet UIButton *playButton;  //耳机按钮
@property (nonatomic, assign) BOOL isPlaying;        //是否正在播放
@property (nonatomic, strong) UIImageView *playingImgView;  //动画
@property (nonatomic, strong) AVPlayer *avPlayer;   //播放器
@end

@implementation LTVoiceTopicView

- (AVPlayer *)avPlayer{
    if (!_avPlayer) {
        _avPlayer = [[AVPlayer alloc] init];
    }
    return _avPlayer;
}


- (void)setItem:(LTTopicItem *)item{
    [super setItem:item];
    
    _isPlaying = NO;
    
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:item.image0]];
    _playCountLabel.text = [NSString stringWithFormat:@"%@播放", item.playcount];
    
    NSInteger second = item.voicelength % 60;
    NSInteger minute = item.voicelength / 60;
    
    _timeLabel.text = [NSString stringWithFormat:@"%02ld : %02ld", minute, second];//不够补0，长度为2
}

///点击播放音乐 再次点击停止
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (!_isPlaying) {  //不在播放
        
        LTLog(@"%d", _isPlaying);
        
        NSURL *voiceUrl = [NSURL URLWithString:self.item.voiceuri];
        AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:voiceUrl];
        self.avPlayer = avPlayer;
        [avPlayer play];
        
        _isPlaying = !_isPlaying;
        self.playButton.hidden = YES;
        
        [self setupPlayingAnimate];
        
    } else if (_isPlaying){
        
        LTLog(@"%d", _isPlaying);
        
        [self.avPlayer pause];
        _isPlaying = !_isPlaying;
        self.playButton.hidden = NO;
        
        [self.playingImgView removeFromSuperview];
    }

}

///设置播放动画
- (void)setupPlayingAnimate{
    
    UIImageView *playingView = [[UIImageView alloc] init];
    playingView.center = self.playButton.center;
    playingView.bounds = CGRectMake(0, 0, 35, 35);
    
    NSArray *playImgNames = @[@"play-voice-icon-0", @"play-voice-icon-1", @"play-voice-icon-2", @"play-voice-icon-3"];
    NSMutableArray *playImgs = [NSMutableArray array];
    for (NSString *str in playImgNames) {
        UIImage *img = [UIImage imageNamed:str];
        [playImgs addObject:img];
    }
    playingView.animationImages = playImgs;
    playingView.animationDuration = playImgs.count * 0.25;
    playingView.animationRepeatCount = MAXFLOAT;
    playingView.alpha = 0.6;
    
    self.playingImgView = playingView;
    [self addSubview:playingView];
    [playingView startAnimating];
}

- (void)dealloc{
    LTLog(@"销毁%@",self);
}

@end
