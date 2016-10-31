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
#import "LTSeeBigPictureViewController.h"
#import <DALabeledCircularProgressView.h>

@interface LTPictureTopicView()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPicBtn;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation LTPictureTopicView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _progressView.progressTintColor = [UIColor orangeColor];
    _progressView.progressLabel.textColor = [UIColor orangeColor];
    _progressView.trackTintColor = [UIColor blackColor];
//    _progressView.roundedCorners = 5;
    
}

- (void)setItem:(LTTopicItem *)item{
    [super setItem:item];
    
    //先去沙盒找有没有已保存的图片
    
    
        //防止cell重用
    _progressView.progress = 0;
    _progressView.progressLabel.text = @"0%";
    
    _gifView.hidden = !item.is_gif;   //GIF标签
    _seeBigPicBtn.hidden = !item.is_bigPicture;  //大图按钮
    
    //设置图片
//    [_pictureView sd_setImageWithURL:[NSURL URLWithString:item.image0]];
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:item.image0] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        if (expectedSize == -1) return ;
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        _progressView.progress = progress;
        _progressView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%", progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    
    if (item.is_bigPicture) {
        _pictureView.clipsToBounds = YES;
        _pictureView.contentMode = UIViewContentModeTop;
    } else {
        _pictureView.clipsToBounds = NO;
        _pictureView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
 
}

//从touchesBegan改touchesEnded降低滑动屏幕时误触发点击事件
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    LTSeeBigPictureViewController *seeBigPicVc = [[LTSeeBigPictureViewController alloc] init];
    seeBigPicVc.item = self.item;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigPicVc animated:YES completion:nil];
}
@end
