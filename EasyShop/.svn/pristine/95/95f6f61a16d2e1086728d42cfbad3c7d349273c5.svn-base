//
//  ESComUserInfoCell.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/4/29.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESComUserInfoCell.h"

@interface ESComUserInfoCell()

@property (nonatomic, strong) UIImageView *userImg;//用户头像
@property (nonatomic, strong) UILabel     *nameLab;//用户名称
@property (nonatomic, strong) UILabel     *saleLab;//销量
@property (nonatomic, strong) UIButton    *attenBtn;//＋关注
@property (nonatomic, strong) UILabel     *signLab;//用户签名信息

@end

@implementation ESComUserInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpViews
{
    [self.contentView addSubview:self.userImg];
    [self.userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(@10);
        make.width.height.mas_equalTo(@(40));
    }];
    
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userImg.mas_right).with.offset(5);
        make.top.mas_equalTo(self.userImg.mas_top).with.offset(0);;
        make.height.mas_equalTo(@25);
        make.width.mas_equalTo(@150);
    }];
    
    [self.contentView addSubview:self.saleLab];
    [self.saleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userImg.mas_right).with.offset(5);
        make.bottom.mas_equalTo(self.userImg.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@150);
    }];
    
    [self.contentView addSubview:self.signLab];
    [self.signLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userImg.mas_left).with.offset(0);
        make.top.mas_equalTo(self.userImg.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@20);
        make.right.mas_equalTo(@-5);
    }];
    
    [self.contentView addSubview:self.attenBtn];
    [self.attenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@(-10));
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@20);
        make.centerY.mas_equalTo(self.userImg.mas_centerY).with.offset(0);;
    }];

}

#pragma mark
#pragma mark - lazy init
-(UIImageView *)userImg
{
    if (!_userImg) {
        _userImg = [[UIImageView alloc] init];
        _userImg.contentMode = UIViewContentModeScaleAspectFit;
        _userImg.image = [UIImage imageNamed:@"share_user"];
        _userImg.layer.cornerRadius = 30;
        _userImg.layer.masksToBounds = YES;
    }
    return _userImg;
}
-(UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.text = @"秋分落叶";
        _nameLab.font = [UIFont systemFontOfSize:13];
        _nameLab.textColor = [UIColor blackColor];
    }
    return _nameLab;
}
-(UILabel *)saleLab
{
    if (!_saleLab) {
        _saleLab = [[UILabel alloc] init];
        _saleLab.text = @"总销量：136   粉丝数：10341";
        _saleLab.font = [UIFont systemFontOfSize:11];
        _saleLab.textColor = [UIColor grayColor];
    }
    return _saleLab;
}
-(UILabel *)signLab
{
    if (!_signLab) {
        _signLab = [[UILabel alloc] init];
        _signLab.text = @"处女座牛马，资深的吃货&超能力。";
        _signLab.font = [UIFont systemFontOfSize:11];
        _signLab.textColor = [UIColor blackColor];
    }
    return _signLab;
}
-(UIButton *)attenBtn
{
    if (!_attenBtn) {
        _attenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_attenBtn setTitle:@"+关注" forState:UIControlStateNormal];
        _attenBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _attenBtn.backgroundColor = [UIColor redColor];
        _attenBtn.layer.cornerRadius = 10;
        _attenBtn.layer.masksToBounds = YES;
    }
    return _attenBtn;
}

@end
