//
//  ESForgetPasswordController.m
//  EasyShop
//
//  Created by wcz on 16/6/7.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESForgetPasswordController.h"
#import "ESResetViewController.h"
#import "ESSmsButton.h"
#import "ESRefoundTexdField.h"
#import "ESInputTextField.h"

@interface ESForgetPasswordController ()<ESInputTextFieldDelete>

@property (nonatomic, strong) ESInputTextField *mobileNumTextField;
@property (nonatomic, strong) ESInputTextField *passWordTextField;
@property (nonatomic, strong) ESInputTextField *codeTextField;

/** Indicator */
@property (nonatomic,strong) ESIndicator *indicator;

/** smsButtom */
@property (nonatomic,strong) ESSmsButton *msButton;
@property (nonatomic,strong)UIButton*registerButton;
@end

@implementation ESForgetPasswordController

- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}

- (ESInputTextField *)mobileNumTextField
{
    if (_mobileNumTextField ==nil) {
      
        _mobileNumTextField =[[ESInputTextField alloc] initWithImage:nil needChange:nil andIsLogin:NO];
        _mobileNumTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
        _mobileNumTextField.TextDelete=self;
        _mobileNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        _mobileNumTextField.placeholder = @"手机号";
        _mobileNumTextField.isHiden=YES;
    }
    return _mobileNumTextField;
}

- (ESInputTextField *)codeTextField
{
    if (_codeTextField ==nil) {
        _codeTextField =[[ESInputTextField alloc] initWithImage:nil needChange:nil andIsLogin:NO];
        _codeTextField.TextDelete=self;
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTextField.placeholder = @"验证码";
        _codeTextField.isHiden=YES;
    }
    return _codeTextField;
}

- (ESInputTextField *)passWordTextField
{
    if (_passWordTextField ==nil) {
        _passWordTextField = [[ESInputTextField alloc] initWithImage:nil needChange:nil andIsLogin:NO];
        _passWordTextField.TextDelete=self;
        _passWordTextField.keyboardType = UIKeyboardTypeDefault;
        _passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passWordTextField.secureTextEntry = YES;
        _passWordTextField.placeholder = @"6-16位新密码";
        _passWordTextField.isHiden=YES;
    }
    return _passWordTextField;
}

-(void)exitKeyboard{
    [self.view  endEditing:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addNotification];
    
    self.navigationItem.title = @"重置密码";
    self.view.backgroundColor = [UIColor whiteColor];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self.view addSubview:self.mobileNumTextField];
    self.msButton = [ESSmsButton buttonWithType:UIButtonTypeCustom];
    self.msButton. layer.borderColor=RGBA(233, 40, 46, 0.7).CGColor;
    self.msButton.layer.borderWidth=1;
    self.msButton.layer.cornerRadius = 18;
    self.msButton.layer.masksToBounds = YES;
    [self.msButton setTitleColor:RGBA(233, 40, 46, 0.7) forState:UIControlStateNormal];
    [self.msButton setTitle:@"验证" forState:UIControlStateNormal];
    self.msButton.enabled=NO;
    self.msButton.titleLabel.font = ADeanFONT12;
    [self.view addSubview:self.msButton];
    
    [self.view addSubview:self.codeTextField];
     [self.view addSubview:self.passWordTextField];
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.backgroundColor = RGBA(233, 40, 46, 0.8);
    self.registerButton.layer.cornerRadius = 18;
    self.registerButton.layer.masksToBounds = YES;
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerButton setTitle:@"确定" forState:UIControlStateNormal];
    //    registerButton.backgroundColor = [UIColor whiteColor];
    self.registerButton.titleLabel.font = ADeanFONT15;
    [self.registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    self.registerButton.enabled=NO;

    [self.view addSubview:self.registerButton];
        [self.mobileNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@40);
            make.right.equalTo(@(-120));
            make.height.equalTo(@39);
            make.top.equalTo(@214);
        }];
        
        
        [self.msButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-40));
            make.width.equalTo(@70);
            make.height.equalTo(@39 );
            make.top.equalTo(@214);
        }];
        
        [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@40);
            make.right.equalTo(@(-40));
            make.height.equalTo(@39);
            make.top.equalTo(self.mobileNumTextField.mas_bottom).offset(20);
        }];
        //密码
        
        [self.passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@40);
            make.right.equalTo(@(-40));
            make.height.equalTo(@39);
            make.top.equalTo(self.codeTextField.mas_bottom).offset(20);
        }];
        
        
        [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@40);
            make.right.equalTo(@(-40));
            make.height.equalTo(@39);
            make.top.equalTo(self.passWordTextField.mas_bottom).offset(30);
            
        }];
}

- (void)dealloc
{
    [self removeNotification];
}

#pragma mark - NSNotification

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self.mobileNumTextField];
}
- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)inputTextFieldDidChange:(NSString *)InputTextFieldText{
    
    if (self.codeTextField.text.length==0||self.passWordTextField.text.length==0||self.mobileNumTextField.text.length==0) {
        self.registerButton.enabled=NO;
        self.registerButton.backgroundColor=RGBA(233, 40, 46, 0.8);
    }else if(self.codeTextField.text.length==4&&[self isMobileNumberClassification:self.mobileNumTextField.text]){
        self.registerButton.enabled=YES;
        self.registerButton.backgroundColor=RGBA(233, 40, 46, 1);
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
- (void)textDidChange:(NSNotification *)notification
{
    UITextField *textField = notification.object;
    if (textField == self.mobileNumTextField) {
        self.msButton.phone = textField.text;
    }
}

- (void)registerAction
{
//    ESResetViewController *controller = [[ESResetViewController alloc] init];
////    controller.isNavHidden = YES;
//    [self.navigationController pushViewController:controller animated:YES];
    
    [self resetPassword];
    
}

- (void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

/**判断是不是手机号码**/
-(BOOL)isMobileNumberClassification:(NSString*)mobile{
    NSString * MOBIL = @"^\\d{11}$";//11位数字正则
    NSPredicate *regextestmobil = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    return [regextestmobil evaluateWithObject:mobile];
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
     * 联通：130,131,132,152,155,156,185,186,1709
     * 电信：133,1349,153,180,189,1700
     */
    //    NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])//d{7}$";//总况
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
     12         */
    //NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])//d|705)//d{7}$";
//    NSString*CM = @"^1(3[4-9]|5[01789]|8[278])\\d{8,8}";
//    /**
//     
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186,1709
//     17         */
//    NSString * CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{8}";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189,1700
//     22         */
//    NSString * CT = @"^1((33|53|8[09])\\d|349|700)\\d{8}";
//    
//    
//    /**
//     25         * 大陆地区固话及小灵通
//     26         * 区号：010,020,021,022,023,024,025,027,028,029
//     27         * 号码：七位或八位
//     28         */
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}";
//    
//    
//    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    // NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",PHS];
//    
//    if (([regextestcm evaluateWithObject:mobile] == YES)
//        || ([regextestct evaluateWithObject:mobile] == YES)
//        || ([regextestcu evaluateWithObject:mobile] == YES)
//        )
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
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

#pragma mark - Networking

- (void)resetPassword
{
    if ([self isMobileNumberClassification:self.mobileNumTextField.text]) {
        
    }else{
        TipViewAnimation*tipsView=[[TipViewAnimation alloc]initWithFrame:self.view.bounds andTip:@"请输入正确手机号码"];
        [tipsView show];
        return;
    }
    if (self.codeTextField.text.length==0) {
        TipViewAnimation*tipsView=[[TipViewAnimation alloc]initWithFrame:self.view.bounds andTip:@"请确认注册码"];
        [tipsView show];
        return;
        
    }else{
        
    }

    if (self.passWordTextField.text.length==0) {
        TipViewAnimation*tipsView=[[TipViewAnimation alloc]initWithFrame:self.view.bounds andTip:@"请输入密码"];
        [tipsView show];
        return;
        
    }
    if (self.passWordTextField.text.length<6) {
        TipViewAnimation*tipsView=[[TipViewAnimation alloc]initWithFrame:self.view.bounds andTip:@"密码不可以小于6位"];
        [tipsView show];
        return;
    }
    UserResetRequest *request = [UserResetRequest request];
    request.mobile      = self.mobileNumTextField.text;
    request.password    = self.passWordTextField.text;
    request.verify      = self.codeTextField.text;
    
    @weakify(self);
    [self.indicator startAnimationWithMessage:@"正在重置密码"];
    [ESService userResetRequest:request success:^{
        @strongify(self);
        [self endGSNetworking];
        
        [ESToast showSuccess:@"重置密码成功!"];
        
        //登录状态，则重置本地存储的密码
        [kUserManager resetLoginPassword:request.password];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
    
    
}

#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.indicator stopAnimation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
