//
//  ESRegisterController.m
//  EasyShop
//
//  Created by wcz on 16/4/4.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESRegisterController.h"
#import "ESInputTextField.h"
#import "ESThreeLoginView.h"
#import "ESBlindViewController.h"
#import "ESService.h"
#import "WXApi.h"
#import "ESSmsButton.h"
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WarningControlView.h"
#import "ESLoginViewController.h"
#import "EaseMob.h"
@interface ESRegisterController ()<UITextFieldDelegate,ESThreeLoginDelegate,TencentSessionDelegate,ESInputTextFieldDelete>{
    
    TencentOAuth *_tencentOAuth;//腾讯授权
}

@property (nonatomic, strong) ESInputTextField *mobileNumTextField;
@property (nonatomic, strong) ESInputTextField *passWordTextField;
@property (nonatomic, strong) ESInputTextField *codeTextField;
@property (nonatomic, strong) ESInputTextField *passWordNextTextField;

/** indicator */
@property (nonatomic,strong) ESIndicator *indcator;
@property (nonatomic,strong) ESSmsButton *msButton;
@property (nonatomic,strong) UIButton *registerButton;
@end

@implementation ESRegisterController

- (ESIndicator *)indcator
{
    if (!_indcator) {
        _indcator = [ESIndicator indicatorToView:self.view];
    }
    return _indcator;
}

- (ESInputTextField *)mobileNumTextField
{
    if (_mobileNumTextField ==nil) {
        _mobileNumTextField = [[ESInputTextField alloc] initWithImage:nil needChange:NO andIsLogin:NO];
        _mobileNumTextField.delegate=self;
        _mobileNumTextField.TextDelete=self;
        _mobileNumTextField.keyboardType = UIKeyboardTypeDefault;
        _mobileNumTextField.returnKeyType=UIReturnKeyNext;
        _mobileNumTextField.inputAccessoryView=nil;
        _mobileNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _mobileNumTextField.placeholder = @"手机号";
        _mobileNumTextField.isHiden=YES;
    }
    return _mobileNumTextField;
}

- (ESInputTextField *)passWordTextField
{
    if (_passWordTextField ==nil) {
        _passWordTextField = [[ESInputTextField alloc] initWithImage:nil needChange:NO andIsLogin:NO];
        _passWordTextField.keyboardType = UIKeyboardTypeDefault;
        _passWordTextField.returnKeyType=UIReturnKeyNext;
        _passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passWordTextField.secureTextEntry = YES;
        
        _passWordTextField.delegate=self;
        _passWordTextField.TextDelete=self;
        _passWordTextField.placeholder = @"6-16位登录密码";
        _passWordTextField.isHiden=YES;
    }
    return _passWordTextField;
}

- (ESInputTextField *)passWordNextTextField
{
    if (_passWordNextTextField ==nil) {
        _passWordNextTextField = [[ESInputTextField alloc] initWithImage:nil needChange:NO andIsLogin:NO];
        _passWordNextTextField.keyboardType = UIKeyboardTypeDefault;
        _passWordNextTextField.TextDelete=self;
        _passWordNextTextField.delegate=self;
        _passWordNextTextField.returnKeyType=UIReturnKeyGo;
        _passWordNextTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passWordNextTextField.secureTextEntry=YES;
        _passWordNextTextField.placeholder = @"请再次输入密码";
        _passWordNextTextField.isHiden=YES;
    }
    return _passWordNextTextField;
}


- (ESInputTextField *)codeTextField
{
    if (_codeTextField ==nil) {
        _codeTextField = [[ESInputTextField alloc] initWithImage:nil needChange:NO andIsLogin:NO];
        _codeTextField.keyboardType = UIKeyboardTypeDefault;
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTextField.TextDelete=self;
        _codeTextField.delegate=self;
        _codeTextField.inputAccessoryView=nil;
        _codeTextField.returnKeyType=UIReturnKeyNext;
        _codeTextField.placeholder = @"注册码";
        _codeTextField.isHiden=YES;
    }
    return _codeTextField;
}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    if (textField==self.mobileNumTextField) {
//        // [self.mobileNumTextField resignFirstResponder];
//        [self.codeTextField becomeFirstResponder];
//        return YES;
//        
//    }else if(textField==self.codeTextField){
//        // [self.mobileNumTextField resignFirstResponder];
//        // [self.codeTextField resignFirstResponder];
//        [self.passWordTextField becomeFirstResponder];
//        return YES;
//        
//    }else if (textField==self.passWordTextField){
//        // [self.mobileNumTextField resignFirstResponder];
//        // [self.codeTextField resignFirstResponder];
//        // [self.passWordTextField resignFirstResponder];
//        [self.passWordNextTextField becomeFirstResponder];
//        return YES;
//        
//    }else{
//        // [self.mobileNumTextField resignFirstResponder];
//        //[self.codeTextField resignFirstResponder];
//        // [self.passWordTextField resignFirstResponder];
//        [self.passWordNextTextField resignFirstResponder];
//        [self registerAction];
//        return YES;
//    }
//    return YES;
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton*rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame=CGRectMake(0, 0, 40, 25);
    [rightButton setTitleColor:AllTextColor forState:UIControlStateNormal];
    [rightButton setTitle:@"登录" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(goToLogin) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem*rightBarButton=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightBarButton;
    
    
    self.navigationItem.title=@"注册";
    //self.navigationController.navigationBar.hidden=YES;
    [self initalizedView];
    [self addNotification];
}
- (void)initalizedView
{
    UIScrollView *sv = [[UIScrollView alloc] init];
    sv.backgroundColor=[UIColor whiteColor];
    sv.userInteractionEnabled = YES;
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@64);
    }];
    UIView *backgroundView = [[UIView alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitKeyboard)];
    [backgroundView addGestureRecognizer:tap];
    backgroundView.backgroundColor=[UIColor whiteColor];
    
    [sv addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv);
        make.width.equalTo(sv);
    }];
        UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = ADeanFONT15;
    nameLabel.text = @"注册就手帐号";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = LoginComColor;
    [backgroundView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(0));
        make.top.equalTo(@40);
    }];
    
    [backgroundView addSubview:self.mobileNumTextField];
    [self.mobileNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@(-120));
        make.height.equalTo(@35);
        make.top.equalTo(nameLabel.mas_bottom).offset(30);
    }];
    self.msButton = [ESSmsButton buttonWithType:UIButtonTypeCustom];
    //getVerifyCodeButton.backgroundColor = RGBA(255, 255, 255, .6);
    [self.msButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.msButton. layer.borderColor=RGBA(233, 40, 46, 0.7).CGColor;
    self.msButton.layer.borderWidth=1;
    self.msButton.layer.cornerRadius = 17.5;
    self.msButton.layer.masksToBounds = YES;
    [self.msButton setTitleColor:RGBA(233, 40, 46, 0.7) forState:UIControlStateNormal];
    [self.msButton setTitle:@"验证" forState:UIControlStateNormal];
    self.msButton.enabled=NO;
    //    [getVerifyCodeButton addTarget:self action:@selector(getVerifyCodeAction) forControlEvents:UIControlEventTouchUpInside];
    self.msButton.titleLabel.font = ADeanFONT12;
    
    
    [backgroundView addSubview:self.msButton];
    [self.msButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-20));
        make.left.equalTo(self.mobileNumTextField.mas_right).offset(10);
        make.height.equalTo(@35);
        make.centerY.equalTo(self.mobileNumTextField.mas_centerY).offset(0);
    }];
    
    [backgroundView addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.height.equalTo(@35);
        make.top.equalTo(self.mobileNumTextField.mas_bottom).offset(15);
    }];
    
    [backgroundView addSubview:self.passWordTextField];
    [self.passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeTextField.mas_left);
        make.right.equalTo(self.codeTextField.mas_right);

        make.height.equalTo(@35);
        make.top.equalTo(self.codeTextField.mas_bottom).offset(15);
    }];
    
    [backgroundView addSubview:self.passWordNextTextField];
    [self.passWordNextTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeTextField.mas_left);
        make.right.equalTo(self.codeTextField.mas_right);
        make.height.equalTo(@35);
        make.top.equalTo(self.passWordTextField.mas_bottom).offset(15);
    }];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.backgroundColor = RGBA(233, 40, 46, 0.6);
    self.registerButton.layer.cornerRadius = 17.5;
    self.registerButton.layer.masksToBounds = YES;
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    
    self.registerButton.titleLabel.font = ADeanFONT15;
    [self.registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    self.registerButton.enabled=NO;
    [backgroundView addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeTextField.mas_left);
        make.right.equalTo(self.codeTextField.mas_right);
        make.top.equalTo(self.passWordNextTextField.mas_bottom).offset(20);
        make.height.equalTo(@35);
    }];
    
    
    ESThreeLoginView *loginView = [[ESThreeLoginView alloc] initWithFrame:CGRectZero];
    loginView.delegate = self;
    [backgroundView addSubview:loginView];
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerButton.mas_bottom).offset(0);
        make.left.equalTo(@0);
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(100));
    }];
    
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(loginView.mas_bottom);
    }];
    
}
-(void)dealloc{
    [self removeNotification];
}
-(void)threeLoginAboutAction:(LoginType)type
{
    if (type == LoginType_WeChat) {//微信
        
        
        SendAuthReq *req    = [[SendAuthReq alloc] init];
        req.scope           = @"snsapi_userinfo";
        req.state           = @"123";
        [WXApi sendReq:req];
        
        
        
    } else {
        _tencentOAuth       = [[TencentOAuth alloc] initWithAppId:kQQ_AppId andDelegate:self];
        NSArray *permission = @[kOPEN_PERMISSION_GET_INFO,
                                kOPEN_PERMISSION_GET_USER_INFO,
                                kOPEN_PERMISSION_GET_SIMPLE_USER_INFO];
        [_tencentOAuth authorize:permission];
        
        
        
    }
    
    
}



#pragma mark
#pragma mark  Other Action
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
#pragma mark 代理协议自定义方法
-(void)inputTextFieldDidChange:(NSString *)InputTextFieldText{
    if (self.mobileNumTextField.text.length==0||self.passWordTextField.text.length==0||self.codeTextField.text.length==0||self.passWordNextTextField.text.length==0) {
        self.registerButton.backgroundColor = RGBA(233, 40, 46, 0.8);
        self.registerButton.enabled=NO;
    }else if([self isMobileNumberClassification:self.mobileNumTextField.text]&&self.codeTextField.text.length==4){
        self.registerButton.backgroundColor = RGBA(233, 40, 46, 1);
        self.registerButton.enabled=YES;
    }
    if ([self isMobileNumberClassification:InputTextFieldText]) {
        
        self.msButton.layer.borderColor=RGBA(233, 40, 46, 1).CGColor;
        [self.msButton setTitleColor:RGBA(233, 40, 46, 1) forState:UIControlStateNormal];
        self.msButton.enabled=YES;
    }else{
        self.msButton.layer.borderColor=RGBA(233, 40, 46, 0.7).CGColor;
        [self.msButton setTitleColor:RGBA(233, 40, 46, 0.7) forState:UIControlStateNormal];
        self.msButton.enabled=NO;
    }
    
    
}
-(void)goToLogin{
    //
    if (self.isComfromLogin==YES) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        ESLoginViewController*login=[[ESLoginViewController alloc]init];
        login.isComFromRegiste=YES;
        [self.navigationController pushViewController:login animated:YES];
    }
    
}

-(void)exitKeyboard{
    [self.view endEditing:YES];
}
#pragma mark 正则表达式
/**判断是不是手机号码**/
-(BOOL)isMobileNumberClassification:(NSString*)mobile{
    
    NSString * MOBIL = @"^\\d{11}$";//11位数字正则
    NSPredicate *regextestmobil = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    return [regextestmobil evaluateWithObject:mobile];
    
}
/**
 *  判断是不是纯数字 yes 是纯数字 no不是
 */
-(BOOL)isIntThePassWord:(NSString*)passWord{
    NSString *regex =@"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:passWord]) {
        return YES;
    }
    return NO;
}
- (void)backButtonAction
{
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  获取验证码
 */
-(void)getVerifyCodeAction
{
    [self getVerifyCode];
}

/**
 *  注册
 */
- (void)registerAction
{
    [self doUserAdd];
}

#pragma mark - Networking
- (void)getVerifyCode
{
    GetSmsVerifyRequest *request = [GetSmsVerifyRequest request];
    request.mobile = self.mobileNumTextField.text;
    
    @weakify(self);
    //[self.indcator startAnimationWithMessage:@"正在获取验证码"];
    [ESService getSmsVerifyRequest:request success:^{
        @strongify(self);
        [self endNetworking];
        [ESToast showSuccess:@"验证码获取成功！"];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endNetworking];
    }];
}
- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self.mobileNumTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bindSucessNotification:) name:kDidBindSuccessNotification object:nil];
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

- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textDidChange:(NSNotification *)notification
{
    UITextField *textField = notification.object;
    if (textField == self.mobileNumTextField) {
        self.msButton.phone = textField.text;
    }
}
- (void)doUserAdd
{
    
        if ([self isIntThePassWord:self.passWordTextField.text]) {
    
        }else{
            //这里写提示动画
            TipViewAnimation*tipView=[[TipViewAnimation alloc]initWithFrame:self.view.bounds andTip:@"密码不能是纯数字"];
            [tipView show];
            return;
        }
    if (self.passWordTextField.text.length==0) {
        TipViewAnimation*tipView=[[TipViewAnimation alloc]initWithFrame:self.view.bounds andTip:@"密码不能为空"];
        [tipView show];
        return;
        
    }else{
        
    }
    if (6<self.passWordTextField.text.length&&self.passWordTextField.text.length<17) {
        
    }else{
        return;
        //这里写提示动画
    }if ([self.passWordTextField.text isEqualToString:self.passWordNextTextField.text]) {
        
    }else{
        //这里写提示
        TipViewAnimation*tipView=[[TipViewAnimation alloc]initWithFrame:self.view.bounds andTip:@"两次密码不一致"];
        [tipView show];
        
        return;
    }
    UserAddRequest *request = [UserAddRequest request];
    request.username    = self.mobileNumTextField.text;
    request.password    = self.passWordTextField.text;
    request.verify      = self.codeTextField.text;
    
    @weakify(self);
    [self.indcator startAnimationWithMessage:@"正在注册..."];
    [ESService userAddRequest:request success:^(NSString *response) {
        @strongify(self);
        [self endNetworking];
        
        [ESToast showSuccess:@"注册成功！"];
        
        if (self.registerBlock) {
            self.registerBlock(request.username,request.password);
        }
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endNetworking];
    }];
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

-(void)tencentDidLogin{
    if (_tencentOAuth.accessToken&&_tencentOAuth.accessToken.length!=0) {
        
        [self doUserLoginWithName:_tencentOAuth.openId pwd:nil type:LoginType_QQ];
    }

    
}
-(void)tencentDidNotNetWork{
    
}
-(void)tencentDidNotLogin:(BOOL)cancelled{
    
}
#pragma mark endNetworking
- (void)endNetworking
{
    [self.indcator stopAnimation];
}


@end
