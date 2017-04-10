//
//  ClusterCollectionCell.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/28.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ClusterCollectionCell.h"
@interface ClusterCollectionCell ()
@property (nonatomic,strong)UIImageView*goodsImageView;
@property (nonatomic,strong)UILabel*detailLabel;
@property (nonatomic,strong)UILabel*priceLabel;
@property (nonatomic,strong) UIView*bottomBgView;
@property (nonatomic,strong) UILabel*alonePriceLabel;
@property (nonatomic,strong) UIButton*goButton;
@property (nonatomic,strong) UILabel*clusterMemberLabel;
@property (nonatomic,strong) UIImageView*groupImageview;
@property (nonatomic,strong) UIImageView*soldoutImage;


@end
@implementation ClusterCollectionCell
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
-(void)setGoodsInfo:(GoodsInfo *)goodsInfo{
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsInfo.image] placeholderImage:[UIImage imageNamed:@"bg100"]];
    
    NSString*dStr=[NSString stringWithFormat:@"%@",goodsInfo.name];
    if ([dStr containsString:@"【"]) {
        NSRange range;
        range.location=[dStr rangeOfString:@"【"].location;
        range.length=[dStr rangeOfString:@"】"].location - range.location;
        NSMutableAttributedString*dmuStr=[[NSMutableAttributedString alloc]initWithString:dStr];
        [dmuStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46)} range:NSMakeRange(range.location, range.length+1)];
        self.detailLabel.attributedText=dmuStr;
    }else{
        self.detailLabel.text=dStr;
    }
   
    NSString*gStr=[NSString stringWithFormat:@"%@人团",goodsInfo.cluster_member];
    self.alonePriceLabel.text=[NSString stringWithFormat:@"单买价￥%@",goodsInfo.price];
    NSString*str=[NSString stringWithFormat:@"%@人团  ￥%@",goodsInfo.cluster_member,goodsInfo.cluster_price];
    NSMutableAttributedString*mabStr=[[NSMutableAttributedString alloc]initWithString:str];
    [mabStr addAttribute:NSForegroundColorAttributeName value:RGB(70, 70, 70) range:NSMakeRange(0, gStr.length)];
    [mabStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(gStr.length+3, str.length-gStr.length-3)];
    [mabStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(str.length-2, 2)];
    self.priceLabel.attributedText=mabStr;

}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.centerX.equalTo(self.contentView.mas_centerX).offset(0);
            make.width.height.equalTo(@(ScreenWidth*0.35));
            
        }];
        [self.goodsImageView addSubview:self.soldoutImage];
        [self.soldoutImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.bottom.equalTo(@-10);
            make.height.width.equalTo(@55);
        }];
        [self.contentView addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.goodsImageView.mas_bottom).offset(12);
            make.right.equalTo(@(-10));
            make.left.equalTo(@10);
        }];
        [self.contentView addSubview:self.bottomBgView];
        [self.bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.left.bottom.right.equalTo(@0);
        }];
        [self.contentView addSubview:self.groupImageview];
        [self.groupImageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.bottom.equalTo(@-30);
            make.width.height.equalTo(@15);
        }];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.groupImageview.mas_right).offset(5);
            make.bottom.equalTo(@-30);
            
        }];
        [self.contentView addSubview:self.alonePriceLabel];
        [self.alonePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.priceLabel.mas_right).offset(10);
            make.bottom.equalTo(@(-30));
           
        }];
        [self.contentView addSubview:self.goButton];
        [self.goButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-30));
            make.height.equalTo(@30);
            make.width.equalTo(@80);
            make.right.equalTo(@(-10));
        }];
    }
    return self;
}
-(UIImageView *)groupImageview{
    if (_groupImageview==nil) {
        _groupImageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"group"]];
    }
    return _groupImageview;
}
-(UILabel *)clusterMemberLabel{
    if (_clusterMemberLabel==nil) {
        _clusterMemberLabel=[[UILabel alloc]init];
        _clusterMemberLabel.font=[UIFont systemFontOfSize:14];
        _clusterMemberLabel.textColor=RGBA(233, 40, 46, 1);
    }
    return _clusterMemberLabel;
}
-(UIButton *)goButton{
    if (_goButton==nil) {
        _goButton=[[UIButton alloc]init];
        [_goButton setTitle:@"去开团" forState:UIControlStateNormal];
        [_goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _goButton.layer.cornerRadius=4;
        _goButton.layer.masksToBounds=YES;
        [_goButton addTarget:self action:@selector(goButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _goButton.titleLabel.font=[UIFont systemFontOfSize:15];
        _goButton.backgroundColor=RGB(233, 40, 46);
    }
    return _goButton;
}
-(void)goButtonAction{
    if (self.goButtonBlock) {
        self.goButtonBlock();
    }
}
-(UILabel *)alonePriceLabel{
    if (_alonePriceLabel==nil) {
        
        _alonePriceLabel=[[UILabel alloc]init];
        _alonePriceLabel.font=[UIFont systemFontOfSize:12];
        _alonePriceLabel.textColor=RGB(100, 100, 100);
        
    }
    return _alonePriceLabel;
}
-(UIView *)bottomBgView{
    if (_bottomBgView==nil) {
        _bottomBgView=[[UIView alloc]init];
        
        _bottomBgView.backgroundColor=RGB(247, 247, 247);
    }
    return _bottomBgView;
}
-(UIImageView *)goodsImageView{
    if (_goodsImageView==nil) {
        _goodsImageView=[[UIImageView alloc]init];
        
    }
    return _goodsImageView;
}
-(UILabel *)detailLabel{
    if (_detailLabel==nil) {
        _detailLabel=[[UILabel alloc]init];
        _detailLabel.numberOfLines=1;
        _detailLabel.textColor=AllTextColor;
        _detailLabel.font=[UIFont systemFontOfSize:14];
        _detailLabel.text=@"昨夜西风凋碧树，独上高楼，望尽天涯路,衣带渐宽终不悔，为伊消得人憔悴";
    }
    return _detailLabel;
}
-(UILabel *)priceLabel{
    if (_priceLabel==nil) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.text=@"100";
        
        _priceLabel.font=[UIFont systemFontOfSize:12];
        _priceLabel.textColor=RGBA(233, 40, 46, 1);
    }
    return _priceLabel;
}

@end
