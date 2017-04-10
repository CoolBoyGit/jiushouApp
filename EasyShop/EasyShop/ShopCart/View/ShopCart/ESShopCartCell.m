//
//  ShopCartCell.m
//  MFBank
//
//  Created by YANQI on 15/11/4.
//  Copyright © 2015年 MFBank. All rights reserved.
//

#import "ESShopCartCell.h"
#import "ESService.h"

@interface ESShopCartCell()

@property (nonatomic, strong) UIView                    *bgView;
@property (nonatomic, strong) UIImageView               *productImg;//商品的图像
@property (nonatomic, strong) UILabel                   *productName;//商品的名称
@property (nonatomic, strong) UILabel                   *productPrice;//商品的价格

@property (nonatomic, strong) UIButton                      *addBtn;
@property (nonatomic, strong) UIButton                      *minuBtn;
@property (nonatomic, strong) UILabel                       *countLabel;//商品的数目
@property (nonatomic, assign) int                            selelctNum;
@property (nonatomic,strong) UIView *lineView;
@end

@implementation ESShopCartCell
-(void)setIsHidden:(BOOL)isHidden{
    self.lineView.hidden=isHidden;
}
- (void)setGoodsInfo:(CartGoodsInfo *)goodsInfo
{
    _goodsInfo = goodsInfo;
    
    self.selectBtn.selected = _goodsInfo.status.integerValue;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:_goodsInfo.goods_image] placeholderImage:[UIImage imageNamed:@"bg"]];
    self.productName.text = _goodsInfo.goods_name;
    NSString*priceText = [NSString stringWithFormat:@"¥%.2f",_goodsInfo.goods_price.floatValue];
    NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc]initWithString:priceText];
    [muStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 1)];
    [muStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(priceText.length-2, 2)];
    self.productPrice.attributedText=muStr;
    self.countLabel.text = [NSString stringWithFormat:@"%@",_goodsInfo.goods_num];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
        self.selelctNum = 1;
        self.lineView.hidden=YES;
    }
    return self;
}

- (void)setupViews
{
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@3);
        make.left.right.bottom.equalTo(@0);
    }];
    [self.bgView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@10);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];

    [self.bgView addSubview:self.productImg];
    [self.productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(self.selectBtn.mas_right).with.offset(10);
        make.height.equalTo(@80);
        make.width.equalTo(@80);
    }];
    [self.bgView addSubview:self.productName];
    [self.productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(self.productImg.mas_right).with.offset(10);
        make.height.equalTo(@40);
        make.right.equalTo(@(-10));
    }];

    [self.bgView addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@65);
        make.right.equalTo(@(-10));
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];
    [self.bgView addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.addBtn.mas_centerY).offset(0);
        make.right.equalTo(self.addBtn.mas_left).with.offset(-5);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];
    [self.bgView addSubview:self.minuBtn];
    [self.minuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@65);
        make.right.equalTo(self.countLabel.mas_left).with.offset(-5);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];
    [self.bgView addSubview:self.productPrice];
    [self.productPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.minuBtn.mas_centerY).offset(0);
        make.left.equalTo(self.productImg.mas_right).offset(10);
        make.height.equalTo(@30);
        
    }];
    [self.bgView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];

}


#pragma mark view init
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=RGB(210, 210, 210);
        
        
    }
    return _lineView;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=RGBA(247, 247, 247, 0.5);
    }
    return _bgView;
}
- (UIImageView *)productImg
{
    if (!_productImg) {
        _productImg =[[UIImageView alloc] init];
        _productImg.layer.masksToBounds = YES;
        _productImg.contentMode = UIViewContentModeScaleAspectFit;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToDetailVc)];
        
        [_productImg addGestureRecognizer:tap];
        _productImg.userInteractionEnabled=YES;
        
    }
    return _productImg;
}
-(void)tapToDetailVc{
    if (self.tapToDetail) {
        self.tapToDetail();
    }
}
- (UILabel *)productName
{
    if (!_productName) {
        _productName = [[UILabel alloc] init];
        _productName.backgroundColor = [UIColor clearColor];
        _productName.font = ADeanFONT14;
        _productName.numberOfLines = 2;
        _productName.textColor=RGB(70, 70, 70);
        _productName.textAlignment=NSTextAlignmentLeft;
        _productName.text = @"小黄瓜爽肤水  200M 999元";
           }
    return _productName;
}
- (UILabel *)productPrice
{
    if (!_productPrice) {
        _productPrice = [[UILabel alloc] init];
        _productPrice.backgroundColor = [UIColor clearColor];
        _productPrice.font = ADeanFONT17;
        _productPrice.text = @"¥999.00";
        _productPrice.textColor = RGB(233, 40, 46);
        _productPrice.textAlignment = NSTextAlignmentRight;
            }
    return _productPrice;
}

- (UIButton *)addBtn
{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.backgroundColor = [UIColor whiteColor];
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        [_addBtn setTitleColor:RGBA(233, 40, 46, 1) forState:UIControlStateNormal];
        _addBtn.titleLabel.font=[UIFont systemFontOfSize:18];
        [_addBtn addTarget:self action:@selector(addCountAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addBtn;
}

- (UIButton *)minuBtn
{
    if (!_minuBtn) {
        _minuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _minuBtn.backgroundColor = [UIColor whiteColor];
        [_minuBtn setTitle:@"-" forState:UIControlStateNormal];
        [_minuBtn setTitleColor:RGBA(233, 40, 46, 1) forState:UIControlStateNormal];
        _addBtn.titleLabel.font=[UIFont systemFontOfSize:18];
        [_minuBtn addTarget:self action:@selector(minuCountAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _minuBtn;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = RGB(233, 40, 46);
        _countLabel.font = ADeanFONT18;
        _countLabel.backgroundColor=[UIColor whiteColor];
        _countLabel.textAlignment = NSTextAlignmentCenter;
            }
    return _countLabel;
}
- (UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectBtn setBackgroundColor:[UIColor clearColor]];
        [_selectBtn setImage:[UIImage imageNamed:@"shopcart_unselect_icon"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"shopcart_selected_icon"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectBtnAction) forControlEvents:UIControlEventTouchUpInside];
            }
    return _selectBtn;
}

- (void)selectBtnAction
{
    _selectBtn.selected = !_selectBtn.selected;
    if (self.selectedBlock) {
        self.selectedBlock(0);
    }
}
-(void)addCountAction
{
    if (self.goodsInfo.enableSale) {
        if (self.operateBlock) {
            self.operateBlock(YES);
        }
    }
    
}
-(void)minuCountAction
{
    if (self.goodsInfo.enableSale) {
        NSInteger num = self.goodsInfo.goods_num.integerValue;
        if (num > 1 && self.operateBlock) {
            self.operateBlock(NO);
        }
    }
}

@end
