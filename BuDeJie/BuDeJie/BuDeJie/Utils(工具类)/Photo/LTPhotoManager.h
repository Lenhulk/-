//
//  LTPhotoManager.h
//  BuDeJie
//
//  Created by Lenhulk on 16/10/29.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTPhotoManager : NSObject
+ (void)savePhoto:(UIImage *)image albumTitle:(NSString *)albumTitle completionHandler:( void(^)(BOOL success, NSError * error))completionHandler;
@end
