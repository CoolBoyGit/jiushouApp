//
//  ESGoodsCell.m
//  EasyShop
//
//  Created by guojian on 16/5/30.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESGoodsCell.h"

@interface ESGoodsCell()

@property (nonatomic, strong) UIImageView *imageView;     // 图片
@property (nonatomic, strong) UILabel *originPriceLabel;  // 原价
@property (nonatomic, strong) UILabel *priceLabel;        // 现价
@property (nonatomic, strong) UILabel *productTitleLabel; // 标题


@end

@implementation ESGoodsCell

- (void)setGoodsInfo:(GoodsInfo *)goodsInfo
{
    _goodsInfo = goodsInfo;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_goodsInfo.image]
                      placeholderImage:[UIImage imageNamed:@"bg100"]];
    self.originPriceLabel.text = @"";
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",_goodsInfo.price.floatValue];
    self.productTitleLabel.text = _goodsInfo.name;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.productTitleLabel];
        [self.contentView addSubview:self.priceLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@00);
        make.height.equalTo(@((ScreenWidth-3)/2.0));
    }];
    [self.productTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.right.equalTo(@(-5));
        make.top.equalTo(self.imageView.mas_bottom).offset(0);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.right.equalTo(@(-5));
        make.top.equalTo(self.productTitleLabel.mas_bottom).offset(5);
    }];

}


- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"page3"];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UILabel *)originPriceLabel
{
    if (_originPriceLabel == nil) {
        _originPriceLabel = [[UILabel alloc] init];
        _originPriceLabel.text = @"¥1270";
        _originPriceLabel.font = [UIFont systemFontOfSize:12];
        _originPriceLabel.textColor = [UIColor purpleColor];
    }
    return _originPriceLabel;
}

- (UILabel *)productTitleLabel
{
    if (_productTitleLabel == nil) {
        _productTitleLabel = [[UILabel alloc] init];
        _productTitleLabel.text = @"3件装 | aptmail德国爱他美 婴儿奶粉 pre段 800克/罐 3罐装 0-3 个月";
        _productTitleLabel.numberOfLines = 2;
        _productTitleLabel.font = [UIFont systemFontOfSize:12];
        _productTitleLabel.textColor = [UIColor blackColor];
    }
    return _productTitleLabel;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = @"¥270|";
        _priceLabel.textAlignment=NSTextAlignmentLeft;
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.textColor = [UIColor redColor];
    }
    return _priceLabel;
}

@end
