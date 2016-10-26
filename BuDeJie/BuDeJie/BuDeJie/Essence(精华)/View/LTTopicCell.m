//
//  LTTopicCell.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/25.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

//用来描述主题的cell

#import "LTTopicCell.h"
#import "LTTopTopicView.h"
#import "LTTopicViewModel.h"
#import "LTTopicItem.h"
#import "LTPictureTopicView.h"
#import "LTVideoTopicView.h"
#import "LTVoiceTopicView.h"

@interface LTTopicCell ()
@property (nonatomic, weak) LTTopTopicView *topTopicView;
@property (nonatomic, weak) LTPictureTopicView *pictureView;
@property (nonatomic, weak) LTVideoTopicView *videoView;
@property (nonatomic, weak) LTVoiceTopicView *voiceView;
@end

@implementation LTTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 设置顶部View内容，设置topView，设置Cell尺寸
        LTTopTopicView *topTopicView = [LTTopTopicView viewForXib];
        [self.contentView addSubview:topTopicView];
        _topTopicView = topTopicView;
        
        // 中间
        // 图片
        LTPictureTopicView *picView = [LTPictureTopicView viewForXib];
        [self.contentView addSubview:picView];
        _pictureView = picView;
        // 视频
        LTVideoTopicView *videoView = [LTVideoTopicView viewForXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
        // 声音
        LTVoiceTopicView *voiceView = [LTVoiceTopicView viewForXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return self;
}

//- (void)setItem:(LTTopicItem *)item{
//    _item = item;
//    _topView.item = item;
//}


- (void)setVm:(LTTopicViewModel *)vm{
    _vm = vm;
    
    //top
    _topTopicView.item = vm.item;
    _topTopicView.frame = vm.topViewFrame;
    
    //middle
     if (vm.item.type == LTTopicItemTypePicture){
         
        _pictureView.item = vm.item;
        _pictureView.frame = vm.middleViewFrame;
        
        _pictureView.hidden = NO;
        _videoView.hidden = YES;
         _voiceView.hidden = YES;
         
     } else if (vm.item.type == LTTopicItemTypeVideo) {
         
         _videoView.item = vm.item;
         _videoView.frame = vm.middleViewFrame;
         
         _videoView.hidden = NO;
         _pictureView.hidden = YES;
         _voiceView.hidden = YES;
         
     } else if (vm.item.type == LTTopicItemTypeVoice){
         
         _voiceView.item = vm.item;
         _voiceView.frame = vm.middleViewFrame;
         
         _voiceView.hidden = NO;
         _videoView.hidden = YES;
         _pictureView.hidden = YES;
         
     } else {   //段子
         _videoView.hidden = YES;
         _pictureView.hidden = YES;
         
     }
}

@end
