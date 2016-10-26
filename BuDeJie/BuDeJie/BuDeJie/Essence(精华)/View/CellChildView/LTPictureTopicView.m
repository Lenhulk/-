//
//  LTPictureTopicView.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/25.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTPictureTopicView.h"
#import "LTTopicItem.h"
#import "UIImageView+WebCache.h"

@interface LTPictureTopicView()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPicBtn;
//@property (nonatomic, weak) DALabeledCircularProgressView *progressView;

@end

@implementation LTPictureTopicView

- (void)awakeFromNib{
    [super awakeFromNib];
    
//    _progressView.progressTintColor = [UIColor redColor];
//    _progressView.trackTintColor = [UIColor blueColor];
//    _progressView.roundedCorners = 5;
//    
//    _progressView.progressLabel.textColor = [UIColor blackColor];
    
}

- (void)setItem:(LTTopicItem *)item{
    
//    _progressView.progress = 0;
//    _progressView.progressLabel.text = @"10%";
    
    [super setItem:item];
    _gifView.hidden = !item.is_gif;   //GIF标签
    _seeBigPicBtn.hidden = !item.is_bigPicture;  //大图按钮
    
//    [_pictureView sd_setImageWithURL:[NSURL URLWithString:item.image0]];
    
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:item.image0] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        if (expectedSize == -1) return ;
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        LTLog(@"%f", progress);
        
//        _progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", progress * 100.0];
//        [_progressView setProgress:progress animated:YES];
        
    } completed:nil];
    
    
    if (item.is_bigPicture) {
        _pictureView.clipsToBounds = YES;
        _pictureView.contentMode = UIViewContentModeTop;
    } else {
        _pictureView.clipsToBounds = NO;
        _pictureView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
 
}

@end
