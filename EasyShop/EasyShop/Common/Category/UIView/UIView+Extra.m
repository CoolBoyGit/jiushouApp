//
//  UIView+Extra.m
//  EasyShop
//
//  Created by wcz on 16/3/26.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "UIView+Extra.h"

@implementation UIView (Extra)
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return (self.frame.size.width);
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return (self.frame.size.height);
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)screenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}

- (CGFloat)screenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}

- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setPy_x:(CGFloat)py_x
{
    CGRect frame = self.frame;
    frame.origin.x = py_x;
    self.frame = frame;
}

- (CGFloat)py_x
{
    return self.py_origin.x;
}

- (void)setPy_centerX:(CGFloat)py_centerX
{
    CGPoint center = self.center;
    center.x = py_centerX;
    self.center = center;
}

- (CGFloat)py_centerX
{
    return self.center.x;
}

-(void)setPy_centerY:(CGFloat)py_centerY
{
    CGPoint center = self.center;
    center.y = py_centerY;
    self.center = center;
}

- (CGFloat)py_centerY
{
    return self.center.y;
}

- (void)setPy_y:(CGFloat)py_y
{
    CGRect frame = self.frame;
    frame.origin.y = py_y;
    self.frame = frame;
}

- (CGFloat)py_y
{
    return self.frame.origin.y;
}

- (void)setPy_size:(CGSize)py_size
{
    CGRect frame = self.frame;
    frame.size = py_size;
    self.frame = frame;
    
}

- (CGSize)py_size
{
    return self.frame.size;
}

- (void)setPy_height:(CGFloat)py_height
{
    CGRect frame = self.frame;
    frame.size.height = py_height;
    self.frame = frame;
}

- (CGFloat)py_height
{
    return self.frame.size.height;
}

- (void)setPy_width:(CGFloat)py_width
{
    CGRect frame = self.frame;
    frame.size.width = py_width;
    self.frame = frame;
    
}
- (CGFloat)py_width
{
    return self.frame.size.width;
}

- (void)setPy_origin:(CGPoint)py_origin
{
    CGRect frame = self.frame;
    frame.origin = py_origin;
    self.frame = frame;
}

- (CGPoint)py_origin
{
    return self.frame.origin;
}





- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

@end
