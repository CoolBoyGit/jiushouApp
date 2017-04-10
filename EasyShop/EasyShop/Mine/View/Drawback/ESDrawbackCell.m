
//
//  ICDrawbackCell.m
//  EasyShop
//
//  Created by wcz on 16/4/23.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESDrawbackCell.h"

@interface ESDrawbackCell ()

@property (nonatomic, strong) UILabel *productNameLabel;
@property (nonatomic, strong) UILabel *postageLabel;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation ESDrawbackCell

- (void)setOrderInfo:(OrderInfo *)orderInfo
{
    _orderInfo = orderInfo;
    
//    self.productImageView.image = [UIImage imageNamed:_orderInfo.];
    self.productNameLabel.text = @"sato佐藤日本鼻炎药水/无药味30ml";
    self.postageLabel.text = @"邮费 ： 55.00";
    self.priceLabel.text = @"¥ 119";
    self.statusLabel.text = @"退款中";
}

- (UILabel *)priceLabel
{
    if(_priceLabel == nil)
    {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        _priceLabel.textColor=  [UIColor redColor];
    }
    return _priceLabel;
}

- (UILabel *)statusLabel
{
    if(_statusLabel == nil)
    {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont systemFontOfSize:15];
        _statusLabel.numberOfLines = 0;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.textColor=  [UIColor whiteColor];
        _statusLabel.backgroundColor = [UIColor redColor];
    }
    return _statusLabel;
}

- (UILabel *)productNameLabel
{
    if(_productNameLabel == nil)
    {
        _productNameLabel = [[UILabel alloc] init];
        _productNameLabel.font = [UIFont systemFontOfSize:15];
        _productNameLabel.numberOfLines = 0;
        _productNameLabel.textColor=  [UIColor blackColor];
    }
    return _productNameLabel;
}

- (UILabel *)postageLabel
{
    if(_postageLabel == nil)
    {
        _postageLabel = [[UILabel alloc] init];
        _postageLabel.font = [UIFont systemFontOfSize:15];
        _postageLabel.textColor=  [UIColor blackColor];
    }
    return _postageLabel;
}


- (UIImageView *)productImageView
{
    if (_productImageView == nil) {
        _productImageView = [[UIImageView alloc] init];
    }
    return _productImageView;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = RGB(237, 237, 237);
        [self.contentView addSubview:self.productImageView];
        [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@12);
            make.centerY.equalTo(@0);
            make.width.equalTo(@80);
            make.height.equalTo(@80);
        }];
        
        [self.contentView addSubview:self.productNameLabel];
        [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.productImageView.mas_right).offset(12);
            make.top.equalTo(self.productImageView);
            make.right.equalTo(@(-12));
        }];
        
        [self.contentView addSubview:self.postageLabel];
        [self.postageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.productNameLabel.mas_bottom).offset(10);
            make.left.equalTo(self.productNameLabel);
        }];
        
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.productImageView);
            make.left.equalTo(self.productNameLabel);
        }];
        
        [self.contentView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.width.equalTo(@30);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
    }
    return self;
}

- (void)setModel:(id)model
{
    self.productImageView.image = [UIImage imageNamed:@"page3"];
    self.productNameLabel.text = @"sato佐藤日本鼻炎药水/无药味30ml";
    self.postageLabel.text = @"邮费 ： 55.00";
    self.priceLabel.text = @"¥ 119";
    self.statusLabel.text = @"退款中";
}


@end