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

@interface LTPictureTopicView()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPicBtn;

@end

@implementation LTPictureTopicView

- (void)awakeFromNib{
    [super awakeFromNib];
    
//    _progressView.progressTintColor = [UIColor whiteColor];
//    _progressView.trackTintColor = [UIColor lightGrayColor];
//    _progressView.roundedCorners = 5;
//    _progressView.progressLabel.textColor = [UIColor whiteColor];
    
}

- (void)setItem:(LTTopicItem *)item{
    
    [super setItem:item];
    
    _gifView.hidden = !item.is_gif;   //GIF标签
    _seeBigPicBtn.hidden = !item.is_bigPicture;  //大图按钮
    
//    [_pictureView sd_setImageWithURL:[NSURL URLWithString:item.image0]];
    
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:item.image0] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        if (expectedSize == -1) return ;
        
//        CGFloat progress = 1.0 * receivedSize / expectedSize;

        
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    LTSeeBigPictureViewController *seeBigPicVc = [[LTSeeBigPictureViewController alloc] init];
    seeBigPicVc.item = self.item;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigPicVc animated:YES completion:nil];
}
@end
