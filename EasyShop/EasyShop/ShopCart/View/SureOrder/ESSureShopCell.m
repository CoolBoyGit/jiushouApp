//
//  ShopCartCell.m
//  MFBank
//
//  Created by YANQI on 15/11/4.
//  Copyright © 2015年 MFBank. All rights reserved.
//

#import "ESSureShopCell.h"


@interface ESSureShopCell()

@property (nonatomic, strong) UIButton                  *selectBtn;//打勾
@property (nonatomic, strong) UIImageView               *productImg;//商品的图像
@property (nonatomic, strong) UILabel                   *productName;//商品的名称
@property (nonatomic, strong) UILabel                   *productPrice;//商品的价格
@property (nonatomic, strong) UILabel                   *productFreight;//商品的运费
@property (nonatomic, strong) UILabel                   *productNum;//商品的数量
@property (nonatomic,strong) UIView *lineView;
@end

@implementation ESSureShopCell
-(UIView*)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        //_lineView.backgroundColor=[UIColor blackColor];
        _lineView.backgroundColor=RGB(170, 170, 170);
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(@0);
            make.height.equalTo(@0.35);
        }];
        
    }
    return _lineView;
}
- (void)setGoodsInfo:(OrderConfirmGoodsInfo *)goodsInfo
{
    _goodsInfo = goodsInfo;
    
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:_goodsInfo.goods_image] placeholderImage:[UIImage imageNamed:@"bg"]];
    self.productName.text = _goodsInfo.goods_name;
    self.productPrice.text = [NSString stringWithFormat:@"¥%.2f",_goodsInfo.goods_price.floatValue];
    self.productNum.text = [NSString stringWithFormat:@"x%@",_goodsInfo.goods_num];
//    self.productFreight.text = _goodsInfo.
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.lineView.alpha=1.0f;
    self.selectBtn.alpha = 1.0f;
    self.productImg.image = [UIImage imageNamed:@"bg"];
    self.productImg.backgroundColor = [UIColor clearColor];
    self.productName.alpha = 1.0f;
    self.productPrice.alpha = 1.0f;
    self.productNum.alpha = 1.0f;
}

#pragma mark view init
- (UIImageView *)productImg
{
    if (!_productImg) {
        _productImg =[[UIImageView alloc] init];
        _productImg.layer.masksToBounds = YES;
        _productImg.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_productImg];
        [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.left.equalTo(@20);
            make.height.equalTo(@80);
            make.width.equalTo(@80);
        }];
    }
    return _productImg;
}

- (UILabel *)productName
{
    if (!_productName) {
        _productName = [[UILabel alloc] init];
        _productName.backgroundColor = [UIColor clearColor];
        _productName.font = ADeanFONT14;
        _productName.textColor=AllTextColor;
        _productName.numberOfLines =3;
        _productName.text = @"小黄瓜爽肤水  200M 999元";
        [self.contentView addSubview:_productName];
        [_productName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.left.equalTo(self.productImg.mas_right).with.offset(5);
            make.right.equalTo(@-80);
        }];
    }
    return _productName;
}
- (UILabel *)productFreight
{
    if (!_productFreight) {
        _productFreight = [[UILabel alloc] init];
        _productFreight.backgroundColor = [UIColor clearColor];
        _productFreight.font = ADeanFONT14;
        _productFreight.text = @"邮费：0";
        _productFreight.textColor=AllTextColor;
        _productFreight.textAlignment = NSTextAlignmentRight;
//        [self.contentView addSubview:_productFreight];
//        [_productFreight mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.productImg.mas_top).with.offset(20);
//            make.left.equalTo(self.productImg.mas_right).with.offset(5);
//            make.height.equalTo(@20);
//            make.right.equalTo(@(-20));
//        }];
    }
    return _productFreight;
}
- (UILabel *)productNum
{
    if (!_productNum) {
        _productNum = [[UILabel alloc] init];
        _productNum.backgroundColor = [UIColor clearColor];
        _productNum.font = ADeanFONT12;
        _productNum.text = @"x1";
        _productNum.textColor = RGB(90, 90, 90);
        _productNum.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_productNum];
        [_productNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.productPrice.mas_bottom).with.offset(10);
            make.right.equalTo(@(-15));
        }];
    }
    return _productNum;
}
- (UILabel *)productPrice
{
    if (!_productPrice) {
        _productPrice = [[UILabel alloc] init];
        _productPrice.backgroundColor = [UIColor clearColor];
        _productPrice.font = ADeanFONT14;
        _productPrice.text = @"¥999.00";
        _productPrice.textColor = AllTextColor;
        _productPrice.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_productPrice];
        [_productPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.width.equalTo(@100);
            make.right.equalTo(@(-15));
        }];
    }
    return _productPrice;
}
- (UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectBtn setBackgroundColor:[UIColor clearColor]];
        [_selectBtn setImage:[UIImage imageNamed:@"shopcart_selected_icon"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"shopcart_selected_icon"] forState:UIControlStateSelected];
//        [_selectBtn addTarget:self action:@selector(selectBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_selectBtn];
//        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(@0);
//            make.left.equalTo(@10);
//            make.height.equalTo(@30);
//            make.width.equalTo(@30);
//        }];
    }
    return _selectBtn;
}
//- (void)selectBtnAction
//{
//    NSLog(@"123");
//    _selectBtn.selected = !_selectBtn.selected;
//}

@end

