//
//  ESToast.m
//  EasyShop
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESToast.h"
#import <MBProgressHUD.h>

@implementation ESToast

/**
 *  成功Toast (成功图片 + 文字)
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self showMBHUDText:success image:nil toView:view];
}
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:kKeyWindow];
}

/**
 *  错误Toast (错误图片 + 文字)
 */
+ (void)showError:(NSString *)error toView:(UIView *)view
{
    [self showMBHUDText:error image:@"toast_error" toView:view];
}
+ (void)showError:(NSString *)error
{
    [self showError:error toView:kKeyWindow];
}

/**
 *  提示Toast (仅文字)
 */
+ (void)showMessage:(NSString *)message toView:(UIView *)view
{
    return [self showMBHUDText:message image:nil toView:view];
}
+ (void)showMessage:(NSString *)message
{
    [self showMessage:message toView:kKeyWindow];
}

#pragma mark - Tool

+ (void)showMBHUDText:(NSString *)text
                image:(NSString *)image
               toView:(UIView *)view
{
    if (text&&![text isEqualToString:@""]) {
        UIView *toView      = view ? view : [[UIApplication sharedApplication].windows lastObject];
        MBProgressHUD *hud  = [MBProgressHUD showHUDAddedTo:toView animated:YES];
        if (image){//有图片
            hud.mode        = MBProgressHUDModeCustomView;
            hud.customView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
        }else{
            hud.mode        = MBProgressHUDModeText;
        }
        
        hud.labelText       = text;
        hud.labelFont       = [UIFont systemFontOfSize:12];
        
        //delay秒后自动消失
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.0];
    }
}

@end
