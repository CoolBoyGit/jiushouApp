//
//  ESUserInfoCell.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/9.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESUserInfoCell.h"

@interface ESUserInfoCell()

@property (nonatomic, strong) UIImageView     *userImg;//用户图像
@property (nonatomic, strong) UILabel         *userName;//用户名字

@end

@implementation ESUserInfoCell

- (void)setUserInfo:(UserInfo *)userInfo
{
    _userInfo = userInfo;
    
    [self.userImg sd_setImageWithURL:[NSURL URLWithString:_userInfo.logo]
                    placeholderImage:[UIImage imageNamed:@"bg100"]];
    self.userName.text = _userInfo.username;
    self.nickNameLabel.text=userInfo.nickname;
    self.signatureLable.text=userInfo.signature;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel*lable=[[UILabel alloc]init];
        lable.alpha=1;
        lable.backgroundColor=RGB(210, 210, 210);
        [self.contentView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(@(0.5));
        }];
    }
    return self;
}

- (void)setupViews
{
    self.userImg.image = [UIImage imageNamed:@"user"];
    [self.contentView addSubview:_userImg];
    [_userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.height.equalTo(@50);
        make.width.equalTo(@50);
    }];
    
    [self.contentView addSubview:self.nickNameLabel];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImg.mas_right).offset(20);
        make.top.equalTo(@10);
        make.right.equalTo(@(-10));
        make.height.equalTo(@20);
        
        
    }];
    [self.contentView addSubview:self.signatureLable];
    [self.signatureLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImg.mas_right).offset(20);
        make.top.equalTo(@40);
        make.right.equalTo(@(-10));
        make.height.equalTo(@20);

    }];
    
    [self.contentView addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(self.userImg.mas_right).with.offset(20);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    [self.contentView addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        //make.left.equalTo(self.loginButton.mas_right).offset(20);
        make.right.equalTo(@(-20));
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        
    }];
}
-(UILabel *)nickNameLabel{
    if (_nickNameLabel==nil) {
        _nickNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 40)];
        _nickNameLabel.hidden=YES;
        _nickNameLabel.text=@"路人甲";
        _nickNameLabel.textAlignment=NSTextAlignmentLeft;
        _nickNameLabel.font=[UIFont systemFontOfSize:15];
        _nickNameLabel.textColor=AllTextColor;
    }
    return _nickNameLabel;
}
-(UILabel *)signatureLable{
    if (_signatureLable==nil) {
        _signatureLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        _nickNameLabel.hidden=YES;
        _signatureLable.textColor=AllTextColor;
        _signatureLable.textAlignment=NSTextAlignmentLeft;
        _signatureLable.font=[UIFont systemFontOfSize:15];
        _signatureLable.text=@"就手国际欢迎你";
    }
    return _signatureLable;
}
- (UIImageView *)userImg
{
    if (!_userImg) {
        _userImg =[[UIImageView alloc] init];
        _userImg.layer.cornerRadius = 25;
        _userImg.layer.masksToBounds = YES;
        _userImg.image=[UIImage imageNamed:@"bg100"];
        _userImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _userImg;
}
- (UILabel *)userName
{
    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _userName.backgroundColor = [UIColor clearColor];
        _userName.font = ADeanFONT13;
        _userName.textColor = AllTextColor;
        _userName.textAlignment = NSTextAlignmentLeft;
    }
    return _userName;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.layer.cornerRadius = 4;
        
        _loginButton.layer.masksToBounds = YES;
        [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:AllButtonBackColor];
        [_loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
-(UIButton*)registerButton{
    if (_registerButton==nil) {
        _registerButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 60)];
        _registerButton.layer.cornerRadius=4;
        _registerButton.layer.masksToBounds=YES;
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton setBackgroundColor:AllButtonBackColor];
        [_registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}
-(void)loginButtonAction
{
    if (self.loaginBlock) {
        self.loaginBlock();
        
    }
    
}
-(void)registerButtonAction{
    if (self.registerBlock) {
        self.registerBlock();
    }
}
@end
