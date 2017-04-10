//
//  ESUserManager.h
//  EasyShop
//
//  Created by guojian on 16/5/10.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESService.h"

#define kUserManager ([ESUserManager shareManager])
#define kToken ([ESUserManager shareManager].token)

/** 用户登录校验 */
#define ESLoginVerify  \
if (!kUserManager.isLogin){    \
[kUserManager toLoginController]; \
\
return;     \
}


/** 进入后台时间 */
static NSString *const kEnterBackgroundTimeKey = @"kEnterBackgroundTimeKey";

/** 手动登录时间 */
static NSString *const kUserManualLoginTimeKey = @"kUserManualLoginTimeKey";


/** 登录类型 */
typedef NS_ENUM(NSInteger , LoginType)
{
    LoginType_Normal = 1,   //普通登录
    LoginType_WeChat = 5,   //微信登录
    LoginType_QQ = 6,       //QQ登录
};
static NSString *const kUserNikeNotification = @"kUserNikeNotification";//修改昵称通知
static NSString *const kUserSignatureNotification=@"kUserSignatureNotification";//修改个性签名通知
static NSString *const kUserLoginNotification = @"kUserLoginNotification";//登录通知
static NSString *const kUserLogoutNotification = @"kUserLogoutNotification";
static NSString *const kUserInfoUpdateNotification = @"kUserInfoUpdateNotification";
/**更新购物车的通知**/
static NSString *const kCartInfoUpdateNotification = @"kCartInfoUpdateNotification";
/**点击加入购物车通知**/
static NSString *const AddkCartInfoUpdateNotification = @"AddkCartInfoUpdateNotification";

static NSString *const kDidWechatLoginNotification = @"kDidWechatLoginNotification";//微信登录成功通知
static NSString*const KDidWechaatLoginFailer=@"KDidWechaatLoginFailer";//微信登录失败
static NSString *const kDidPaySuccessNotification = @"kDidPaySuccessNotification";//支付成功通知
static NSString*const kWeiXinDidPaySuccessNotification=@"kWeiXinDidPaySuccessNotification";//微信支付成功通知
static NSString *const kDidBindSuccessNotification = @"kDidBindSuccessNotification";//账号绑定成功通知
static NSString *const KClusterDidPaySuccessNotification=@"KClusterDidPaySuccessNotification";//拼团支付成功通知~
static NSString *const kReloadOrderListNotification = @"kReloadOrderListNotification";//刷新订单列表
/**申请退款成功之后的通知**/
static NSString *const kReloadRefoundOrderListNotification=@"kReloadRefoundOrderListNotification";
/**点击加入购物车之后的通知**/
static NSString *const kAddToShopCartNotification=@"kAddToShopCartNotification";
/**当订单状态改变的时候更新待收获等状态的总量数字**/
static NSString *const KKUpdateAllOredrCountNotifacation =@"KKUpdateAllOredrCountNotifacation";
static NSString *const KKUpdateApplicationIconBadgeNumber=@"KKUpdateApplicationIconBadgeNumber";//还没有点击进去客服列表发送的通知
static NSString*const KKupdateHadApplicationIconBadgeNumber=@"KKupdateHadApplicationIconBadgeNumber";//已经点击进去消息列表查看
static NSString*const LoginViewwillDiddisAppear=@"LoginViewwillDiddisAppear";//登录页面即将消失
static NSString*const DeatailLoadWebView=@"DeatailLoadWebView";//详情页已经滑动到了网页页面
static NSString*const ClusterSecondToZero=@"ClusterSecondToZero";//倒计时器跳动减少60秒发送此通知
static NSString*const ClusterMinuteReduce=@"ClusterMinuteReduce";//倒计时器的分钟减少60分发送此通知
static NSString*const CountCLusterPriceChange=@"CountCLusterPriceChange";//点击拼团界面加减号通知底部的发生改变.
static NSString*const TapClusterPopCluster=@"TapClusterPopCluster";//点击拼团详情页面反回到首页的拼团。
static NSString*const  ClickShopCarButtonToShopCar=@"ClickShopCarButtonToShopCar";
static NSString*const  DeleItemInthePostCommet=@"DeleItemInthePostCommet";//发送通知 通知改变当前的放大视图
static NSString*const  EaseMobLoginSuccess=@"EaseMobLoginSuccess";//环信登录成功发送通知
static NSString*const  ESClusterTimeZero=@"ESClusterTimeZero";//剩余拼团时间为零
static NSString*const ESLoginEditPassWordTextfield=@"ESLoginEditPassWordTextfield";//编辑密码输入框
static NSString*const ESLoginButtonCanClick=@"ESLoginButtonCanClick";//通知表格 登录按钮能否点击
static NSString*const ESLoginEditMobileTextfield=@"ESLoginEditMobileTextfield";//编辑帐号输入框
static NSString*const ESLoginClickCellAction=@"ESLoginClickCellAction";//点击登录界面的cell
static NSString*const ESLoginUserImageView=@"ESLoginUserImageView";
@interface ESUserManager : NSObject

+ (instancetype)shareManager;

#pragma mark - 用户登录

/** 是否用户登录 */
@property (nonatomic,assign) BOOL isLogin;
/** 登录token */
@property (nonatomic,copy) NSString *token;

@property (nonatomic,strong) NSArray*array;
/** 用户自动登录 */
- (void)doUserAutoLogin;
/** 用户手动登录 */
- (void)doUserManualLoginWithUsername:(NSString *)username
                             password:(NSString *)password
                                 type:(LoginType)type
                              success:(OkBlock)success
                              failure:(FailureBlock)failure;
/** 清空登录账号 */
- (void)clearLoginAccount;
/** 用户退出登录 */
- (void)doUserLogout;

/** 去登录界面 */
- (void)toLoginController;

/** 重置登录密码 */
- (void)resetLoginPassword:(NSString *)password;

#pragma mark - 用户信息
/** 登录用户信息 */
@property (nonatomic,strong) UserInfo *userInfo;

- (void)fetchUserInfo;
#pragma mark -是否下载以及使用主题包
/** 判断是否使用文件包里面的东西*/
@property(nonatomic,assign) BOOL isUseOtherImage;
/** 当前使用的文件包名字*/
@property (nonatomic,copy) NSString*nowUseThemeName;

/**获取沙盒路径*/
@property (nonatomic,copy) NSString*rootString;
/**需要使用的背景颜色*/
@property (nonatomic,copy) NSString*nowBgColor;
/** 当前用户切换的主题模式*/
@property (nonatomic,copy) NSString*themeColor;
#pragma mark - 保存的搜索关键字

/** 保存的历史关键字 ( item : NSString ) */
@property (nonatomic,strong,readonly) NSMutableArray *historyItems;
/** 添加历史搜索关键字 */
- (void)addHistoryKeyword:(NSString *)keyword;
/** 清除历史搜索关键字 */
- (void)clearHistoryKeyword;
-(void)delectHistoryKey:(NSString*)hisKeyWord;
@end

@interface ESUserManager (Extension)
@property (nonatomic,copy,readonly) NSString*themRootRoute;
@property (nonatomic,copy,readonly) NSString* nowDate;

@end
