//
//  AppDelegate.m
//  EasyShop
//
//  Created by wcz on 16/3/23.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "AppDelegate.h"
#import "ESTabBarController.h"
#import "ESLoginViewController.h"
#import "ESRegisterController.h"
#import "ESWelcomeController.h"
#import "GSTimeTool.h"
#import "StatusWindows.h"
#import "EaseMob.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "JPUSHService.h"
#import "AppDelegate+EaseMob.h"
#import "StatusBarScrollViewTool.h"
#import "IQKeyboardManager.h"
#import <AdSupport/ASIdentifierManager.h>
#import <UserNotifications/UserNotifications.h>
#import "GetAlipaySDKResult.h"
//用来监听网络状态
#import "DZNetworkTool.h"
#import "Reachability.h"
#import <SSZipArchive.h>
#import "ESHttpTool.h"
#import "ESLoginDbManager.h"
@interface AppDelegate ()<WXApiDelegate,JPUSHRegisterDelegate,SSZipArchiveDelegate>
{
    Reachability *_reacha;
    NetworkStates _preStatus;
}
@property (nonatomic,copy)NSString*imageFilePath;
@property (nonatomic,copy)NSString*fileString;
@end
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOption{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
   
    //注册调用环信
       [self easemobApplication:application didFinishLaunchingWithOptions:launchOption];
    //注册微信
    [WXApi registerApp:kWeixin_AppId withDescription:@"就手国际"];

    // 注册apns通知
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) // iOS10
    {

        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) // iOS8, iOS9
    {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    }
    else // iOS7
    {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    }
        // 注册极光推送
    [JPUSHService setupWithOption:nil appKey:kJPush_AppKey channel:nil apsForProduction:NO advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0)
        {
        [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"registrationID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            DZLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];

    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[ESLoginDbManager sharedESLoginDbManager]getAllThemeinfo:^(NSMutableArray *array) {
        if (array.count!=0) {
            kUserManager.isUseOtherImage=NO;
             [self setupRootController];
        }
        else{
            [self setupRootController];
        }
    }];
   
    [self.window makeKeyAndVisible];
    [self checkNetworkStates];
    NSFileManager*fileManager=[NSFileManager defaultManager];
//如果是需要下载的是压缩包的文件,那么需要添加后缀
    [ESService getIsNeeddownloadThemeZipRequest:nil success:^(NSArray *response) {
        for (OtherThemeInfo*info in response) {
            [[ESLoginDbManager sharedESLoginDbManager]creatThemeTable];
            [[ESLoginDbManager sharedESLoginDbManager]insterInfo:info];
            //插入成功之后通过异步下载
            self.fileString=[kUserManager.rootString stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip",info.package_name]];
            if ([fileManager fileExistsAtPath:[kUserManager.rootString stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",info.package_name]]]) {
                
            }else{
                [ESHttpTool downloadFileWithURL:info.url request:nil savedPath:self.fileString downloadSuccess:^(NSURLResponse *response, NSURL *filePath) {
                    DZLog(@"%@",@"下载成功");
                    NSError*error;
                    [SSZipArchive unzipFileAtPath:self.fileString toDestination:kUserManager.rootString overwrite:YES password:nil error:&error delegate:self];
                        } downloadFailure:^(NSError *error) {
                            
                        } downloadProgress:^(NSProgress *downloadProgress) {
            }];

            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
        return YES;
}
#pragma mark SSZipArchivedelegate
- (void)zipArchiveWillUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo {
    NSLog(@"将要解压。");
}
- (void)zipArchiveDidUnzipFileAtIndex:(NSInteger)fileIndex totalFiles:(NSInteger)totalFiles archivePath:(NSString *)archivePath fileInfo:(unz_file_info)fileInfo{
    NSLog(@"解压完成！");
    NSError*error;
    BOOL b= [[NSFileManager defaultManager]removeItemAtPath:self.fileString error:&error];
    if (b) {
        DZLog(@"%@",@"删除成功");
        
    }else{
        DZLog(@"%@",error);
    }

}
// 实时监控网络状态
- (void)checkNetworkStates
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange) name:kReachabilityChangedNotification object:nil];
    _reacha = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    [_reacha startNotifier];
}

- (void)networkChange
{
    NSString *tips;
    NetworkStates currentStates = [DZNetworkTool getNetworkStates];
    if (currentStates == _preStatus) {
        return;
    }
    _preStatus = currentStates;
    switch (currentStates) {
        case NetworkStatesNone:
            tips = @"当前无网络, 请检查您的网络状态";
            break;
        case NetworkStates2G:
            tips = @"切换到了2G网络";
            break;
        case NetworkStates3G:
            tips = @"切换到了3G网络";
            break;
        case NetworkStates4G:
            tips = @"当前是4G网络，请注意你的流量";
            break;
        default:
            break;
    }
    
    if (tips.length) {
        [[[UIAlertView alloc] initWithTitle:@"就手国际" message:tips delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}
- (void)setupRootController
{
    if ([GSTimeTool isManualLoginOverTime]) {//超过登录时间
        [kUserManager clearLoginAccount];
    }else{//自动登录
        [kUserManager doUserAutoLogin];
    }
    ESWelcomeController*welcomeVc=[[ESWelcomeController alloc]init];
    self.window.rootViewController=welcomeVc;
}
//作用是锁定屏幕竖屏
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //作用 回到顶部
    [super touchesBegan:touches withEvent:event];
    
    CGPoint location = [[[event allTouches] anyObject] locationInView:self.window];
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    
    if (CGRectContainsPoint(statusBarFrame, location)) {
        [StatusBarScrollViewTool scrollViewScrollToTop];
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
   //只会显示比零大的数字
    //设计思路 当后台有客服信息的时候，就发送一个通知，然后把当前的信息数目传递过来，然后跟新当前的数字
    NSInteger totalNum =  [[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:totalNum];
    
}
-(void)updateIconNum:(NSNotification*)noti{
//    NSInteger total=[noti.object integerValue];
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:total];
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    //保存进入后台时间
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:kEnterBackgroundTimeKey];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //清空badge
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    //判断超时，重新登录
    if ([GSTimeTool isEnterBackgroundOverTime]) {//超过30分钟，进入自动登录
        [kUserManager doUserAutoLogin];
    }
    
}
#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //DLog(@"2-1 didReceiveRemoteNotification remoteNotification = %@", userInfo);
    
    // apn 内容获取：
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    //DLog(@"2-2 didReceiveRemoteNotification remoteNotification = %@", userInfo);
    if ([userInfo isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = userInfo[@"aps"];
        NSString *content = dict[@"alert"];
    }
    
    if (application.applicationState == UIApplicationStateActive)
    {
        // 程序当前正处于前台
    }
    else if (application.applicationState == UIApplicationStateInactive)
    {
        // 程序处于后台
    }
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
     return [self handleOpenUrl:url];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self handleOpenUrl:url];
}

//这里是客户端返回
- (BOOL)handleOpenUrl:(NSURL *)url
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            
            NSNumber *resultStatus = [resultDic objectForKey:@"resultStatus"];
            if (resultStatus.integerValue == 9000) {//支付成功
                [ESToast showSuccess:@"支付成功！"];
          NSDictionary*dic= [GetAlipaySDKResult VEComponentsStringToDic:[resultDic objectForKey:@"result"] withSeparateString:@"&" AndSeparateString:@"="];
                //用来传递参数
                NSString*str=[dic objectForKey:@"out_trade_no"];
                NSDictionary*newDic=[NSDictionary dictionaryWithObject:str forKey:@"order_id"];
                [[NSNotificationCenter defaultCenter]postNotificationName:kDidPaySuccessNotification object:nil userInfo:newDic];
                //用来刷新界面
                [[NSNotificationCenter defaultCenter] postNotificationName:KClusterDidPaySuccessNotification object:nil];
            }else{//支付失败
                [ESToast showError:@"支付失败！"];
            }
        }];
        return YES;
    }
    return  [WXApi handleOpenURL:url delegate:self] ||
            [TencentOAuth HandleOpenURL:url];
}
//微信
#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp
{
    /*
     errCode 错误码
     WXSuccess           = 0,    < 成功
     WXErrCodeCommon     = -1,   < 普通错误类型
     WXErrCodeUserCancel = -2,   < 用户点击取消并返回
     WXErrCodeSentFail   = -3,   < 发送失败
     WXErrCodeAuthDeny   = -4,   < 授权失败
     WXErrCodeUnsupport  = -5,   < 微信不支持
     */
    
    
    if([resp isKindOfClass:[PayResp class]]){//微信支付
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg = [NSString stringWithFormat:@"支付结果"];
       
        switch (resp.errCode) {
            case WXSuccess:
            {
                
                
                [ESToast showSuccess:@"支付成功！"];
                NSString*str=[[NSUserDefaults standardUserDefaults]objectForKey:@"order_id"];
                NSDictionary*dic=[NSDictionary dictionaryWithObject:str forKey:@"order_id"];
                [[NSNotificationCenter defaultCenter]postNotificationName:kDidPaySuccessNotification object:nil userInfo:dic];
                [[NSNotificationCenter defaultCenter] postNotificationName:KClusterDidPaySuccessNotification object:nil];
            }
                break;
            default:
            {
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                [ESToast showError:@"支付失败！"];
            }
                break;
        }
    }
    
    if ([resp isKindOfClass:[SendAuthResp class]]) {//微信登录
        
        SendAuthResp *saResp=(SendAuthResp *)resp;
        if (saResp.errCode == WXSuccess) {//登录成功
            [[NSNotificationCenter defaultCenter] postNotificationName:kDidWechatLoginNotification object:saResp.code];
        }else{
            [[NSNotificationCenter defaultCenter]postNotificationName:KDidWechaatLoginFailer object:nil];
        }
    }
   
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {//微信分享
        SendMessageToWXResp *smResp = (SendMessageToWXResp *)resp;
        if (smResp.errCode == WXSuccess) {
            [ESToast showSuccess:@"分享成功"];
        }else{
            [ESToast showError:@"分享失败"];
        }
    }
}

#pragma mark - Tool
// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}


@end
