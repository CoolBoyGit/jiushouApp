//
//  ESShipAddressCell.m
//  EasyShop
//
//  Created by wcz on 16/5/29.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShipAddressCell.h"

@interface ESShipAddressCell()
/** title */
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *userNameLab;
@property (nonatomic, strong) UILabel *userAddressLab;
@property (nonatomic, strong) UILabel *userMobileLab;

@end

@implementation ESShipAddressCell

- (void)setAddressInfo:(AddressInfo *)addressInfo
{
    _addressInfo = addressInfo;
    
    self.userNameLab.text = _addressInfo.name;
    self.userAddressLab.text = [NSString stringWithFormat:@"%@%@",_addressInfo.area,_addressInfo.address];
    self.userMobileLab.text = _addressInfo.mobile;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.userNameLab];
        [self.contentView addSubview:self.userAddressLab];
        [self.contentView addSubview:self.userMobileLab];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
            make.top.height.equalTo(@10);
            make.left.height.equalTo(@20);
        }];
        
        [self.userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.height.equalTo(@15);
            make.width.equalTo(@60);
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10);
        }];
        
        [self.userAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.height.equalTo(@20);
            make.width.equalTo(@200);
            make.top.equalTo(self.userNameLab.mas_bottom).with.offset(10);
        }];
        
        [self.userMobileLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userNameLab.mas_right).with.offset(10);
            make.height.equalTo(@15);
            make.width.equalTo(@100);
            make.top.equalTo(self.userNameLab.mas_top).with.offset(0);
        }];
        

    }
    return self;
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel  alloc] init];
        _titleLabel.font = ADeanFONT13;
        _titleLabel.text = @"更改收货地址";
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

-(UILabel *)userNameLab
{
    if (!_userNameLab) {
        _userNameLab = [[UILabel alloc] init];
        _userNameLab.text = @"何更颖";
        _userNameLab.font = [UIFont systemFontOfSize:12];
    }
    return _userNameLab;
}
-(UILabel *)userMobileLab
{
    if (!_userMobileLab) {
        _userMobileLab = [[UILabel alloc] init];
        _userMobileLab.text = @"13270720072";
        _userMobileLab.textAlignment = NSTextAlignmentRight;
        _userMobileLab.font = [UIFont systemFontOfSize:12];
    }
    return _userMobileLab;
}
-(UILabel *)userAddressLab
{
    if (!_userAddressLab) {
        _userAddressLab = [[UILabel alloc] init];
        _userAddressLab.text = @"江苏省 南京市 蓬莱区胜利路23号";
        _userAddressLab.font = [UIFont systemFontOfSize:12];
    }
    return _userAddressLab;
}
@end
