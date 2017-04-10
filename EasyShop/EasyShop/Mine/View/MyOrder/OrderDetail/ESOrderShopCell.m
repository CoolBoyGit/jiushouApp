//
//  ESOrderShopCell.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/12.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESOrderShopCell.h"

@interface ESOrderShopCell ()

@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *productNameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation ESOrderShopCell

- (void)setGoodsInfo:(OrderGoodsInfo *)goodsInfo
{
    _goodsInfo = goodsInfo;
    
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:goodsInfo.goods_image]
                             placeholderImage:[UIImage imageNamed:@"bg100"]];
    self.productNameLabel.text = goodsInfo.goods_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",goodsInfo.goods_price];
    self.countLabel.text = [NSString stringWithFormat:@"X%@",goodsInfo.goods_num];
//    CGFloat count=[goodsInfo.goods_price floatValue]*[goodsInfo.goods_num floatValue];
//    NSString*str=[NSString stringWithFormat:@"合计:¥%.2f",count];
//    NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc ]initWithString:[NSString stringWithFormat:@"合计:¥%.2f",count]];
//    [muStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46)} range:NSMakeRange(3, str.length-3)];
//    self.stateLabel.attributedText=muStr;
}

- (UILabel *)stateLabel
{
    if (_stateLabel == nil) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.textColor = AllTextColor;
        _stateLabel.font = [UIFont systemFontOfSize:14];
    }
    return _stateLabel;
}
- (UILabel *)productNameLabel
{
    if (_productNameLabel == nil) {
        _productNameLabel = [[UILabel alloc] init];
        _productNameLabel.textColor = AllTextColor;
        _productNameLabel.numberOfLines = 2;
        _productNameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _productNameLabel;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = AllTextColor;
        _priceLabel.textAlignment=NSTextAlignmentRight;
        _priceLabel.font = [UIFont systemFontOfSize:14];
    }
    return _priceLabel;
}

- (UILabel *)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textAlignment=NSTextAlignmentRight;
        _countLabel.font = [UIFont systemFontOfSize:12];
        _countLabel.textColor=RGB(172, 172, 172);
    }
    return _countLabel;
}

- (UIImageView *)productImageView
{
    if (_productImageView == nil) {
        _productImageView = [[UIImageView alloc] init];
    }
    return _productImageView;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self intalizedView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)intalizedView
{
    
    [self.contentView addSubview:self.productImageView];
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(10));
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.height.width.equalTo(@60);
    }];
    [self.contentView addSubview:self.productNameLabel];
    [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(12);
        make.top.equalTo(@12);
        make.right.equalTo (@(-80));
    }];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.left.equalTo(self.productNameLabel.mas_right).offset(2);
        make.top.equalTo(@12);
        
    }];
    [self.contentView addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.width.equalTo(@30);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(10);
        
    }];
   
}

@end
