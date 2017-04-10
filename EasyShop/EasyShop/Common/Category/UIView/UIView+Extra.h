//
//  UIView+Extra.h
//  EasyShop
//
//  Created by wcz on 16/3/26.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extra)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic,readonly) CGFloat screenX;
@property(nonatomic,readonly) CGFloat screenY;
@property(nonatomic,readonly) CGFloat screenViewX;
@property(nonatomic,readonly) CGFloat screenViewY;
@property(nonatomic,readonly) CGRect screenFrame;

@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;

@property (nonatomic, assign) CGFloat py_x;
@property (nonatomic, assign) CGFloat py_y;
@property (nonatomic, assign) CGFloat py_centerX;
@property (nonatomic, assign) CGFloat py_centerY;
@property (nonatomic, assign) CGFloat py_width;
@property (nonatomic, assign) CGFloat py_height;
@property (nonatomic, assign) CGSize  py_size;
@property (nonatomic, assign) CGPoint py_origin;
- (void)removeAllSubviews;

@end
