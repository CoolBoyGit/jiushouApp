//
//  ESLoginFooterView.m
//  EasyShop
//
//  Created by 就手国际 on 17/1/14.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import "ESLoginFooterView.h"
#import "ESInputTextField.h"
@interface ESLoginFooterView()<ESInputTextFieldDelete>
@property (nonatomic, strong) ESInputTextField *passWordTextField;//密码输入框
@property (nonatomic, strong) UILabel *titleNameLabel;//第三方登录文字
@property (nonatomic, strong) UIButton *weChatButton;//微信按钮
@property (nonatomic, strong) UIButton *aliButton;//支付宝按钮
@property (nonatomic,strong) UIButton *loginButton;//登录按钮
@property (nonatomic,strong) UIButton *forgetPasswordButton;//忘记密码
@end
@implementation ESLoginFooterView
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
        [self intaliButtonzedView];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginButtonCanClick:) name:ESLoginButtonCanClick object:nil];
    }
    return self;
}
-(void)loginButtonCanClick:(NSNotification*)nofi{
    NSDictionary*dic=nofi.userInfo;
    NSString*mobile=dic[@"mobile"];
    NSString*passWord=dic[@"passWord"];
    if (mobile.length>0&&passWord.length>0) {
        self.loginButton.enabled=YES;
        self.loginButton.backgroundColor=RGB(233, 40, 46);
    }else{
        self.loginButton.enabled=NO;
        self.loginButton.backgroundColor=RGBA(233, 40, 46, 0.6);
    }
}
- (ESInputTextField *)passWordTextField
{
    if (_passWordTextField ==nil) {
        _passWordTextField = [[ESInputTextField alloc] initWithImage:nil needChange:YES andIsLogin:YES];
        _passWordTextField.TextDelete=self;
        _passWordTextField.image=[UIImage imageNamed:@"loginpassword"];
        _passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passWordTextField.font=[UIFont systemFontOfSize:15];
        _passWordTextField.keyboardType = UIKeyboardTypeDefault;
        _passWordTextField.secureTextEntry = YES;
        _passWordTextField.backgroundColor=RGB(240, 240, 240);
        _passWordTextField.returnKeyType=UIReturnKeyGo;
        _passWordTextField.placeholder = @"密码";
        _passWordTextField.isHiddenButton=YES;
        @weakify(self);
        _passWordTextField.passWordBlock=^(BOOL isHidden){
            @strongify(self);
            self.passWordTextField.secureTextEntry = !isHidden;
        };
    }
    return _passWordTextField;
}
-(UIButton *)loginButton{
    if (_loginButton==nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.layer.cornerRadius = 18;
        _loginButton.layer.masksToBounds = YES;
        [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        _loginButton.enabled=NO;
        _loginButton.backgroundColor = RGBA(233, 40, 46, 0.6);
        [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.titleLabel.font = ADeanFONT15;
        
    }
    return _loginButton;
}
-(void)loginAction{
    if (self.loginBlock) {
        self.loginBlock();
    }
}
-(void)intaliButtonzedView
{
    [self addSubview:self.passWordTextField];
    [self.passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@20);
        make.right.equalTo(@(-20));
        make.height.equalTo(@35);
        
    }];
    [self addSubview:self.forgetPasswordButton];
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passWordTextField.mas_bottom).offset(5);
        make.right.equalTo(self.passWordTextField);
        make.width.equalTo(@100);
        make.height.equalTo(@15);
        
        
    }];
    [self addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forgetPasswordButton.mas_bottom).offset(10);
        make.right.equalTo(@(-20));
        make.left.equalTo(@20);
        make.height.equalTo(@35);
    }];
    [self addSubview:self.titleNameLabel];
    [self.titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(self.loginButton.mas_bottom).offset(20);
        make.right.equalTo(@0);
        make.height.equalTo(@15);
    }];
    
    [self addSubview:self.weChatButton];
    [self.weChatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(-45);
        make.width.equalTo(@50);
        make.top.equalTo(self.titleNameLabel.mas_bottom).with.offset(20);
        make.height.equalTo(@50);
    }];
    
    UILabel *wechatLabel = [[UILabel alloc] init];
    wechatLabel.textColor = LoginComColor;
    wechatLabel.text = @"微信";
    wechatLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:wechatLabel];
    [wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weChatButton.mas_bottom).offset(5);
        make.centerX.equalTo(self.weChatButton);
    }];
    
    [self addSubview:self.aliButton];
    [self.aliButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(45);
        make.width.equalTo(@50);
        make.top.equalTo(self.titleNameLabel.mas_bottom).with.offset(20);
        make.height.equalTo(@50);
    }];
    
    UILabel *alipayLabel = [[UILabel alloc] init];
    alipayLabel.text = @"QQ";
    alipayLabel.textColor = LoginComColor;
    alipayLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:alipayLabel];
    [alipayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.aliButton.mas_bottom).offset(5);
        make.centerX.equalTo(self.aliButton);
    }];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        
        
    }else {
        self.weChatButton.hidden=YES;
        wechatLabel.hidden=YES;
        
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        
    }
    
    else{
        self.aliButton.hidden=YES;
        alipayLabel.hidden=YES;
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]||[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        
    }else{
        self.titleNameLabel.hidden=YES;
    }
    
    
}
-(UIButton *)forgetPasswordButton{
    if (_forgetPasswordButton==nil) {
        _forgetPasswordButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPasswordButton setTitleColor:LoginComColor forState:UIControlStateNormal];
        _forgetPasswordButton.titleLabel.font = ADeanFONT15;
        [_forgetPasswordButton addTarget:self action:@selector(forgetPassWord) forControlEvents:UIControlEventTouchUpInside];
        [_forgetPasswordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        
    }
    
    return _forgetPasswordButton;
}
-(void)forgetPassWord{
    if (self.forgetBlock) {
        self.forgetBlock();
    }
}
- (UILabel *)titleNameLabel {
    if (!_titleNameLabel) {
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.font = ADeanFONT14;
        _titleNameLabel.textAlignment = NSTextAlignmentCenter;
        _titleNameLabel.textColor =LoginComColor;
        _titleNameLabel.text = @"合作平台登陆";
    }
    return _titleNameLabel;
}
-(UIButton *)weChatButton
{
    if (!_weChatButton) {
        _weChatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weChatButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _weChatButton.tag = 5;
        _weChatButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_weChatButton setImage:[UIImage imageNamed:@"loginwechat"] forState:UIControlStateNormal];
        [_weChatButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weChatButton;
}
-(UIButton *)aliButton
{
    if (!_aliButton) {
        _aliButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_aliButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _aliButton.tag = 6;
        _aliButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_aliButton setImage:[UIImage imageNamed:@"loginalipay"] forState:UIControlStateNormal];
        [_aliButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aliButton;
}
-(void)inputTextFieldDidChange:(NSString *)InputTextFieldText{
    NSDictionary*dic=@{@"passWord":InputTextFieldText};
    [[NSNotificationCenter defaultCenter]postNotificationName:ESLoginEditPassWordTextfield object:nil userInfo:dic];
}
-(void)btnAction:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(threeLoginAboutAction:)]) {
        [_delegate threeLoginAboutAction:(LoginType)btn.tag];
    }
}

@end
