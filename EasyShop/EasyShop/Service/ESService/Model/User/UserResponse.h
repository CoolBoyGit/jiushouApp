//
//  UserResponse.h
//  EasyShopService
//
//  Created by guojian on 16/5/1.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 登录信息  */
@interface LoginInfo : NSObject

/**  >0 ：登录成功 ； -3:表示第三方登录为绑定 */
@property (nonatomic,strong) NSNumber *status;
/** 用户id */
@property (nonatomic,copy) NSString *uid;
/** 登录token */
@property (nonatomic,copy) NSString *token;

@end

/**
 *  用户的个人信息
 */
@interface UserInfo : NSObject<NSCoding>

/** 手机号 */
@property (nonatomic,copy) NSString *mobile;
/** email */
@property (nonatomic,copy) NSString *email;
/** 性别 0：男；1：女 */
@property (nonatomic,strong) NSNumber *sex;
/** 生日 */
@property (nonatomic,copy) NSString *birthday;
/** 微信开放平台id */
@property (nonatomic,copy) NSString *open_id;
/** 用户id */
@property (nonatomic,copy) NSString *uid;
/** 用户头像 */
@property (nonatomic,copy) NSString *logo;
/** 用户名 */
@property (nonatomic,copy) NSString *username;
/** 昵称 */
@property (nonatomic,copy) NSString *nickname;
/*个性签名*/
@property (nonatomic,copy) NSString *signature;
@end
@interface UserInfo (Extension)

/** 显示的性别 */
@property (nonatomic,copy,readonly) NSString *displaySex;

@end


@interface EombaseInfo : NSObject

/** 用户密码*/
@property (nonatomic,copy) NSString *password;
/** 用户id */
@property (nonatomic,copy) NSString *uid;
/** 用户账号 */
@property (nonatomic,copy) NSString *username;

@end
@interface WeiXinOpenIdInfo : NSObject
@property (nonatomic,copy) NSString*open_id;

@end

@interface OtherThemeInfo : NSObject
@property (nonatomic,copy) NSString*version;
@property (nonatomic,copy) NSString*sub_version;
@property (nonatomic,copy) NSString*start_time;
@property (nonatomic,copy) NSString*end_time;
@property (nonatomic, copy) NSString*url;
@property (nonatomic,copy) NSString *md5;
@property (nonatomic,copy) NSString*package_name;
@end

