//
//  ESSignatureController.m
//  EasyShop
//
//  Created by jiushou on 16/6/27.
//  Copyright © 2016年 wcz. All rights reserved.
//
//修改签名
#import "ESSignatureController.h"

@interface ESSignatureController ()<UITextFieldDelegate>
/** indicator */
@property (nonatomic,strong) ESIndicator *indicator;
@end

@implementation ESSignatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"修改个性签名";
//    self.navigationController.navigationBar.translucent=NO;
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    [self.view addSubview:self.signatureTextField];
    [self.signatureTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@90);
        make.left.equalTo(@20);
        make.right.equalTo(@(-20));
        make.height.equalTo(@30);
    }];
    [self.view addSubview:self.signaButton];
    [self.signaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@160);
        make.left.equalTo(@20);
        make.right.equalTo(@(-20));
        make.height.equalTo(@30);
        
    }];
    // Do any additional setup after loading the view.
}
-(void)tapAction{
    [self.view endEditing:YES];
}
-(UIButton *)signaButton{
    if (_signaButton==nil) {
        _signaButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        [_signaButton setTitle:@"确认" forState:UIControlStateNormal];
        [_signaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _signaButton.layer.cornerRadius=15;
        _signaButton.layer.masksToBounds=YES;
        [_signaButton setBackgroundColor:RGB(233, 40, 46)];
        _signaButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_signaButton addTarget:self action:@selector(signaButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signaButton;
}
-(UITextField *)signatureTextField{
    if (_signatureTextField==nil) {
        _signatureTextField=[[UITextField alloc]initWithFrame: CGRectMake(0, 0, ScreenWidth, 80)];
        UIView*whiteView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 44)];
        whiteView.backgroundColor=RGB(246, 246, 246);
        _signatureTextField.leftView=whiteView;
        //作用是为了让文字距离左边的位置远点
        whiteView.contentMode   = UIViewContentModeScaleAspectFit;
        _signatureTextField. leftViewMode       = UITextFieldViewModeAlways;
//        [_signatureTextField becomeFirstResponder];
        _signatureTextField.layer.cornerRadius=15;
        _signatureTextField.layer.masksToBounds=YES;
        _signatureTextField.layer.borderWidth=0.5;
        _signatureTextField.layer.borderColor=RGB(233, 40, 46).CGColor;
        _signatureTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
        _signatureTextField.backgroundColor=RGB(246, 246, 246);
        _signatureTextField.font=[UIFont systemFontOfSize:15];
        _signatureTextField.text=kUserManager.userInfo.signature;
        _signatureTextField.delegate=self;
    }
    return _signatureTextField;
}
-(void)signaButtonAction{
//    if (self.signatureTextField.text.length>20) {
//        UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"请检查你的字数" message:@"字数不超过20个字符" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            self.signatureTextField.text=@"";
//        }];
//        [alertCon addAction:action];
//        [self presentViewController:alertCon animated:YES completion:nil];
//        
//    }
//    else if (self.signatureTextField.text.length==0){
//        UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"请检查你的字数" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            self.signatureTextField.text=@"";
//        }];
//        [alertCon addAction:action];
//        [self presentViewController:alertCon animated:YES completion:nil];
//
//    }
//    else{
        UserEditRequest*request=[UserEditRequest request];
        request.signature=self.signatureTextField.text;
        [self editUserInfoWithRequest:request success:^{
            [[NSNotificationCenter defaultCenter]postNotificationName:kUserSignatureNotification object:nil];
            [self .navigationController popViewControllerAnimated:YES];
        }];
//    }

    
}
- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}
-(void)addNotification{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)editUserInfoWithRequest:(UserEditRequest *)request
                        success:(OkBlock)success
{
    @weakify(self);
    [self.indicator startAnimationWithMessage:@"正在修改签名"];
    [ESService userEditRequest:request success:^{
        @strongify(self);
        [self endGSNetworking];
        
        [ESToast showSuccess:@"修改签名成功！"];
        kUserManager.userInfo.signature=self.signatureTextField.text;
        success();
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}
- (void)endGSNetworking
{
    [self.indicator stopAnimation];
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