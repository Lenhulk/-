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
#define LTPhotoAlbumTitle @"BaiSiBuDeSister"

@interface LTSeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LTSeeBigPictureViewController

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
                [self savePhoto];
            }
        }];
    } else if (status == PHAuthorizationStatusAuthorized){
        [self savePhoto];
    } else {
        //受限制
        [SVProgressHUD showInfoWithStatus:@"进入设置界面->找到当前应用->打开允许访问相册的开关"];
    }

}

- (void)savePhoto{
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //创建自定义相册
//        PHAssetCollectionChangeRequest *collectionRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"BaiSiBuDeSister"];
        
        //获取之前的相册
        PHAssetCollection *assetCollection = [self fetchAssetCollection:LTPhotoAlbumTitle];
        PHAssetCollectionChangeRequest *request;    //创建请求
        if (assetCollection) {  //已有相册
            request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else {    //未创建该相册
            request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:LTPhotoAlbumTitle];
        }
        //保存图片到系统相册
        PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:_imageView.image];
        //定义占位图片保存到自定义的相册
        PHObjectPlaceholder *placeHolder = [assetRequest placeholderForCreatedAsset];
        //用将要保存的图片替换占位图片
        [request addAssets:@[placeHolder]];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        if (error) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"保存错误：%@", error]];
        } else {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        }
    }];
}
//获取之前的相册
- (PHAssetCollection *)fetchAssetCollection:(NSString *)collectionTitle{
    
    PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in fetchResult) {
        if ([assetCollection.localizedTitle isEqualToString:LTPhotoAlbumTitle]) {
            return assetCollection;
        }
    }
    return nil;
}

//保存图片完成时调用
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"保存失败"];
//    } else {
//        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
//    }
//}

- (IBAction)dismissClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:_item.image0]];
    
    [_scrollView addSubview:imageView];
    
    CGFloat h = KScreenW / _item.width * _item.height;
    imageView.frame = CGRectMake(0, 0, KScreenW, h);
    
    if (_item.is_bigPicture) {
        _scrollView.contentSize = CGSizeMake(0, h);
        _scrollView.delegate = self;
        //设置缩放比例
        _scrollView.maximumZoomScale = _item.height / h;
    } else {
        imageView.center = CGPointMake(KScreenW * 0.5, KScreenH * 0.5);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}


@end
