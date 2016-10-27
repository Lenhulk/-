//
//  NSDate+LTDate.h
//  BuDeJie
//
//  Created by Lenhulk on 16/10/27.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LTDate)
- (BOOL) isToday;
- (BOOL) isYesterday;
- (BOOL) isThisYear;
- (NSDateComponents *)detalFromNow;
@end
