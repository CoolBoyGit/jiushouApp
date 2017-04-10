//
//  UIImage+extention.m
//  EasyShop
//
//  Created by 就手国际 on 16/12/30.
//  Copyright © 2016年 ldz. All rights reserved.
//

#import "UIImage+extention.h"

@implementation UIImage (extention)
+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
