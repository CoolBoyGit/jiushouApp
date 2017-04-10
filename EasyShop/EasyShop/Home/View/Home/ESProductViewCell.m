//
//  ESProductViewCell.m
//  EasyShop
//
//  Created by wcz on 16/3/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESProductViewCell.h"

@interface ESProductViewCell ()

@property (nonatomic, strong) UIImageView *imageView;     // 图片
@property (nonatomic, strong) UILabel *originPriceLabel;  // 原价
@property (nonatomic, strong) UILabel *priceLabel;        // 现价
@property (nonatomic, strong) UILabel *productTitleLabel; // 标题

@end

@implementation ESProductViewCell

- (void)setGoodsInfo:(GoodsInfo *)goodsInfo
{
    _goodsInfo = goodsInfo;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_goodsInfo.image]
                      placeholderImage:[UIImage imageNamed:@"bg100"]];
    self.originPriceLabel.text = _goodsInfo.market_price.stringValue;
   NSString*str= [NSString stringWithFormat:@"¥%.2f",_goodsInfo.price.floatValue];
    NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc]initWithString:str];
    [muStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:14.5]} range:NSMakeRange(1, str.length-1)];
    [muStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(str.length-2, 2)];
    self.priceLabel.attributedText=muStr;
    self.productTitleLabel.text = _goodsInfo.name;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@""];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UILabel *)originPriceLabel
{
    if (_originPriceLabel == nil) {
        _originPriceLabel = [[UILabel alloc] init];
        _originPriceLabel.text = @"¥1270";
        _originPriceLabel.font = [UIFont systemFontOfSize:11];
        _originPriceLabel.textColor = [UIColor blackColor];
    }
    return _originPriceLabel;
}

- (UILabel *)productTitleLabel
{
    if (_productTitleLabel == nil) {
        _productTitleLabel = [[UILabel alloc] init];
        _productTitleLabel.text = @"Sk-11 神仙水 215毫升";
        _productTitleLabel.numberOfLines = 2;
        _productTitleLabel.textAlignment=NSTextAlignmentLeft;
        _productTitleLabel.font = [UIFont systemFontOfSize:13];
        _productTitleLabel.textColor=RGB(70, 70, 70);
    }
    return _productTitleLabel;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = @"¥270";
        _priceLabel.textAlignment=NSTextAlignmentCenter;
        _priceLabel.font = [UIFont systemFontOfSize:12];
        _priceLabel.textColor = RGB(233, 40, 46);
    }
    return _priceLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(self.imageView.mas_width);
            make.top.equalTo(@5);
        }];
        
        [self.contentView addSubview:self.productTitleLabel];
        [self.productTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(@(-10));
            make.top.equalTo(self.imageView.mas_bottom).offset(0);
        }];
        
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            
        }];
        
    }
    return self;
}




@end
