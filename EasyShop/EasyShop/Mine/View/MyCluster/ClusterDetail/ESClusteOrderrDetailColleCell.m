
//
//  ESTogeDetailCollectionCell.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusteOrderrDetailColleCell.h"
@interface ESClusteOrderrDetailColleCell()
@property (nonatomic,strong)UIImageView*goodsImageView;
@property (nonatomic,strong)UILabel*detailLabel;
@property (nonatomic,strong)UILabel*priceLabel;
@end

@implementation ESClusteOrderrDetailColleCell
-(void)setInfo:(GoodsInfo *)info{
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:info.image] placeholderImage:[UIImage imageNamed:@"bg100"]];
    self.detailLabel.text=info.name;
    self.priceLabel.text=info.price;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.goodsImageView];
        
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right.equalTo(@0);
            make.height.equalTo(self.mas_width).offset(0);
            
        }];
        [self.contentView addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.top.equalTo(self.goodsImageView.mas_bottom).offset(2);
            make.left.equalTo(@5);
            make.right.equalTo(@(-5));
        }];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsImageView.mas_left).offset(5);
            make.width.equalTo(@80);
            make.height.equalTo(@10);
            make.top.equalTo(self.detailLabel.mas_bottom).offset(3);
        }];
    }
    return self;
}

-(UIImageView *)goodsImageView{
    if (_goodsImageView==nil) {
        _goodsImageView=[[UIImageView alloc]init];
        _goodsImageView.image=[UIImage imageNamed:@"110.jpg"];
    }
    return _goodsImageView;
}
-(UILabel *)detailLabel{
    if (_detailLabel==nil) {
        _detailLabel=[[UILabel alloc]init];
        _detailLabel.numberOfLines=2;
        _detailLabel.font=[UIFont systemFontOfSize:12];
        _detailLabel.text=@"昨夜西风凋碧树，独上高楼，望尽天涯路,衣带渐宽终不悔，为伊消得人憔悴";
    }
    return _detailLabel;
}
-(UILabel *)priceLabel{
    if (_priceLabel==nil) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.text=@"100";
        
        _priceLabel.font=[UIFont systemFontOfSize:13];
        _priceLabel.textColor=[UIColor redColor];
    }
    return _priceLabel;
}

@end




