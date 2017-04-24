
//  Created by 弓虽_子 on 16/5/15.
//  Copyright © 2016年 弓虽_子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XQCenterTitleBtn : UIButton
//图片名称
@property (nonatomic, copy) NSString *imageName;
//标题
@property (nonatomic, copy) NSString *title;

+ (instancetype)centerTitleBtnWithImageName:(NSString *)imageN titleName:(NSString *)title;

@end
