//
//  LTTopTopicView.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/25.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTTopTopicView.h"
#import "LTTopicItem.h"
#import <UIImageView+WebCache.h>
#import "NSDate+LTDate.h"

@interface LTTopTopicView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

@implementation LTTopTopicView

+ (instancetype)viewForXib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}

- (void)setItem:(LTTopicItem *)item{
    
    _item = item;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.profile_image]];
    _nameLabel.text = item.screen_name;
    _textLabel.text = item.text;
    _timeLabel.text = [self timeStr];
    
}

- (NSString *)timeStr{
    NSString *timeStr = _item.create_time;
    //发帖时间字符串 转 时间对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //获取发帖日期对象
    NSDate *createDate = [fmt dateFromString:timeStr];
    //获取发帖日期与当前日期的时间差值
    NSDateComponents *detalCmp = [createDate detalFromNow];
    
    if ([createDate isThisYear]) {//今年
        if ([createDate isToday]) {//今天
            if (detalCmp.hour > 0) {
                timeStr = [NSString stringWithFormat:@"%ld小时前", detalCmp.hour];
            } else if (detalCmp.minute > 0) {
                timeStr = [NSString stringWithFormat:@"%ld分钟前", detalCmp.minute];
            } else {
                timeStr = @"刚刚";
            }
        } else if ([createDate isYesterday]){//昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            timeStr = [fmt stringFromDate:createDate];
        } else {//昨天之前
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            timeStr = [fmt stringFromDate:createDate];
        }
    }

    return timeStr;
}


- (IBAction)moreClick:(id)sender {
    /*
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"举报" otherButtonTitles:@"收藏", nil];
    [actionSheet showInView:self];
     */
    
    UIAlertController *alertVc = [[UIAlertController alloc] init];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:nil]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:nil]];
    
    //拿到根窗口控制器
    UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVc presentViewController:alertVc animated:YES completion:nil];
}

@end
