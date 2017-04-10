//
//  UserResponse.m
//  EasyShopService
//
//  Created by guojian on 16/5/1.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "UserResponse.h"

@implementation LoginInfo

@end
///** 手机号 */
//@property (nonatomic,copy) NSString *mobile;
///** email */
//@property (nonatomic,copy) NSString *email;
///** 性别 0：男；1：女 */
//@property (nonatomic,strong) NSNumber *sex;
///** 生日 */
//@property (nonatomic,copy) NSString *birthday;
///** 微信开放平台id */
//@property (nonatomic,copy) NSString *open_id;
///** 用户id */
//@property (nonatomic,copy) NSString *uid;
///** 用户头像 */
//@property (nonatomic,copy) NSString *logo;
///** 用户名 */
//@property (nonatomic,copy) NSString *username;
///** 昵称 */
//@property (nonatomic,copy) NSString *nickname;
///*个性签名*/
//@property (nonatomic,copy) NSString *signature;
@implementation UserInfo
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.logo forKey:@"logo"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.mobile=[aDecoder decodeObjectForKey:@"mobile"];
        self.logo=[aDecoder decodeObjectForKey:@"logo"];
        self.username=[aDecoder decodeObjectForKey:@"username"];
        self.email=[aDecoder decodeObjectForKey:@"email"];
        self.nickname=[aDecoder decodeObjectForKey:@"nikename"];
    }
    return self;
}
@end
@implementation UserInfo (Extension)

- (NSString *)displaySex
{
    return self.sex.intValue ? @"女" : @"男";
}

@end

@implementation EombaseInfo

@end
@implementation WeiXinOpenIdInfo


@end
@implementation OtherThemeInfo


@end
