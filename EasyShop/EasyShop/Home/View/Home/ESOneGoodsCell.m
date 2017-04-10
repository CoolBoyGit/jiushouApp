//
//  ESOneGoodsCell.m
//  EasyShop
//
//  Created by jiushou on 16/6/7.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESOneGoodsCell.h"
@interface ESOneGoodsCell()
@property (nonatomic, strong) UIImageView *imageView;     // 图片
@property (nonatomic, strong) UILabel *originPriceLabel;  // 原价
@property (nonatomic, strong) UILabel *priceLabel;        // 现价
@property (nonatomic, strong) UILabel *productTitleLabel; // 标题
@property (nonatomic,strong) UIImageView*soldoutImage;

@end
@implementation ESOneGoodsCell
-(void)setGoodsInfo:(GoodsInfo *)goodsInfo{
    _goodsInfo = goodsInfo;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_goodsInfo.image]
                      placeholderImage:[UIImage imageNamed:@"bg100"]];
    self.productTitleLabel.text=_goodsInfo.name;
    self.priceLabel.text=[NSString stringWithFormat:@"¥ %.2f",_goodsInfo.price.floatValue];
}
-(void)setIsHidden:(BOOL)isHidden{
    self.soldoutImage.hidden=isHidden;
}
-(UIImageView *)soldoutImage{
    if (_soldoutImage==nil) {
        _soldoutImage=[[UIImageView alloc]init];
        _soldoutImage.image=[UIImage imageNamed:@"soldout"];
        _soldoutImage.alpha=0.8;
        _soldoutImage.hidden=NO;
    }
    return _soldoutImage;
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
        _originPriceLabel.textColor = AllTextColor;
    }
    return _originPriceLabel;
}

- (UILabel *)productTitleLabel
{
    if (_productTitleLabel == nil) {
        _productTitleLabel = [[UILabel alloc] init];
        _productTitleLabel.text = @"Sk-11 神仙水 215毫升";
        _productTitleLabel.numberOfLines = 0;
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
        _priceLabel.textColor =RGB(233, 40, 46);
    }
    return _priceLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@207);
            make.top.left.equalTo(@00);
            make.height.equalTo(@230);
        }];
        [self.imageView addSubview:self.soldoutImage];
        [self.soldoutImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.bottom.equalTo(@-10);
            make.height.width.equalTo(@55);
        }];

        [self.contentView addSubview:self.productTitleLabel];
        [self.productTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView.mas_right).offset(5);
            make.right.equalTo(@(-5));
            make.height.equalTo(@70);
            make.top.equalTo(@30);
        }];
        
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView.mas_right).offset(5);
            make.height.equalTo(@44);
            make.width.equalTo(@100);
            make.bottom.equalTo(@(-30));
            
        }];
        
//        [self.contentView addSubview:self.originPriceLabel];
//        [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.priceLabel.mas_right).offset(5);
//             make.bottom.equalTo(@(-30));
//            make.right.equalTo(@(-5));
//            make.height.equalTo(@44);
//        }];
        //作用 设置文字居中
        NSUInteger length = [self.originPriceLabel.text length];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.originPriceLabel.text];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:ADeanHEXCOLOR(0x999999) range:NSMakeRange(2, length-2)];
        [self.originPriceLabel setAttributedText:attri];
        
    }
    return self;
}


@end
