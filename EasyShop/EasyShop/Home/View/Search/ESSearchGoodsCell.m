//
//  ESSearchGoodsCell.m
//  EasyShop
//
//  Created by guojian on 16/5/22.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESSearchGoodsCell.h"

@interface ESSearchGoodsCell()

@property (nonatomic, strong) UIImageView               *productImg;//商品的图像
@property (nonatomic, strong) UILabel                   *productName;//商品的名称
@property (nonatomic, strong) UILabel                   *productPrice;//商品的价格
@property (nonatomic,strong) UIView *lineView;
@end

@implementation ESSearchGoodsCell
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=KCommontLineViewBagroudColor;
    }
    return _lineView;
}
- (void)setGoodsInfo:(GoodsInfo *)goodsInfo
{
    _goodsInfo = goodsInfo;
    
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:_goodsInfo.image] placeholderImage:[UIImage imageNamed:@"bg"]];
    self.productName.text = _goodsInfo.name;
    NSString* ptext = [NSString stringWithFormat:@"¥%.2f",_goodsInfo.price.floatValue];
    NSMutableAttributedString*muptext=[[NSMutableAttributedString alloc]initWithString:ptext];
    [muptext addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    [muptext addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(muptext.length-2, 2)];
    self.productPrice.attributedText=muptext;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.productImg];
        [self.contentView addSubview:self.productName];
        [self.contentView addSubview:self.productPrice];
        [self.contentView addSubview:self.lineView];
        [self.productImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@2);
            make.left.equalTo(@10);
            make.height.equalTo(@80);
            make.width.equalTo(@80);
        }];
        
        [self.productName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.left.equalTo(self.productImg.mas_right).with.offset(10);
            //make.height.equalTo(@40);
            make.right.equalTo(@(-20));
        }];
        [self.productPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-10));
            make.left.equalTo(self.productImg.mas_right).offset(15);
            //wmake.height.equalTo(@30);
            make.width.equalTo(@60);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@0.35);
            make.bottom.equalTo(@0);
        }];

    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//        
//        [self.contentView addSubview:self.productImg];
//        [self.contentView addSubview:self.productName];
//        [self.contentView addSubview:self.productPrice];
//        
//        [self.productImg mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@10);
//            make.left.equalTo(@15);
//            make.height.equalTo(@80);
//            make.width.equalTo(@80);
//        }];
//        
//        [self.productName mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@10);
//            make.left.equalTo(self.productImg.mas_right).with.offset(10);
//            make.height.equalTo(@40);
//            make.right.equalTo(self.productPrice.mas_left).with.offset(-10);
//        }];
//        [self.productPrice mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@10);
//            make.right.equalTo(@-10);
//            make.height.equalTo(@30);
//            make.width.equalTo(@60);
//        }];
//    }
//    return self;
//}
//

- (UIImageView *)productImg
{
    if (!_productImg) {
        _productImg =[[UIImageView alloc] init];
        _productImg.layer.masksToBounds = YES;
        _productImg.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _productImg;
}

- (UILabel *)productName
{
    if (!_productName) {
        _productName = [[UILabel alloc] init];
        _productName.backgroundColor = [UIColor clearColor];
        _productName.font = ADeanFONT14;
        _productName.numberOfLines = 2;
        _productName.textColor=AllTextColor;
        _productName.text = @"";
    }
    return _productName;
}
- (UILabel *)productPrice
{
    if (!_productPrice) {
        _productPrice = [[UILabel alloc] init];
        _productPrice.backgroundColor = [UIColor clearColor];
        _productPrice.numberOfLines=0;
        _productPrice.font = [UIFont systemFontOfSize:14.5];
        _productPrice.textColor = RGB(233, 40, 46);
        _productPrice.textAlignment = NSTextAlignmentLeft;
    }
    return _productPrice;
}


@end