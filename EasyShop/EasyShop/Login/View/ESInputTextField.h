//
//  ESInputTextField.h
//  EasyShop
//
//  Created by wcz on 16/4/3.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESInputTextFieldDelete <NSObject>
- (void)inputTextFieldDidChange:(NSString *)InputTextFieldText;

@end


@interface ESInputTextField : UITextField

@property (nonatomic, assign) BOOL    isNeedChangeClear;//是否改变清除按钮的位置
@property (nonatomic ,assign) BOOL isLogin;
@property (nonatomic,assign) BOOL isHiddenButton;//yes 隐藏帐号 NO隐藏密码
@property (nonatomic,strong) UIImage*image;

@property (nonatomic,assign) BOOL isHiden;
@property (nonatomic ,assign) id<ESInputTextFieldDelete>TextDelete;
- (instancetype)initWithImage:(UIImage *)image;
- (instancetype)initWithImage:(UIImage *)image needChange:(BOOL)needChange andIsLogin:(BOOL)isLogin;
@property (nonatomic,copy) void (^mobileBlock)( BOOL isHidden);
@property (nonatomic,copy) void (^passWordBlock)( BOOL isHidden);
@end
