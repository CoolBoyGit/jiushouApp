//
//  ESRecommendShopCell.m
//  EasyShop
//
//  Created by wcz on 16/3/31.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESRecommendShopCell.h"

@interface ESRecommendShopCell ()

@property (nonatomic, strong) UIImageView *imageView;     // 图片
@property (nonatomic, strong) UILabel *priceLabel;        // 现价
@property (nonatomic, strong) UILabel *productTitleLabel; // 标题

@end

@implementation ESRecommendShopCell

- (void)setGoodsInfo:(GoodsInfo *)goodsInfo
{
    _goodsInfo = goodsInfo;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_goodsInfo.image]
                      placeholderImage:[UIImage imageNamed:@"bg"]];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",_goodsInfo.price.floatValue];
    self.productTitleLabel.text = _goodsInfo.name;
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



- (UILabel *)productTitleLabel
{
    if (_productTitleLabel == nil) {
        _productTitleLabel = [[UILabel alloc] init];
        _productTitleLabel.text = @"Sk-11 神仙水 215毫升";
//        _productTitleLabel.numberOfLines = 0;
        _productTitleLabel.numberOfLines = 2;
        _productTitleLabel.font = [UIFont systemFontOfSize:13];
        _productTitleLabel.textColor = AllTextColor;
    }
    return _productTitleLabel;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = @"¥270";
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.textColor = [UIColor redColor];
    }
    return _priceLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@0);
            make.height.equalTo(@135);
        }];
        
        [self.contentView addSubview:self.productTitleLabel];
        [self.productTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@5);
            make.right.equalTo(@(-5));
            make.top.equalTo(self.imageView.mas_bottom).offset(5);
        }];
        
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.bottom.equalTo(@(-10));
        }];
        
        
    }
    return self;
}

- (void)setModel:(id)model
{
    
}

@end
