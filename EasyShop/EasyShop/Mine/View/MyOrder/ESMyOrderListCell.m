//
//  ESMyOrderListCell.m
//  EasyShop
//
//  Created by wcz on 16/4/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESMyOrderListCell.h"

@interface ESMyOrderListCell ()


@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic, strong) UILabel *productNameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic ,strong) UILabel*taxFeeLabel;//税费



@end

@implementation ESMyOrderListCell

- (void)setGoodsInfo:(OrderGoodsInfo *)goodsInfo
{
    _goodsInfo = goodsInfo;
   
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:goodsInfo.goods_image]
                             placeholderImage:[UIImage imageNamed:@"bg"]];
    
    self.productNameLabel.text = goodsInfo.goods_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",goodsInfo.goods_price.floatValue];
    self.countLabel.text = [NSString stringWithFormat:@"x%@",goodsInfo.goods_num];
    
}
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=RGB(236, 236, 236);
    }
    return _lineView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.productImageView];
        [self.contentView addSubview:self.productNameLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.countLabel];
        [self.contentView addSubview:self.taxFeeLabel];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@0.35);
            make.bottom.equalTo(@0);
        }];
        [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(12));
            make.top.equalTo(@5);
            make.height.width.equalTo(@60);
        }];
        [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@90);
            make.right.equalTo(@(-80 ));
            make.top.equalTo(@10);
        }];
            [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-15));
            make.left.equalTo(self.productNameLabel.mas_right).offset(2);
            make.top.equalTo(@10);
        }];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-15));
            make.width.equalTo(@30);
            make.top.equalTo(self.priceLabel.mas_bottom).offset(10);
            
        }];
        [self.taxFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.priceLabel.mas_bottom).offset(10);
            make.right.equalTo(@(-15));
            make.left.equalTo(self.productNameLabel.mas_right).offset(5);
            make.height.equalTo(@20);
        }];


    }
    return self;
}


-(UILabel *)taxFeeLabel{
    if (_taxFeeLabel==nil) {
        _taxFeeLabel=[[UILabel alloc]init];
        _taxFeeLabel.font=[UIFont systemFontOfSize:12];
        _taxFeeLabel.textAlignment=NSTextAlignmentRight;
    }
    return _taxFeeLabel;
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
        _priceLabel.textAlignment=NSTextAlignmentRight;
        _priceLabel.textColor = AllTextColor;
        _priceLabel.font = [UIFont systemFontOfSize:14];
    }
    return _priceLabel;
}

- (UILabel *)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textAlignment=NSTextAlignmentRight;
        _countLabel.textColor=RGB(172, 172, 172);
        _countLabel.font = [UIFont systemFontOfSize:12];
    }
    return _countLabel;
}

- (UIImageView *)productImageView
{
    if (_productImageView == nil) {
        _productImageView = [[UIImageView alloc] init];
        _productImageView.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _productImageView;
}



@end
