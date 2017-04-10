//
//  ESTableViewCouponCell.m
//  EasyShop
//
//  Created by wcz on 16/7/19.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESTableViewCouponCell.h"


@interface ESTableViewCouponCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *conditionLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation ESTableViewCouponCell

- (void)setCouponInfo:(CouponInfo *)couponInfo
{
    _couponInfo = couponInfo;
    
    self.nameLabel.text = _couponInfo.use_comments;//@"SWISSE 专享40元";
    self.priceLabel.text = _couponInfo.c_value;//@"40";
    self.conditionLabel.text = _couponInfo.c_num;//@"满198使用";
    self.timeLabel.text = _couponInfo.cover;//@"2017.3.3已过期";
    self.titleLabel.text = @"--";//@"指定商品使用";
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:11];
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textColor = [UIColor blackColor];
    }
    return _timeLabel;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont boldSystemFontOfSize:24];
        _priceLabel.textColor = [UIColor blackColor];
    }
    return _priceLabel;
}

- (UILabel *)conditionLabel
{
    if (_conditionLabel == nil) {
        _conditionLabel = [[UILabel alloc] init];
        _conditionLabel.font = [UIFont systemFontOfSize:12];
        _conditionLabel.textColor = [UIColor blackColor];
    }
    return _conditionLabel;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = RGB(240 , 240, 240);
        self.contentView.layer.cornerRadius=6;
        self.contentView.layer.masksToBounds=YES;
        //        self.contentView.alpha = 0.2;
        [self initalizedView];
    }
    return  self;
}

- (void)initalizedView
{
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(@12);
    }];
    
    UILabel *unitLabel = [[UILabel alloc] init];
    unitLabel.text = @"¥";
    unitLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:unitLabel];
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(20);
    }];
    
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(unitLabel.mas_right).offset(5);
        make.bottom.equalTo(unitLabel);
    }];
    
    [self.contentView addSubview:self.conditionLabel];
    [self.conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.priceLabel.mas_centerY).offset(-3);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(5);
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(20);
        make.top.equalTo(self.priceLabel);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.timeLabel);
    }];
    
    
    //    [self setModel:nil];
}

- (void)setModel:(id)model
{
    self.nameLabel.text = @"SWISSE 专享40元";
    self.priceLabel.text = @"40";
    self.conditionLabel.text = @"满198使用";
    self.timeLabel.text = @"2017.3.3已过期";
    self.titleLabel.text = @"指定商品使用";
}


@end
