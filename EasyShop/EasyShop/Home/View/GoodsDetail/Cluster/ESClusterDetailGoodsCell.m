//
//  ESJionGoodsCollectionCell.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/18.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterDetailGoodsCell.h"//这个存放的是表尾的九宫格商品列表
@interface ESClusterDetailGoodsCell()
@property (nonatomic,strong)UIImageView*goodsImageView;
@property (nonatomic,strong)UILabel*detailLabel;
@property (nonatomic,strong)UILabel*priceLabel;
@end
@implementation ESClusterDetailGoodsCell
-(void)setGoodInfo:(GoodsInfo *)goodInfo{
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodInfo.image] placeholderImage:[UIImage imageNamed:@"bg100"]];
    self.detailLabel.text=goodInfo.name;
    NSString*str=[NSString stringWithFormat:@"¥%@",goodInfo.price];
    NSMutableAttributedString*mustr=[[NSMutableAttributedString alloc]initWithString:str];
    [mustr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.5] range:NSMakeRange(1, str.length-1)];
    [mustr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(str.length-2, 2)];
    self.priceLabel.attributedText=mustr;
    
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
            //make.height.equalTo(@30);
            make.top.equalTo(self.goodsImageView.mas_bottom).offset(0);
            make.left.equalTo(@5);
            make.right.equalTo(@(-5));
        }];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsImageView.mas_left).offset(5);
            make.top.equalTo(self.detailLabel.mas_bottom).offset(5);
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
        _detailLabel.textColor=AllTextColor;
        _detailLabel.font=[UIFont systemFontOfSize:13];
        _detailLabel.text=@"昨夜西风凋碧树，独上高楼，望尽天涯路,衣带渐宽终不悔，为伊消得人憔悴";
    }
    return _detailLabel;
}
-(UILabel *)priceLabel{
    if (_priceLabel==nil) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.text=@"100";
        
        _priceLabel.font=[UIFont systemFontOfSize:12];
        _priceLabel.textColor=RGB(233, 40, 46);
    }
    return _priceLabel;
}
@end
