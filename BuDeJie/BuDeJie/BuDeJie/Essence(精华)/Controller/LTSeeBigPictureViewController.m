//
//  LTSeeBigPictureViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/27.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTSeeBigPictureViewController.h"
#import "LTTopicItem.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import <SVProgressHUD.h>
#import <Photos/Photos.h>
#import "LTPhotoManager.h"

#define LTPhotoAlbumTitle @"BaiSiBuDeSister"

@interface LTSeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LTSeeBigPictureViewController

#pragma mark - 保存图片

- (IBAction)saveClick:(id)sender {
    
//    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_item.image0];
    
    //保存图片到相册
//    UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    //授权业务
    //从设置获取用户对app设置的相册权限
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        //如果不确定 申请权限
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                
//                [self savePhoto];
                [LTPhotoManager savePhoto:_imageView.image albumTitle:LTPhotoAlbumTitle completionHandler:^(BOOL success, NSError *error) {
                    if (error) {
                        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"保存错误：%@", error]];
                    } else {
                        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                    }
                }];
            }
        }];
    } else if (status == PHAuthorizationStatusAuthorized){
//        [self savePhoto];
        
        [LTPhotoManager savePhoto:_imageView.image albumTitle:LTPhotoAlbumTitle completionHandler:^(BOOL success, NSError *error) {
            if (error) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"保存错误：%@", error]];
            } else {
                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            }
        }];
        
    } else {
        //受限制
        [SVProgressHUD showInfoWithStatus:@"进入设置界面->找到当前应用->打开允许访问相册的开关"];
    }

}

//保存图片完成时调用
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"保存失败"];
//    } else {
//        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
//    }
//}

#pragma mark - 跳转
- (IBAction)dismissClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:_item.image0]];
    
    [_scrollView addSubview:imageView];
    
    CGFloat h = KScreenW / _item.width * _item.height;
    imageView.frame = CGRectMake(0, 0, KScreenW, h);
 /*
    if (_item.is_bigPicture) {
        _scrollView.contentSize = CGSizeMake(0, h);
        _scrollView.delegate = self;
        //设置缩放比例
        _scrollView.maximumZoomScale = _item.height / h;
    } else {
        imageView.center = CGPointMake(KScreenW * 0.5, KScreenH * 0.5);
    }
 */
    //设置滚动范围和缩放比例
    _scrollView.contentSize = CGSizeMake(0, h);
    _scrollView.delegate = self;
    _scrollView.maximumZoomScale = 3.0;
    _scrollView.minimumZoomScale = 0.3;
    
    if (_item.is_bigPicture) {
        _scrollView.contentSize = CGSizeMake(0, h);
    } else {
        imageView.center = CGPointMake(KScreenW * 0.5, KScreenH * 0.5);
    }
}

#pragma mark - ViewForZooming
//返回需要缩放的子控件
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}


@end
