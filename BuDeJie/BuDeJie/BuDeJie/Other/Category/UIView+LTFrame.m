//
//  UIView+LTFrame.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/17.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "UIView+LTFrame.h"

@implementation UIView (LTFrame)
- (CGFloat)lh_x{
    return self.frame.origin.x;
}

- (CGFloat)lh_y{
    return self.frame.origin.y;
}

- (CGFloat)lh_width{
    return self.frame.size.width;
}

- (CGFloat)lh_height{
    return self.frame.size.height;
}

- (void)setLh_x:(CGFloat)lh_x{
    CGRect frame = self.frame;
    frame.origin.x = lh_x;
    self.frame = frame;
}

- (void)setLh_y:(CGFloat)lh_y{
    CGRect frame = self.frame;
    frame.origin.y = lh_y;
    self.frame = frame;
}

- (void)setLh_width:(CGFloat)lh_width{
    CGRect frame = self.frame;
    frame.size.width = lh_width;
    self.frame = frame;
}

- (void)setLh_height:(CGFloat)lh_height{
    CGRect frame = self.frame;
    frame.size.height = lh_height;
    self.frame = frame;
}
@end
