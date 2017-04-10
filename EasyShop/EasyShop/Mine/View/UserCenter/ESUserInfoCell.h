//
//  ESUserInfoCell.h
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/9.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESUserInfoCell : UITableViewCell

/** 用户信息 */
@property (nonatomic,strong) UserInfo *userInfo;
/*没有登录状态下的按钮*/
@property (nonatomic, strong) UIButton        *loginButton;//登陆按钮
@property (nonatomic, strong) UIButton      *registerButton;//注册按钮
/*登录状态下面的label*/
@property (nonatomic,strong) UILabel*nickNameLabel;//昵称
@property (nonatomic,strong) UILabel*signatureLable;//签名
@property (nonatomic,strong) void (^loaginBlock) ();
@property (nonatomic,strong) void (^registerBlock)();
@end
