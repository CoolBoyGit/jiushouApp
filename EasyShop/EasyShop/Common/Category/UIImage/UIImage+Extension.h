//
//  UIImage+Extension.h
//  EasyShop
//
//  Created by guojian on 16/7/15.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  将图片缩放到指定尺寸
 *
 *  @param size 缩放到的尺寸
 */
- (UIImage *)imageScaleToSize:(CGSize)size;

@end
