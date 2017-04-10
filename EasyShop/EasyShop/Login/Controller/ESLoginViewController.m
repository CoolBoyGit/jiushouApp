
#import "ESLoginViewController.h"
#import "ESInputTextField.h"
#import "ESThreeLoginView.h"
#import "ESRegisterController.h"
#import "ESTabBarController.h"
#import "ESForgetPasswordController.h"

#import "ESService.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "EaseMob.h"
#import "ESLoginViewController.h"
#import "WarningControlView.h"
#import "ESLoginModel.h"
#import "ESLoginCell.h"
#import "ESLoginFooterView.h"
#import "ESLoginHeaderView.h"
#import "ESLoginDbManager.h"
@interface ESLoginViewController ()<ESThreeLoginDelegate,TencentSessionDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,ESLoginFooterThreeViewDelegate>
{
    TencentOAuth *_tencentOAuth;//腾讯授权
}

@property (nonatomic, strong) ESInputTextField *mobileNumTextField;
@property (nonatomic, strong) ESInputTextField *passWordTextField;
@property (nonatomic,strong) UIButton *loginButton;
/** indicator */
@property (nonatomic,strong) ESIndicator *indcator;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray*modelArray;//存放的是登录界面的cell的model

@property (nonatomic,assign) BOOL isHiddenCell;//yes显示cell no隐藏cell

@property (nonatomic,copy) NSString*passWordStr;
@property (nonatomic,copy) NSString*mobileStr;

@property (nonatomic,strong) NSMutableArray*usersArray;

@end

@implementation ESLoginViewController
-(NSMutableArray *)usersArray{
    if (_usersArray==nil) {
        _usersArray=[NSMutableArray array];
    }
    return _usersArray;
}
- (ESIndicator *)indcator
{
    if (!_indcator) {
        _indcator = [ESIndicator indicatorToView:self.view];
    }
    
    return _indcator;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]postNotificationName:LoginViewwillDiddisAppear object:nil];
    [super viewWillDisappear:animated];
}


- (void)dealloc
{
    
    [self removeNotification];
    
}
#pragma mark ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isHiddenCell=YES;
    self.navigationItem.title=@"登录";
    [self addNotification];
    
    [self initalizedView];
    [[ESLoginDbManager sharedESLoginDbManager]getAllObjects:^(NSMutableArray *array) {
        self.usersArray=[array copy];
        
    }];
}

- (void)initalizedView
{
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton*rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame=CGRectMake(0, 0, 40, 25);
    [rightButton setTitleColor:AllTextColor forState:UIControlStateNormal];
    [rightButton setTitle:@"注册" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(goToResiget) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightBarButton=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightBarButton;

    [self.view addSubview:self.tableView];
    ESLoginHeaderView*header=[[ESLoginHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 170)];
    self.tableView.tableHeaderView=header;
    @weakify(self);
    header.mobileBlock=^(BOOL isHidden){
        self.isHiddenCell=!isHidden;
        NSIndexSet*set=[[NSIndexSet alloc]initWithIndex:0];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    };
    ESLoginFooterView*footer=[[ESLoginFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
    
    footer.loginBlock=^(){
        @strongify(self);
        [self loginAction];
    };
    footer.forgetBlock=^(){
        @strongify(self);
        [self forgetPassWord];
    };
    footer.delegate=self;
    self.tableView.tableFooterView=footer;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.right.bottom. equalTo(@0);
    }];
    
    
}
-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.scrollEnabled=YES;
        _tableView.backgroundColor=[UIColor whiteColor];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ESLoginCell class] forCellReuseIdentifier:@"ESLoginCell"];
        
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isHiddenCell) {
        return 0;
    }
    return self.usersArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isHiddenCell) {
        return 0;
    }return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ESLoginCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESLoginCell"];
    cell.model=[self.usersArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    ESLoginModel*model=[self.usersArray objectAtIndex:indexPath.row];
    NSDictionary*dic=@{@"cellmobile":model.mobile};
    [[NSNotificationCenter defaultCenter]postNotificationName:ESLoginClickCellAction object:nil userInfo:dic];
    NSDictionary*dict2=@{@"userimage":model.imageStr};
    [[NSNotificationCenter defaultCenter]postNotificationName:ESLoginUserImageView object:nil userInfo:dict2];
    self.isHiddenCell=YES;
    self.mobileStr=model.mobile;
    NSIndexSet*set=[[NSIndexSet alloc]initWithIndex:0];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
}
-(void)threeLoginAboutAction:(LoginType)type
{
    if (type == LoginType_WeChat) {//微信
        
        [self.indcator startAnimation];
            SendAuthReq *req    = [[SendAuthReq alloc] init];
            req.scope           = @"snsapi_userinfo";
            req.state           = @"123";
            [WXApi sendReq:req];
        
        
    } else {//QQ
        [self.indcator startAnimation];
                    _tencentOAuth       = [[TencentOAuth alloc] initWithAppId:kQQ_AppId andDelegate:self];
            NSArray *permission = @[kOPEN_PERMISSION_GET_INFO,
                                    kOPEN_PERMISSION_GET_USER_INFO,
                                    kOPEN_PERMISSION_GET_SIMPLE_USER_INFO];
            [_tencentOAuth authorize:permission];
            
            
        }
        
    
}



#pragma mark - TencentSessionDelegate
- (void)tencentDidLogin
{
    [self.indcator stopAnimation];
    if (_tencentOAuth.accessToken&&_tencentOAuth.accessToken.length!=0) {
        
        [self doUserLoginWithName:_tencentOAuth.openId pwd:nil type:LoginType_QQ];
    }
}
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    [self.indcator stopAnimation];
}
- (void)tencentDidNotNetWork
{
    [self.indcator stopAnimation];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    //当导航控制器的子控制器个数 大于1 手势才有效
    return self.navigationController.viewControllers.count > 1;
}


#pragma mark
#pragma mark  Other Action
-(void)exitKeyboard//退下键盘
{
    [self.view endEditing:YES];
}
-(void)registerAction//去注册页面
{
    ESRegisterController *vc = [[ESRegisterController alloc] init];
    //    vc.isNavHidden = YES;
    vc.hidesBottomBarWhenPushed = YES;
    @weakify(self);
    vc.registerBlock = ^(NSString *username,NSString *password){
        @strongify(self);
        
        self.mobileNumTextField.text = username;
        self.passWordTextField.text = password;
        
        [self doUserLoginWithName:username pwd:password type:LoginType_Normal];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)rightBtnAction
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}
-(void)backBtnAction
{
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
#pragma mark 判断正则
/**判断是不是手机号码**/
-(BOOL)isMobileNumberClassification:(NSString*)mobile{

    NSString * MOBIL = @"^\\d{11}$";//11位数字正则
    NSPredicate *regextestmobil = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    return [regextestmobil evaluateWithObject:mobile];

}
/**
 *  判断是不是纯数字
 *
 *  @param passWord <#passWord description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)isIntThePassWord:(NSString*)passWord{
    NSString *regex =@"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:passWord]) {
        return YES;
    }
    return NO;
}
#pragma mark -登陆
- (void)loginAction
{
    if ([self isMobileNumberClassification:self.mobileStr]) {
        
    }else{
        TipViewAnimation*tipsView=[[TipViewAnimation alloc]initWithFrame:self.view.bounds andTip:@"请输入正确手机号码"];
        [tipsView show];
        return;
    }
    
    if (self.passWordStr.length==0) {
        TipViewAnimation*tipsView=[[TipViewAnimation alloc]initWithFrame:self.view.bounds andTip:@"请输入密码"];
        [tipsView show];
        return;

    }
    [self.view endEditing:YES];
    [self doUserLoginWithName:self.mobileStr pwd:self.passWordStr type:LoginType_Normal];
    
}
//环信点击登陆后的操作
- (void)loginEaseWithUsername:(NSString *)username password:(NSString *)password
{
    //异步登陆账号
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:username
                                                        password:password
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         if (loginInfo && !error) {
             //设置是否自动登录
             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
             
             // 旧数据转换 (如果您的sdk是由2.1.2版本升级过来的，需要家这句话)
             [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
             //获取数据库中数据
             [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
             
             
             
             //获取群组列表
             //             [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
             
             //发送自动登陆状态通知
             
             //保存最近一次登录用户名
             [self saveLastLoginUsername];
             
             [ESToast showSuccess:@"登录成功"];
             /*登录成功之后还要获取一次用户的信息*/
             [self.view endEditing:YES];
             [self endNetworking];
             //self.navigationController.navigationBar.hidden = NO;
             //如果是注册页面过来的?EaseMobLoginSuccess
             [[NSNotificationCenter defaultCenter]postNotificationName:EaseMobLoginSuccess object:nil];
             self.navigationController.tabBarController.selectedIndex=0;
             [self.navigationController popToRootViewControllerAnimated:YES];
         }
         else
         {
        }
     } onQueue:nil];
}
- (void)saveLastLoginUsername
{
    NSString *username = [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:kSDKUsername];
    if (username && username.length > 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:username forKey:[NSString stringWithFormat:@"em_lastLogin_%@",kSDKUsername]];
        [ud synchronize];
    }
}



-(void)goToResiget{
    ESRegisterController*vc=[[ESRegisterController alloc]init];
    if (self.isComFromRegiste==YES) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        vc.isComfromLogin=YES;
        [self.navigationController pushViewController:vc animated:YES];

    }
}


#pragma mark - Notification

- (void)addNotification
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWechatLoginNotification:) name:kDidWechatLoginNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bindSucessNotification:) name:kDidBindSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(passWordTextFieldAction:) name:ESLoginEditPassWordTextfield object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mobileNumTextFieldAction:) name:ESLoginEditMobileTextfield object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KDidweichaloginfailer) name:KDidWechaatLoginFailer object:nil];
}

- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)KDidweichaloginfailer{
    [self.indcator stopAnimation];
}
/**
 *  处理微信成功登录返回
 */
- (void)handleWechatLoginNotification:(NSNotification *)notification
{
    [self.indcator stopAnimation];
    NSString *code = notification.object;
    [self getWeiXinOpenId:code];
    
}
-(void)getWeiXinOpenId:(NSString*)code{
    GetWeiXinOpenIdRequest*request=[GetWeiXinOpenIdRequest request];
    request.code=code;
    [ESService getWeiXinOpenIdRequest:request success:^(WeiXinOpenIdInfo *info) {
        
        [self doUserLoginWithName:info.open_id pwd:nil type:LoginType_WeChat];
    
    } failure:^(NSError *error) {
        
    }];
}
-(void)passWordTextFieldAction:(NSNotification*)noti{
  
    NSDictionary*dic=noti.userInfo;
    self.passWordStr=dic[@"passWord"];
    NSDictionary*dic1=@{@"mobile":self.mobileStr,@"passWord":self.passWordStr};
    [[NSNotificationCenter defaultCenter]postNotificationName:ESLoginButtonCanClick object:nil userInfo:dic1];
    
}
-(void)mobileNumTextFieldAction:(NSNotification*)noti{
    NSDictionary*dic=noti.userInfo;
    self.mobileStr=dic[@"mobile"];

    NSDictionary*dic1=@{@"mobile":self.mobileStr,@"passWord":self.passWordStr};
    [[NSNotificationCenter defaultCenter]postNotificationName:ESLoginButtonCanClick object:nil userInfo:dic1];
   
}
- (void)bindSucessNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    NSNumber *type = userInfo[@"type"];
    NSString *open_id = userInfo[@"open_id"];
    if (type.intValue == 1) {//微信绑定成功
        [self doUserLoginWithName:open_id pwd:nil type:LoginType_WeChat];
    }else if (type.intValue == 2){//QQ绑定成功
        [self doUserLoginWithName:open_id pwd:nil type:LoginType_QQ];
    }
}

#pragma mark
#pragma mark  Other delegate
-(NSString *)mobileStr{
    if (_mobileStr==nil) {
        _mobileStr=@"";
    }
    return _mobileStr;
}
-(NSString *)passWordStr{
    if (_passWordStr==nil) {
        _passWordStr=@"";
    }
    return _passWordStr;
}

#pragma mark - Networking
- (void)doUserLoginWithName:(NSString *)name pwd:(NSString *)pwd type:(LoginType)type
{
    @weakify(self);
    [self.indcator startAnimationWithMessage:@"正在登录..."];
    [kUserManager doUserManualLoginWithUsername:name password:pwd type:type success:^{
        @strongify(self);
        
        
        BaseRequest *requset = [[BaseRequest alloc] init];
        [ESService getEaseMobInfo:requset success:^(EombaseInfo *response) {
            
            [self loginEaseWithUsername:response.username password:response.password];
        } failure:^(NSError *error) {
            
        }];
        
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endNetworking];
    }];
}

#pragma mark 忘记密码

- (void)forgetPassWord
{
    ESForgetPasswordController *controller = [[ESForgetPasswordController alloc] init];
    controller.isComfromLogin=YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark Networking
- (void)endNetworking
{
    [self.indcator stopAnimation];
}

@end
