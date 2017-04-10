//
//  ESCollectionShopCell.m
//  EasyShop
//
//  Created by wcz on 16/4/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESCollectionShopCell.h"

@interface ESCollectionShopCell ()

@property (nonatomic, strong) UIImageView *imageView;     // 图片
@property (nonatomic, strong) UILabel *originPriceLabel;  // 原价
@property (nonatomic, strong) UILabel *priceLabel;        // 现价
@property (nonatomic, strong) UILabel *productTitleLabel; // 标题
@property (nonatomic, strong) UIButton *deleteCollectButton;//删除按钮

@end

@implementation ESCollectionShopCell

- (void)setGoodsInfo:(FavoritesGoodsInfo *)goodsInfo
{
    _goodsInfo = goodsInfo;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_goodsInfo.goods_image]
                      placeholderImage:[UIImage imageNamed:@"bg100"]];
    self.originPriceLabel.text = @"";
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",_goodsInfo.goods_price];
    self.productTitleLabel.text = _goodsInfo.goods_name;
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
        _originPriceLabel.font = [UIFont systemFontOfSize:11];
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
        _productTitleLabel.font = [UIFont systemFontOfSize:11];
        _productTitleLabel.textColor = [UIColor blackColor];
    }
    return _productTitleLabel;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = @"¥270|";
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.textColor = [UIColor redColor];
    }
    return _priceLabel;
}

- (UIButton *)deleteCollectButton{
    if (_deleteCollectButton == nil) {
        _deleteCollectButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_deleteCollectButton setBackgroundColor:RGBA(153, 153, 153, 0.8)];
        //[_deleteCollectButton setBackgroundColor:[UIColor lightGrayColor]];
//        _deleteCollectButton.layer.borderWidth=0.3;
//        _deleteCollectButton.layer.borderColor=RGBA(153, 153, 153, 0.4).CGColor;
        [_deleteCollectButton setBackgroundImage:[UIImage imageNamed:@"delectButton"] forState:UIControlStateNormal];
//        _deleteCollectButton.layer.cornerRadius=10;
//        _deleteCollectButton.layer.masksToBounds=YES;
        
        [_deleteCollectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_deleteCollectButton addTarget:self action:@selector(deleteCollectionAtGoods_id) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteCollectButton;
}

//删除收藏
- (void)deleteCollectionAtGoods_id{
    if ([self.delegate respondsToSelector:@selector(deleteCollectionAtGoods_id:)]) {
        [self.delegate deleteCollectionAtGoods_id:self.goodsInfo.goods_id];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@00);
            make.height.equalTo(@((ScreenWidth-30)/2));
        }];
        
        [self.contentView addSubview:self.productTitleLabel];
        
        NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:self.productTitleLabel.text];
     
        [attri1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,6)];
        [self.productTitleLabel setAttributedText:attri1];
        [self.productTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@5);
            make.right.equalTo(@(-5));
            make.top.equalTo(self.imageView.mas_bottom).offset(0);
            //make.height.equalTo(@(40));
        }];
        
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.productTitleLabel.mas_bottom).offset(5);

        }];
        
        [self.contentView addSubview:self.originPriceLabel];
        [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_centerX).offset(2);
            make.top.equalTo(self.productTitleLabel.mas_bottom).offset(6);
        }];
        
        [self.contentView addSubview:self.deleteCollectButton];
        [self.deleteCollectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.right.equalTo(self.contentView.mas_right);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
//        NSUInteger length = [self.originPriceLabel.text length];
//        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.originPriceLabel.text];
//        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
//        [attri addAttribute:NSStrikethroughColorAttributeName value:ADeanHEXCOLOR(0x999999) range:NSMakeRange(2, length-2)];
//        [self.originPriceLabel setAttributedText:attri];
        
    }
    return self;
}

@end
