//
//  ESOrderAddressCell.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/11.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESOrderAddressCell.h"

@interface ESOrderAddressCell()

@property (nonatomic, strong) UIImageView *locationImg;
@property (nonatomic, strong) UILabel *userNameLab;
@property (nonatomic, strong) UILabel *userAddressLab;
@property (nonatomic, strong) UILabel *userMobileLab;

@end

@implementation ESOrderAddressCell

- (void)setOrderInfo:(OrderDetailInfo *)orderInfo
{
    _orderInfo = orderInfo;
    NSString*str=[NSString stringWithFormat:@"%@%@",orderInfo.receiver_address,self.orderInfo.receiver_area];
    //设置行距
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 5;//设置高度
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paraStyle};
    self.userNameLab.text = _orderInfo.receiver_name;
    NSAttributedString*astr=[[NSAttributedString alloc]initWithString:str attributes:dic];
    self.userAddressLab.attributedText=astr;
    self.userMobileLab.text = [_orderInfo.receiver_mobile stringByReplacingCharactersInRange:NSMakeRange(4, 3) withString:@"***"];}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpViews
{
    [self.contentView addSubview:self.locationImg];
    [self.locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@30);
        make.left.equalTo(@8);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.contentView addSubview:self.userNameLab];
    [self.userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.top.equalTo(@15);
        make.left.equalTo(@43);
    }];
    
    [self.contentView addSubview:self.userAddressLab];
    [self.userAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-40));
        make.top.equalTo(self.userNameLab.mas_bottom).offset(10);
        make.left.equalTo(@43);
    }];
    
    [self.contentView addSubview:self.userMobileLab];
    [self.userMobileLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.top.equalTo(@15);
        make.left.equalTo(self.userNameLab.mas_right).offset(30);
    }];
}

-(UIImageView *)locationImg
{
    if (!_locationImg) {
        _locationImg = [[UIImageView alloc] init];
        _locationImg.image = [UIImage imageNamed:@"share_location"];
    }
    return _locationImg;
}
-(UILabel *)userNameLab
{
    if (!_userNameLab) {
        _userNameLab = [[UILabel alloc] init];
        _userNameLab.text = @"何更颖";
        _userNameLab.font = [UIFont systemFontOfSize:14];
    }
    return _userNameLab;
}
-(UILabel *)userMobileLab
{
    if (!_userMobileLab) {
        _userMobileLab = [[UILabel alloc] init];
        _userMobileLab.text = @"13270720072";
        _userMobileLab.textAlignment = NSTextAlignmentRight;
        _userMobileLab.font = [UIFont systemFontOfSize:14];
    }
    return _userMobileLab;
}
-(UILabel *)userAddressLab
{
    if (!_userAddressLab) {
        _userAddressLab = [[UILabel alloc] init];
        _userAddressLab.text = @"江苏省南京市蓬莱区胜利路23号";
        _userAddressLab.numberOfLines=0;
        _userAddressLab.font = [UIFont systemFontOfSize:14];
    }
    return _userAddressLab;
}

@end
