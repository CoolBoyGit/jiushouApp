//
//  ESUsecerHeadView.h
//  EasyShop
//
//  Created by 就手国际 on 17/1/4.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESUsecerHeadView : UIView
@property (nonatomic,strong) UIView* centerLineView;
/** 用户信息 */
@property (nonatomic,strong) UserInfo *userInfo;
/*没有登录状态下的按钮*/
@property (nonatomic, strong) UIButton        *loginButton;//登陆按钮
@property (nonatomic, strong) UIButton      *registerButton;//注册按钮
/*登录状态下面的label*/
@property (nonatomic,strong) UILabel*nickNameLabel;//昵称
@property (nonatomic,strong) UILabel*signatureLable;//签名
@property (nonatomic,copy) void (^loaginBlock) ();
@property (nonatomic,copy) void (^registerBlock)();
@property (nonatomic,copy) void (^userCenterBlock)();
@end
