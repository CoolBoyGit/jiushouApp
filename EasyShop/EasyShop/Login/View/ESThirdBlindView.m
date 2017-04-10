//  ESThirdBlindView.m
//  EasyShop
//
//  Created by wcz on 16/6/3.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESThirdBlindView.h"
#import "ESInputTextField.h"
#import "ESSmsButton.h"
#import "TipViewAnimation.h"
@interface ESThirdBlindView ()<UITextFieldDelegate,ESInputTextFieldDelete>

@property (nonatomic, strong) ESInputTextField *mobileNumTextField;
@property (nonatomic, strong) ESInputTextField *passWordTextField;
@property (nonatomic, strong) ESInputTextField *codeTextField;
@property (nonatomic, strong) ESInputTextField *passWordNextTextField;
/** smsButtom */
@property (nonatomic,strong) ESSmsButton *smsButton;

/** indicator */
@property (nonatomic,strong) ESIndicator *indcator;
@property (nonatomic,strong) UIButton *registerButton;
@end

@implementation ESThirdBlindView



- (ESInputTextField *)mobileNumTextField
{
    if (_mobileNumTextField ==nil) {
        _mobileNumTextField = [[ESInputTextField alloc] initWithImage:nil needChange:NO andIsLogin:NO];
        _mobileNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        _mobileNumTextField.TextDelete=self;
        _mobileNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _mobileNumTextField.placeholder = @"手机号";
        _mobileNumTextField.isHiden=YES;
        [_mobileNumTextField becomeFirstResponder];
    }
    return _mobileNumTextField;
}

- (ESInputTextField *)passWordTextField
{
    if (_passWordTextField ==nil) {
        _passWordTextField = [[ESInputTextField alloc] initWithImage:nil];
        _passWordTextField.keyboardType = UIKeyboardTypeDefault;
        _passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passWordTextField.TextDelete=self;
        _passWordTextField.secureTextEntry = YES;
        _passWordTextField.placeholder = @"6-16位登录密码";
        _passWordTextField.isHiden=YES;
    }
    return _passWordTextField;
}

- (ESInputTextField *)passWordNextTextField
{
    if (_passWordNextTextField ==nil) {
        _passWordNextTextField = [[ESInputTextField alloc] initWithImage:nil];
        _passWordNextTextField.keyboardType = UIKeyboardTypeDefault;
        _passWordNextTextField.secureTextEntry=YES;
        _passWordNextTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passWordNextTextField.TextDelete=self;
        _passWordNextTextField.placeholder = @"请再次输入密码";
        _passWordNextTextField.returnKeyType=UIReturnKeyGo;
        _passWordNextTextField.isHiden=YES;
    }
    return _passWordNextTextField;
}


- (ESInputTextField *)codeTextField
{
    if (_codeTextField ==nil) {
        _codeTextField = [[ESInputTextField alloc] initWithImage:nil];
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTextField.TextDelete=self ;
        _codeTextField.placeholder = @"注册码";
        _codeTextField.isHiden=YES;
    }
    return _codeTextField;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addNotification];
        
        [self addSubview:self.mobileNumTextField];
        [self.mobileNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@40);
            make.right.equalTo(@(-120));
            make.height.equalTo(@39);
            make.top.equalTo(@0);
        }];
        self.smsButton = [ESSmsButton buttonWithType:UIButtonTypeCustom];
        //getVerifyCodeButton.backgroundColor = RGBA(255, 255, 255, .6);
        self.smsButton.layer.borderColor=RGBA(233, 40, 46, 0.7).CGColor;
        self.smsButton.layer.borderWidth=1;
        self.smsButton.layer.cornerRadius = 18;
        self.smsButton.layer.masksToBounds = YES;
        [self.smsButton setTitleColor:RGBA(233, 40, 46, 0.7) forState:UIControlStateNormal];
        
        [self.smsButton setTitle:@"验证" forState:UIControlStateNormal];
        self.smsButton.enabled=NO;
        self.smsButton.titleLabel.font = ADeanFONT13;
        [self addSubview:self.smsButton];
        [self.smsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-40);
            make.width.equalTo(@(70));
            make.height.equalTo(@39);
            make.centerY.equalTo(self.mobileNumTextField.mas_centerY).offset(0);
        }];
        
        [self addSubview:self.codeTextField];
        [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@40);
            make.right.equalTo(@(-40));
            make.height.equalTo(@39);
            make.top.equalTo(self.mobileNumTextField.mas_bottom).offset(15);
        }];
        
        [self addSubview:self.passWordTextField];
        [self.passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@40);
            make.width.equalTo(@(ScreenWidth - 80));
            make.height.equalTo(@39);
            make.top.equalTo(self.codeTextField.mas_bottom).offset(15);
        }];
        
        [self addSubview:self.passWordNextTextField];
        [self.passWordNextTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@40);
            make.width.equalTo(@(ScreenWidth - 80));
            make.height.equalTo(@39);
            make.top.equalTo(self.passWordTextField.mas_bottom).offset(15);
        }];
        
        self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.registerButton.backgroundColor = RGBA(233, 40, 46, 0.8);
        self.registerButton.layer.cornerRadius = 18;
        self.registerButton.layer.masksToBounds = YES;
        [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.registerButton setTitle:@"立即注册并绑定" forState:UIControlStateNormal];
        //    registerButton.backgroundColor = [UIColor whiteColor];
        self.registerButton.titleLabel.font = ADeanFONT15;
        [self.registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.registerButton];
        [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(40));
            make.right.equalTo(@(-40));
            make.top.equalTo(self.passWordNextTextField.mas_bottom).offset(20);
            make.height.equalTo(@39);
        }];

    }
    return self;
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
        
        self.smsButton.layer.borderColor=RGBA(233, 40, 46, 1).CGColor;
        [self.smsButton setTitleColor:RGBA(233, 40, 46, 1) forState:UIControlStateNormal];
        self.smsButton.enabled=YES;
    }else{
        self.smsButton.layer.borderColor=RGBA(233, 40, 46, 0.7).CGColor;
        [self.smsButton setTitleColor:RGBA(233, 40, 46, 0.7) forState:UIControlStateNormal];
        self.smsButton.enabled=NO;
    }
    
    
}
#pragma mark 正则表达式
/**判断是不是手机号码**/
-(BOOL)isMobileNumberClassification:(NSString*)mobile{
    
    NSString * MOBIL = @"^\\d{11}$";//11位数字正则
    NSPredicate *regextestmobil = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    return [regextestmobil evaluateWithObject:mobile];
    
}

- (void)dealloc
{
    [self endEditing:YES];
    [self removeNotification];
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self.mobileNumTextField];
}
- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textDidChange:(NSNotification *)notification
{
    UITextField *textField = notification.object;
    if (textField == self.mobileNumTextField) {
        self.smsButton.phone = textField.text;
    }
}
/**
 *  判断是不是纯数字
 */
-(BOOL)isIntThePassWord:(NSString*)passWord{
    NSString *regex =@"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:passWord]) {
        return YES;
    }
    return NO;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self registerAction];
    return YES;
}
- (void)registerAction
{
    NSString *moblie = self.mobileNumTextField.text;
    NSString *smsCode = self.codeTextField.text;
    NSString *pwd = self.passWordTextField.text;
    if ([self isIntThePassWord:self.passWordTextField.text]) {
        
    }else{
        TipViewAnimation*tipsView=[[TipViewAnimation alloc]initWithFrame:kKeyWindow.bounds andTip:@"密码不可以是纯数字"];
        [tipsView show];

        //这里写提示动画
        return;
    }if (6<self.passWordTextField.text.length&&self.passWordTextField.text.length<17) {
        
    }else{
        return;
        //这里写提示动画
    }if ([self.passWordTextField.text isEqualToString:self.passWordNextTextField.text]) {
        
    }else{
        //这里写提示
        TipViewAnimation*tipsView=[[TipViewAnimation alloc]initWithFrame:kKeyWindow.bounds andTip:@"密码不一致"];
        [tipsView show];
        return;
    }

    if (self.bindBlock) {
        self.bindBlock(moblie,smsCode,pwd);
    }
}

@end