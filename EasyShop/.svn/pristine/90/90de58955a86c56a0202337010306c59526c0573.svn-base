//
//  UserRequest.h
//  EasyShopService
//
//  Created by guojian on 16/5/1.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "BaseRequest.h"


/** 4.1 取当前已登陆用户的个人信息 */
@interface UserRequest : BaseRequest

@end

/** 4.2 用户注册 */
@interface UserAddRequest : BaseRequest

/** 用户名 */
@property (nonatomic,copy) NSString *username;
/** 用户密码 */
@property (nonatomic,copy) NSString *password;
/** 短信验证码 */
@property (nonatomic,copy) NSString *verify;

@end

/** 4.3 用户登录 */
@interface UserLoginRequest : BaseRequest

/** 用户名  (第三方登录：传 open_id) */
@property (nonatomic,copy) NSString *username;
/** 用户密码 （第三方登录：传空） */
@property (nonatomic,copy) NSString *password;
/** type,  1：（默认为1）正常手机账号登陆；5:微信登陆，6：QQ */
@property (nonatomic,strong) NSNumber *type;

@end

/** 4.4 编辑用户资料 */
@interface UserEditRequest : BaseRequest

/** 昵称 */
@property (nonatomic,copy) NSString *nickname;
/** 性别 */
@property (nonatomic,strong) NSNumber *sex;
/** 头像 */
@property (nonatomic,copy) NSString *logo;
/** 生日 */
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *signature;
@end

/** 4.5 用户退出登录 */
@interface UserLogoutRequest : BaseRequest

@end

/** 4.6 绑定第三方 */
@interface UserBindingRequest : BaseRequest

/** 手机 */
@property (nonatomic,copy) NSString *mobile;
/** open_id  code */
@property (nonatomic,copy) NSString *open_id;
/** type (1:微信 2：QQ) */
@property (nonatomic,strong) NSNumber *type;
/** verify */
@property (nonatomic,copy) NSString *verify;
/** 未注册用户带上注册密码，已注册留空 */
@property (nonatomic,copy) NSString *password;

@end

/** 4.7 重置用户密码 */
@interface UserResetRequest : BaseRequest

/** 账号手机号码 */
@property (nonatomic,copy) NSString *mobile;
/** 用户新密码 */
@property (nonatomic,copy) NSString *password;
/** 短信验证码 */
@property (nonatomic,copy) NSString *verify;

@end
/**获取用户opeId**/
@interface GetWeiXinOpenIdRequest : BaseRequest
@property (nonatomic,copy) NSString*code;
@end








