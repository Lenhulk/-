//
//  LTPhotoManager.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/29.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTPhotoManager.h"
#import <Photos/Photos.h>

@implementation LTPhotoManager

+ (PHAssetCollection *)fetchAssetCollection:(NSString *)albumTitle{
    
    PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in fetchResult) {
        if ([assetCollection.localizedTitle isEqualToString:albumTitle]) {
            return assetCollection;
        }
    }
    return nil;
}

+ (void)savePhoto:(UIImage *)image albumTitle:(NSString *)albumTitle completionHandler:( void(^)(BOOL success, NSError * error))completionHandler{
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //创建自定义相册
        //        PHAssetCollectionChangeRequest *collectionRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"BaiSiBuDeSister"];
        
        //获取之前的相册
//        PHAssetCollection *assetCollection = [self fetchAssetCollection:albumTitle];
        PHAssetCollection *assetCollection = [self fetchAssetCollection:albumTitle];
        PHAssetCollectionChangeRequest *request;    //创建请求
        if (assetCollection) {  //已有相册
            request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else {    //未创建该相册
            request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumTitle];
        }
        //保存图片到系统相册
        PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        //定义占位图片保存到自定义的相册
        PHObjectPlaceholder *placeHolder = [assetRequest placeholderForCreatedAsset];
        //用将要保存的图片替换占位图片
        [request addAssets:@[placeHolder]];
        
    } completionHandler:completionHandler]; //这种写法的意思是只要completionHandler有值就回调进入completionHandler方法
}
@end
