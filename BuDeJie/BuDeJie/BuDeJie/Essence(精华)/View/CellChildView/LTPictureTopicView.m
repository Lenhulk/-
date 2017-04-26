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
/**圆形进度条*/
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@end

@implementation LTPictureTopicView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _progressView.progressTintColor = LTColor(234, 30, 23, 1);
    _progressView.progressLabel.textColor = LTColor(234, 30, 23, 1);
    _progressView.trackTintColor = [UIColor blackColor];
//    _progressView.roundedCorners = 5;
    
}

- (void)setItem:(LTTopicItem *)item{
    [super setItem:item];
    
    //防止cell重用
    _progressView.progress = 0;
    _progressView.progressLabel.text = @"0%";
    
    //先去沙盒找有没有已保存的图片
    NSString *fileName = [item.image0 stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString *filePath = [KCachePath stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:data];
    
    //如果拿到本地缓存保存的图片就使用
    if (image) {
        item.localImage = image;
        _pictureView.image = image;
        
    } else {
        
        //    [_pictureView sd_setImageWithURL:[NSURL URLWithString:item.image0]];
        //没拿到缓存再加载图片
        [_pictureView sd_setImageWithURL:[NSURL URLWithString:item.image0] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            if (expectedSize == -1) return ;
            
            CGFloat progress = 1.0 * receivedSize / expectedSize;
                _progressView.progress = progress;
                _progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
                //加载完成图片时裁剪超大图片防止显示不出
            if (image.size.height < 10000) return ;
                //设置图片大小
            CGFloat imageW = KScreenW - 20;
            CGFloat imageH = imageW / image.size.width * image.size.height;
                //开启图形上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
                //画图
            [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
                //取图
            image = UIGraphicsGetImageFromCurrentImageContext();
                //关闭上下文
            UIGraphicsEndImageContext();
                //保存到模型&显示
            item.localImage = image;
            _pictureView.image = image;
                //保存到沙盒
            NSData *data = UIImagePNGRepresentation(image);
            NSString *fileName = [item.image0 stringByReplacingOccurrencesOfString:@"/" withString:@""];
            NSString *filePath = [KCachePath stringByAppendingPathComponent:fileName];
            
            LTLog(@"%d", [data writeToFile:filePath atomically:YES]);
            LTLog(@"%@", filePath);
        }];
        
    }
    _gifView.hidden = !item.is_gif;   //GIF标签
    _seeBigPicBtn.hidden = !item.is_bigPicture;  //大图按钮
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
