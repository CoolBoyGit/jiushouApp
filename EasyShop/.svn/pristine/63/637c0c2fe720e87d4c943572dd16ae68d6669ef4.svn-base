

//
//  ESResetViewController.m
//  EasyShop
//
//  Created by wcz on 16/6/7.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESResetViewController.h"
#import "ESInputTextField.h"

@interface ESResetViewController ()

@property (nonatomic, strong) ESInputTextField *mobileNumTextField;
@property (nonatomic, strong) ESInputTextField *passWordTextField;

@end

@implementation ESResetViewController

- (ESInputTextField *)mobileNumTextField
{
    if (_mobileNumTextField ==nil) {
        _mobileNumTextField = [[ESInputTextField alloc] initWithImage:[UIImage imageNamed:@""]];
        _mobileNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        _mobileNumTextField.placeholder = @"新密码";
    }
    return _mobileNumTextField;
}

- (ESInputTextField *)passWordTextField
{
    if (_passWordTextField ==nil) {
        _passWordTextField = [[ESInputTextField alloc] initWithImage:[UIImage imageNamed:@""]];
        _passWordTextField.keyboardType = UIKeyboardTypeDefault;
        //        _passWordTextField.secureTextEntry = YES;
        _passWordTextField.placeholder = @"确认密码";
    }
    return _passWordTextField;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    backButton.backgroundColor = [UIColor blueColor];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.top.equalTo(self.view.mas_top).with.offset(25);
        make.width.mas_equalTo(@15);
        make.height.mas_equalTo(@15);
    }];
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = ADeanFONT15;
    nameLabel.text = @"忘记密码";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(0));
        make.top.equalTo(@(ScreenHeight/6));
    }];
    
    [self.view addSubview:self.mobileNumTextField];
    
    // 手机号
    [self.mobileNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.width.equalTo(@(ScreenWidth - 80));
        make.height.equalTo(@44);
        make.top.equalTo(nameLabel.mas_bottom).offset(40);
    }];
    
    //密码
    [self.view addSubview:self.passWordTextField];
    [self.passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.width.equalTo(@(ScreenWidth - 80));
        make.height.equalTo(@44);
        make.top.equalTo(self.mobileNumTextField.mas_bottom).offset(20);
    }];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.backgroundColor = [UIColor whiteColor];
    registerButton.layer.cornerRadius = 2;
    registerButton.layer.masksToBounds = YES;
    [registerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [registerButton setTitle:@"确定" forState:UIControlStateNormal];
    //    registerButton.backgroundColor = [UIColor whiteColor];
    registerButton.titleLabel.font = ADeanFONT13;
    [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(40));
        make.right.equalTo(@(-40));
        make.top.equalTo(self.passWordTextField.mas_bottom).offset(30);
        make.height.equalTo(@30);
    }];
    
}


- (void)registerAction
{

}

- (void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
