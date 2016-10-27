//
//  NSDate+LTDate.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/27.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "NSDate+LTDate.h"

@implementation NSDate (LTDate)

- (BOOL) isThisYear{
    //获取日历组件
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取调用者的日期年份
    NSDateComponents *createCmp = [calendar components:NSCalendarUnitYear fromDate:self];
    //获取当前时间的日期年份
    NSDate *curDate = [NSDate date];
    NSDateComponents *curCmp = [calendar components:NSCalendarUnitYear fromDate:curDate];
    //返回比较值
    return createCmp.year == curCmp.year;
}

- (BOOL) isToday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar isDateInToday:self];   //谁调用传入谁
}

- (BOOL) isYesterday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar isDateInYesterday:self];
}

- (NSDateComponents *)detalFromNow{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:self toDate:[NSDate date] options:NSCalendarWrapComponents];
}

@end
