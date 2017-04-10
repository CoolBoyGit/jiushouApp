//
//  ESToGoodsDeCell.m
//  EasyShop
//
//  Created by jiushou on 16/10/10.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClsterPayGoodsDeCell.h"
@interface ESClsterPayGoodsDeCell()
@property (nonatomic,strong) UIImageView*goodsImageView;
@property (nonatomic,strong) UILabel*descritionLabel;
@property (nonatomic,strong) UILabel*priceLabel;
@property (nonatomic,strong) UIView *bgView;

@end
@implementation ESClsterPayGoodsDeCell
-(void)setSimpleGoodsRespone:(GetSimpGoodsRespone *)simpleGoodsRespone{
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:simpleGoodsRespone.image] placeholderImage:[UIImage imageNamed:@"110.jpg"]];
    self.descritionLabel.text=simpleGoodsRespone.name;
    self.priceLabel.text=[NSString stringWithFormat:@"￥ %@/件",simpleGoodsRespone.cluster_price];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.bgView];
        self.selectionStyle=UITableViewCellSelectionStyleNone;

        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.left.equalTo(@10);
            make.top.bottom.equalTo(@0);
        }];
        [self.bgView addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@5);
            make.left.equalTo(@3);
            make.bottom.equalTo(@(-5));
            make.width.equalTo(@90);
        }];
        [self.bgView addSubview:self.descritionLabel];
        [self.descritionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsImageView.mas_right).offset(10);
            make.top.equalTo(@10);
            make.right.equalTo(@(-10));
            
        }];
        [self.bgView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.goodsImageView.mas_right).offset(10);
            make.bottom.equalTo(@(-10));
            make.width.equalTo(@100);
        }];
    }
    return self;
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=RGBA(240, 240, 240, 1);
        
    }
    return _bgView;
}
-(UIImageView *)goodsImageView{
    if (_goodsImageView==nil) {
        _goodsImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"110.jpg"]];
        
    }
    return _goodsImageView;
    
}
-(UILabel *)descritionLabel{
    if (_descritionLabel==nil) {
        _descritionLabel=[[UILabel alloc]init];
        _descritionLabel.numberOfLines=2;
        _descritionLabel.textColor=AllTextColor;
        
        _descritionLabel.font=[UIFont systemFontOfSize:14];
        _descritionLabel.text=@"此路是我开,此树是我载,要从此路过,留下一蚊街,英雄莫问出处,昨夜西风凋碧树,独上高楼,望尽天涯路.衣带渐宽终不悔,为伊消得人憔悴";
        
    }
    return _descritionLabel;
}
-(UILabel *)priceLabel{
    if (_priceLabel==nil) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.text=@"";
        _priceLabel.textColor=RGB(90, 90, 90);
        _priceLabel.font=[UIFont systemFontOfSize:14];
    }
    return _priceLabel;
}
@end
