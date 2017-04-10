//
//  ICAlertView.h
//  iCare
//
//  Created by YURI_JOU on 15/12/2.
//  Copyright © 2015年 oenius. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ICAlertDelegate <NSObject>

@optional

- (void)ICAlertDidPickerSource:(NSString *)string;
- (void)ICAlertShareDidSelectIndex:(NSInteger)index;

@end

@interface ICAlert : NSObject

+ (instancetype)alert;

- (void)showShareViewDelegate:(id<ICAlertDelegate>)delegate;
- (void)selectTypeInfoCallBack:(void (^)(NSInteger ))callBack;
- (void)showPickerVieTextField:(UIView *)textField andComFromRefound:(BOOL) isComfromRefund;;


@end
