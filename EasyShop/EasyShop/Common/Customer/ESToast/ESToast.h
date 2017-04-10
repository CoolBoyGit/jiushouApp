//
//  ESToast.h
//  EasyShop
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESToast : UIView

/**
 *  成功Toast (成功图片 + 文字)
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success;

/**
 *  错误Toast (错误图片 + 文字)
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showError:(NSString *)error;

/**
 *  提示Toast (仅文字)
 */
+ (void)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)showMessage:(NSString *)message;

@end
