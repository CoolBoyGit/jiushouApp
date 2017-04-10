//
//  ESAddressListCell.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESAddressListCell.h"

@interface ESAddressListCell()

@property (nonatomic, strong) UIButton    *defaultBtn;//默认地址
@property (nonatomic, strong) UIButton    *delegateBtn;//删除按钮
@property (nonatomic, strong) UILabel      *middleLine;//中间线
@property (nonatomic, strong) UILabel     *userNameLabel;//用户名
@property (nonatomic, strong) UILabel     *isCertifyLabel;//是否认证
@property (nonatomic, strong) UILabel     *mobileLabel;//手机号
@property (nonatomic, strong) UILabel     *addressLabel;//地址
@property (nonatomic, strong) UILabel     *identityLabel;//身份证
@property (nonatomic,strong) UIButton    *editButton;

@end

@implementation ESAddressListCell

- (void)setAddressInfo:(AddressInfo *)addressInfo
{
    _addressInfo = addressInfo;
    
    self.defaultBtn.selected = _addressInfo.ddefault.integerValue;
    self.userNameLabel.text = _addressInfo.name;
    NSMutableString*str=[[NSMutableString alloc]initWithString:_addressInfo.mobile];
   [str replaceCharactersInRange:NSMakeRange(4, 3) withString:@"***"];
    self.mobileLabel.text = str;
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@",_addressInfo.area,_addressInfo.address];
   // self.identityLabel.text = _addressInfo.persoinid;
    if (_addressInfo.personid.length==0) {
        
        self.identityLabel.text = [NSString stringWithFormat:@"身份证:%@",@""];

    }else{
        NSMutableString*identiStr=[NSMutableString stringWithString:_addressInfo.personid];
        [identiStr replaceCharactersInRange:NSMakeRange(4, 9) withString:@"*********"];
        self.identityLabel.text = [NSString stringWithFormat:@"身份证:%@",identiStr];
    }
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupViews
{
    [self.contentView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@13);
        make.left.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [self.contentView addSubview:self.mobileLabel];
    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@13);
        make.right.mas_equalTo(@(-20));
        make.height.mas_equalTo(@20);
    }];
    [self.contentView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userNameLabel.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.userNameLabel.mas_left).with.offset(0);
        make.right.equalTo(@(-20));
    }];
    [self.contentView addSubview:self.identityLabel];
    [self.identityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.addressLabel.mas_bottom).offset(8);
        make.height.equalTo(@20);
    }];
    [self.contentView addSubview:self.middleLine];
    [self.middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.top.equalTo(self.identityLabel.mas_bottom).offset(10);
        make.left.right.equalTo(@0);
    }];
    [self.contentView addSubview:self.defaultBtn];
    [self.defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.top.equalTo(self.middleLine.mas_bottom).offset(15);
        make.left.equalTo(@20);
        make.width.equalTo(@80);
    }];
    [self.contentView addSubview:self.delegateBtn];
    [self.delegateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.top.equalTo(self.middleLine.mas_bottom).offset(10);
        make.right.equalTo(@(-20));
    }];
    [self.contentView addSubview:self.editButton];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.top.equalTo(self.middleLine.mas_bottom).offset(10);
        make.right.equalTo(self.delegateBtn.mas_left).offset(-10);

    }];
    
}

- (UIButton *)defaultBtn
{
    if (!_defaultBtn) {
        _defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_defaultBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -8)];
        [_defaultBtn setImage:[UIImage imageNamed:@"shopcart_unselect_icon"] forState:UIControlStateNormal];
        [_defaultBtn setImage:[UIImage imageNamed:@"shopcart_selected_icon"] forState:UIControlStateSelected];
        _defaultBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_defaultBtn setTitle:@"设为默认" forState:UIControlStateNormal];
        [_defaultBtn setTitle:@"默认地址" forState:UIControlStateSelected];
        [_defaultBtn setTitleColor:RGB(233, 40, 46) forState:UIControlStateSelected];
        [_defaultBtn setTitleColor:RGB(90, 90, 90) forState:UIControlStateNormal];
        [_defaultBtn setBackgroundColor:[UIColor whiteColor]];
        [_defaultBtn addTarget:self action:@selector(defaultBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultBtn;
}
-(UIButton *)editButton{
    if (_editButton==nil) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setImage:[UIImage imageNamed:@"mine_address_editButton"] forState:UIControlStateNormal];
        _editButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _editButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitleColor:RGB(90, 90, 90)  forState:UIControlStateNormal];
        [_editButton setBackgroundColor:[UIColor whiteColor]];
        [_editButton addTarget:self action:@selector(editButtonaction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}
- (UIButton *)delegateBtn
{
    if (!_delegateBtn) {
        _delegateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delegateBtn setImage:[UIImage imageNamed:@"mine_address_delectButton"] forState:UIControlStateNormal];
        _delegateBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _delegateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_delegateBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_delegateBtn setTitleColor:RGB(90, 90, 90)  forState:UIControlStateNormal];
        [_delegateBtn setBackgroundColor:[UIColor whiteColor]];
        [_delegateBtn addTarget:self action:@selector(delegateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delegateBtn;
}
- (UILabel *)middleLine
{
    if (!_middleLine) {
        _middleLine = [[UILabel alloc] init];
        _middleLine.backgroundColor = KCommontLineViewBagroudColor;
    }
    return _middleLine;
}
- (UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.font = [UIFont systemFontOfSize:14];
        _userNameLabel.textColor = AllTextColor;//ADeanHEXCOLOR(0x00508c);
        _userNameLabel.backgroundColor = [UIColor clearColor];
    }
    return _userNameLabel;
}
- (UILabel *)isCertifyLabel
{
    if (!_isCertifyLabel) {
        _isCertifyLabel = [[UILabel alloc] init];
        _isCertifyLabel.textAlignment = NSTextAlignmentCenter;
        _isCertifyLabel.font = ADeanFONT15;
        _isCertifyLabel.layer.cornerRadius = 10;
        _isCertifyLabel.layer.masksToBounds = YES;
        _isCertifyLabel.layer.borderWidth = 1;
        _isCertifyLabel.layer.borderColor = [UIColor redColor].CGColor;
        _isCertifyLabel.textColor = [UIColor redColor];//ADeanHEXCOLOR(0x00508c);
        _isCertifyLabel.backgroundColor = [UIColor clearColor];
    }
    return _isCertifyLabel;
}
- (UILabel *)mobileLabel
{
    if (!_mobileLabel) {
        _mobileLabel = [[UILabel alloc] init];
        _mobileLabel.textAlignment = NSTextAlignmentRight;
        _mobileLabel.font = [UIFont systemFontOfSize:13.5];
        _mobileLabel.textColor = AllTextColor;
        _mobileLabel.backgroundColor = [UIColor clearColor];
    }
    return _mobileLabel;
}
- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.font = ADeanFONT14;
        _addressLabel.numberOfLines=0;
        _addressLabel.textColor = AllTextColor;
        _addressLabel.backgroundColor = [UIColor clearColor];
    }
    return _addressLabel;
}
- (UILabel *)identityLabel
{
    if (!_identityLabel) {
        _identityLabel = [[UILabel alloc] init];
        _identityLabel.textAlignment = NSTextAlignmentLeft;
        _identityLabel.font = ADeanFONT14;
        _identityLabel.textColor = AllTextColor;
        _identityLabel.backgroundColor = [UIColor clearColor];
    }
    return _identityLabel;
}


-(void)editButtonaction{
    if (self.editBlock) {
        self.editBlock();
    }
}
-(void)defaultBtnAction:(UIButton *)btn
{
    if (!self.defaultBtn.isSelected) {//未选中
        if (self.defaultBlock) {
            self.defaultBlock();
        }
    }
}
-(void)delegateBtnAction:(UIButton *)btn
{
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

@end
