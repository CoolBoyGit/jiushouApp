//
//  ESLoginHeaderView.m
//  EasyShop
//
//  Created by 就手国际 on 17/1/17.
//  Copyright © 2017年 :. All rights reserved.
//

#import "ESLoginHeaderView.h"
#import "ESInputTextField.h"
@interface ESLoginHeaderView()<ESInputTextFieldDelete>
@property (nonatomic, strong) ESInputTextField *mobileNumTextField;
@property (nonatomic,strong) UIImageView*userImageView;
@end
@implementation ESLoginHeaderView

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.userImageView];
        [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.height.width.equalTo(@80);
            make.top.equalTo(@30);
        }];
        [self addSubview:self.mobileNumTextField];
        [self.mobileNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userImageView.mas_bottom).offset(25);
            make.left.equalTo(@20);
            make.right.equalTo(@-20);
            make.height.equalTo(@35);
        }];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mobileNumTextFieldAction:) name:ESLoginClickCellAction object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeUserImageView:) name:ESLoginUserImageView object:nil];
    }
    return self;
}
-(void)changeUserImageView:(NSNotification*)nofi{
    NSDictionary*dic=nofi.userInfo;
    NSString*str=dic[@"userimage"];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"bg100"]];
}
-(void)mobileNumTextFieldAction:(NSNotification*)noti{
    NSDictionary*dic=noti.userInfo;
    self.mobileNumTextField.text=dic[@"cellmobile"];
}
- (ESInputTextField *)mobileNumTextField
{
    if (_mobileNumTextField ==nil) {
        _mobileNumTextField = [[ESInputTextField alloc] initWithImage:nil needChange:YES andIsLogin:YES];
        _mobileNumTextField.TextDelete=self;
        _mobileNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _mobileNumTextField.image=[UIImage imageNamed:@"loginuser"];
        _mobileNumTextField.font=[UIFont systemFontOfSize:15];
        _mobileNumTextField.keyboardType = UIKeyboardTypeDefault;
        _mobileNumTextField.returnKeyType=UIReturnKeyNext;
        _mobileNumTextField.placeholder = @"手机号";
        _mobileNumTextField.backgroundColor=RGB(240, 240, 240);
        _mobileNumTextField.isHiddenButton=NO;
        @weakify(self);
        _mobileNumTextField.mobileBlock=^(BOOL isHidden){
            @strongify(self);
            if (self.mobileBlock) {
                self.mobileBlock(isHidden);
            }
        };
    }
    return _mobileNumTextField;
}
-(UIImageView *)userImageView{
    if (_userImageView==nil) {
        _userImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg100"]];
        _userImageView.layer.cornerRadius=40;
        _userImageView.layer.masksToBounds=YES;
        _userImageView.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _userImageView;
}
-(void)inputTextFieldDidChange:(NSString *)InputTextFieldText{
    NSDictionary*dic=@{@"mobile":InputTextFieldText};
    [[NSNotificationCenter defaultCenter]postNotificationName:ESLoginEditMobileTextfield object:nil userInfo:dic];
}
@end
