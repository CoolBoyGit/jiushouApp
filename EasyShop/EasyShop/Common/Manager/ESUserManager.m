//
//  ESUserManager.m
//  EasyShop
//
//  Created by guojian on 16/5/10.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESUserManager.h"
#import <UIAlertView+BlocksKit.h>
#import "ESLoginViewController.h"
#import "ESBlindViewController.h"
#import "ESLoginModel.h"
#import "ESLoginDbManager.h"
static NSString *const kUserNameKey         = @"ESUserNameKey";
static NSString *const kUserPasswordKey     = @"ESUserPasswordKey";
static NSString *const kUserLoginTypeKey    = @"ESUserLoginTypeKey";

static NSString *const kHisoryKeywordKey    = @"ESHistoryKeywordKey";//历史搜索关键字key

@implementation ESUserManager

+ (instancetype)shareManager
{
    static ESUserManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ESUserManager alloc] init];
    });
    return manager;
}
-(NSString *)rootString{
     NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return path;
}
#pragma mark - 用户登录

//这里是判断自动
- (void)doUserAutoLogin
{
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:kUserNameKey];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:kUserPasswordKey];
    int     type = [[[NSUserDefaults standardUserDefaults] objectForKey:kUserLoginTypeKey] intValue];
    type = type > 0 ? type : 1;
    //都不为空的时候，去自动登录。
    if (userName) {
        [self doUserLoginWithUsername:userName password:password type:type success:^{} failure:^(NSError *error){}];
    }
}

- (void)doUserManualLoginWithUsername:(NSString *)username
                             password:(NSString *)password
                                 type:(LoginType)type
                              success:(OkBlock)success
                              failure:(FailureBlock)failure
{
    
    [self doUserLoginWithUsername:username password:password type:type success:^{
        
        //保存手动登录时间点
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:kUserManualLoginTimeKey];
        [kUserManager fetchUserInfo];
        //在这里注册一个通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginNotification object:nil];
        
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)doUserLoginWithUsername:(NSString *)username
                       password:(NSString *)password
                           type:(LoginType)type
                        success:(OkBlock)success
                        failure:(FailureBlock)failure
{
    UserLoginRequest *request = [UserLoginRequest request];
    request.type     = [NSNumber numberWithInt:type];
    request.username = username;
    request.password = password;
    
    @weakify(self);
    [ESService userLoginRequest:request success:^(LoginInfo *response) {
        @strongify(self);
        
        if (response.status.intValue == -3) {//去绑定页面
            ESBlindViewController *bind = [[ESBlindViewController alloc] init];
            //            bind.isNavHidden = YES;
            switch (type) {
                case LoginType_WeChat://微信
                    bind.bindType = ESBindType_Wechat;
                    break;
                case LoginType_QQ://QQ
                    bind.bindType = ESBindType_QQ;
                    break;
                default:
                    break;
            }
            bind.open_id = request.username;
            [[AppDelegate shared] pushViewController:bind animated:YES];
            
            failure(nil);
        }else{
            self.isLogin = YES;
            
            [[NSUserDefaults standardUserDefaults] setObject:request.username forKey:kUserNameKey];
            [[NSUserDefaults standardUserDefaults] setObject:request.password forKey:kUserPasswordKey];
            [[NSUserDefaults standardUserDefaults] setObject:request.type forKey:kUserLoginTypeKey];
            self.token = response.token;
            //请求用户信息
            [kUserManager fetchUserInfo];
            //在这里注册一个通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginNotification object:nil];
            
            if (success) {
                success();
            }
            
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(NSArray *)array{
    if (_array==nil) {
        _array=[NSArray array];
    }
    return _array;
}
- (void)clearLoginAccount
{
    self.isLogin = NO;
    //清除用户信息
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kUserNameKey];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kUserPasswordKey];
    self.userInfo = nil;
}

- (void)doUserLogout
{
    UserLogoutRequest *request = [UserLogoutRequest request];
    
    @weakify(self);
    [ESService userLogoutRequest:request success:^{
        @strongify(self);
        
        [self clearLoginAccount];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogoutNotification object:nil];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)toLoginController
{
    ESLoginViewController *login = [[ESLoginViewController alloc] init];
    //    login.isNavHidden = YES;
    [[AppDelegate shared].curNav pushViewController:login animated:NO];
}

- (void)resetLoginPassword:(NSString *)password
{
    if (self.isLogin && password) {//登录状态，需要重置登录密码
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:kUserPasswordKey];
    }
}

#pragma mark - 用户信息

- (void)fetchUserInfo
{
    UserRequest *request = [UserRequest request];
    @weakify(self);
    [ESService userRequest:request success:^(UserInfo *response) {
        @strongify(self);
        self.userInfo = response;
        ESLoginModel*model=[[ESLoginModel alloc]init];
        model.mobile=response.mobile;
        model.imageStr=response.logo;
        ESLoginDbManager*manager=[ESLoginDbManager sharedESLoginDbManager];
        [manager insertInto:model];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserInfoUpdateNotification object:nil];
    } failure:^(NSError *error) {
    }];
   
}

#pragma mark - 保存的搜索关键字
- (NSMutableArray *)historyItems
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kHisoryKeywordKey];
}
-(void)delectHistoryKey:(NSString*)hisKeyWord{
    NSMutableArray*arr=[NSMutableArray arrayWithArray:self.historyItems];
    [arr removeObject:hisKeyWord];
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:kHisoryKeywordKey];

    
}
- (void)addHistoryKeyword:(NSString *)keyword
{
    if ([NSString isEmptyString:keyword]) {//keywor为空 return
        return;
    }
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.historyItems];
    //如果该关键字之前已经存在，删除之前的
    [mArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([keyword isEqualToString:obj]) {
            [mArr removeObject:obj];
        }
    }];
    //插入第一位
    [mArr insertObject:keyword atIndex:0];
    //保存
    [[NSUserDefaults standardUserDefaults] setObject:[mArr copy] forKey:kHisoryKeywordKey];
}

- (void)clearHistoryKeyword
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kHisoryKeywordKey];
}

@end
@implementation ESUserManager (Extension)

-(NSString *)themRootRoute{
    return [self.rootString stringByAppendingPathComponent:self.nowUseThemeName];
}
-(NSString*)nowDate{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}
@end
