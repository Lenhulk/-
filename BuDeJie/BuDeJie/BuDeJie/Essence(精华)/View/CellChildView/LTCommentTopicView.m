//
//  LTCommentTopicView.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/26.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTCommentTopicView.h"
#import "LTTopicItem.h"
#import "LTCommentItem.h"
#import "LTUserItem.h"

@interface LTCommentTopicView ()
@property (weak, nonatomic) IBOutlet UILabel *totalView;
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end

@implementation LTCommentTopicView

- (void)setItem:(LTTopicItem *)item{
    
    [super setItem:item];
        
    
    if (item.topComment.content.length) {   //文字评论
        
        _voiceView.hidden = YES;
        _totalView.hidden = NO;
        _totalView.text = item.topComment.totalContent;
        
    } else {    //声音评论
        
        _totalView.hidden = YES;
        _voiceView.hidden = NO;
        _userNameLabel.text = item.topComment.user.username;
        _voiceButton.titleLabel.text = item.topComment.voicetime;
    }
    
}

@end
