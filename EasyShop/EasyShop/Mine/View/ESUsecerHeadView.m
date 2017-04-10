//
//  ESUsecerHeadView.m
//  EasyShop
//
//  Created by 就手国际 on 17/1/4.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import "ESUsecerHeadView.h"
@interface ESUsecerHeadView()
@property (nonatomic, strong) UIImageView     *userImg;//用户图像
@property (nonatomic ,strong) UIView * radiuView;

@end
@implementation ESUsecerHeadView
-(void)setUserInfo:(UserInfo *)userInfo{
    _userInfo = userInfo;
    [self.userImg sd_setImageWithURL:[NSURL URLWithString:_userInfo.logo]
                    placeholderImage:[UIImage imageNamed:@"bg100"]];
    self.nickNameLabel.text=userInfo.nickname;
    self.signatureLable.text=userInfo.signature;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
        [self addSubview:self.radiuView];
        [self.radiuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@26);
            make.width.height.equalTo(@73);
            make.top.equalTo(@0);
        }];
        [self addSubview:self.userImg];
        [self.userImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.radiuView.mas_centerX);
            make.centerY.equalTo(self.radiuView.mas_centerY);
            make.width.height.equalTo(@65);
            
        }];
        [self addSubview:self.nickNameLabel];
        [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userImg.mas_right).offset(20);
            make.top.equalTo(@7);
            
        }];
        [self addSubview:self.signatureLable];
        [self.signatureLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userImg.mas_right).offset(20);
            make.bottom.equalTo(@(-9));
        }];
        [self addSubview:self.registerButton];
        [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userImg.mas_right).offset(20);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            make.bottom.equalTo(@-14);
        }];
        [self addSubview:self.centerLineView];
        [self.centerLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.registerButton.mas_right).offset(25);
            make.height.equalTo(@20);
            make.width.equalTo(@1);
            make.centerY.equalTo(self.registerButton.mas_centerY);
        }];
        [self addSubview:self.loginButton];
        [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerLineView.mas_right).offset(25);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            make.bottom.equalTo(@-14);
        }];
        
    }
    return self;
}
-(UIView *)radiuView{
    if (_radiuView==nil) {
        _radiuView=[[UIView alloc]init];
        _radiuView.layer.cornerRadius=36.5;
        _radiuView.layer.borderWidth=1;
        _radiuView.layer.borderColor=RGB(220, 220, 220).CGColor;
        _radiuView.layer.masksToBounds=YES;
    }
    return _radiuView;
}
-(UIView *)centerLineView{
    if (_centerLineView==nil) {
        _centerLineView=[[UIView alloc]init];
        _centerLineView.hidden=YES;
        _centerLineView.backgroundColor=[UIColor whiteColor];
    }
    return _centerLineView;
}
-(UILabel *)nickNameLabel{
    if (_nickNameLabel==nil) {
        _nickNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 40)];
        _nickNameLabel.hidden=YES;
        _nickNameLabel.textAlignment=NSTextAlignmentLeft;
        _nickNameLabel.font=[UIFont systemFontOfSize:14];
        _nickNameLabel.textColor=AllTextColor;
    }
    return _nickNameLabel;
}
-(UILabel *)signatureLable{
    if (_signatureLable==nil) {
        _signatureLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        _signatureLable.hidden=YES;
        _signatureLable.numberOfLines=0;
        _signatureLable.textColor=AllTextColor;
        _signatureLable.textAlignment=NSTextAlignmentLeft;
        _signatureLable.font=[UIFont systemFontOfSize:14];
    }
    return _signatureLable;
}
- (UIImageView *)userImg
{
    if (!_userImg) {
        _userImg =[[UIImageView alloc] init];
        _userImg.layer.cornerRadius = 32.5;
        _userImg.layer.masksToBounds = YES;
        _userImg.userInteractionEnabled=YES;
        _userImg.image=[UIImage imageNamed:@"bg100"];
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [_userImg addGestureRecognizer:tap];
        _userImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _userImg;
}
-(void)tapAction{
    ESLoginVerify
    if (self.userCenterBlock) {
        self.userCenterBlock();
    }
}
- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
-(UIButton*)registerButton{
    if (_registerButton==nil) {
        _registerButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 60)];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
