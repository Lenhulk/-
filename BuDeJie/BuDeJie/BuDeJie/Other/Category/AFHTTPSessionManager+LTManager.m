//
//  AFHTTPSessionManager+LTManager.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/19.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "AFHTTPSessionManager+LTManager.h"

@implementation AFHTTPSessionManager (LTManager)

+ (instancetype)lh_manager{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    mgr.responseSerializer = response;
    
    return mgr;
}

@end
