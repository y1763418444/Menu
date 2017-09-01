//
//  UIView+Extension.m
//  HorseRaceLamp
//
//  Created by msy on 2017/8/24.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setX:(CGFloat)x{
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width{
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size{
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin{
    self.frame = CGRectMake(origin.x, origin.y, self.width, self.height);
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setMaxX:(CGFloat)maxX{
    self.x = maxX - self.width;
}

- (CGFloat)maxX{
    return self.x + self.width;
}

- (void)setMinX:(CGFloat)minX{
    self.x = minX;
}

- (CGFloat)minX{
    return self.x;
}

- (void)setMinY:(CGFloat)minY{
    self.y = minY;
}

- (CGFloat)minY{
    return self.y;
}

- (void)setMaxY:(CGFloat)maxY{
    self.y = maxY - self.height;
}

- (CGFloat)maxY{
    return self.y + self.height;
}

@end
