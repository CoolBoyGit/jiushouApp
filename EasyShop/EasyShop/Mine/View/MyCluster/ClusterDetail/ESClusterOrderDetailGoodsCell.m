//
//  ESTogeDetailGoodsCell.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterOrderDetailGoodsCell.h"
@interface ESClusterOrderDetailGoodsCell()
@property (nonatomic,strong)UIImageView*logoImageView;
@property (nonatomic,strong)UILabel*shopNameLabel;
@property (nonatomic,strong)UILabel*stauesLabel;
@property (nonatomic,strong)UIView*lineView;
@property (nonatomic,strong)UIView*bgView;//放置cell的
@property (nonatomic,strong)UIImageView*goodsImageVievw;
@property (nonatomic,strong)UILabel*goodsDetailLabel;//商品描述
@property (nonatomic,strong)UILabel*piceLabel;//商品单价
@property (nonatomic,strong)UILabel*countLabel;//商品数量
@property (nonatomic,strong)UIButton*seeDetailButton;//查看详情
@property (nonatomic,strong)UILabel*muchGoodsLabel;
@property (nonatomic,strong)UILabel*allMoneyLabel;//总价
@property (nonatomic,strong)UILabel*otherMoneyLabel;//运费
@property (nonatomic,strong)UIView*bottonLineView;
@property (nonatomic,assign) float all;
@property (nonatomic,strong) UILabel*oneLable;
@end
@implementation ESClusterOrderDetailGoodsCell
-(void)setClusterOrederRespone:(GetClusterOrderDetailRespone *)clusterOrederRespone{
    [self.goodsImageVievw sd_setImageWithURL:[NSURL URLWithString:clusterOrederRespone.goods_image] placeholderImage:[UIImage imageNamed:@"110.jpg"]];
    self.goodsDetailLabel.text=clusterOrederRespone.goods_name;
    self.shopNameLabel.text=clusterOrederRespone.shop_name;
    NSString*str=[[NSString alloc]init];
    if ([clusterOrederRespone.status isEqualToString:@"2"]) {
        str=@"正在拼团";
    }else if ([clusterOrederRespone.status isEqualToString:@"3"]&&clusterOrederRespone.clusterOrderStatus==ClusterOrderStatus_WaitSend){
        str=@"拼团成功,等待卖家发货";
    }else if (clusterOrederRespone.clusterOrderStatus==ClusterOrderStatus_WaitSure){
        str=@"拼团成功,待收货";
    }
    else if ([clusterOrederRespone.status isEqualToString:@"4"]&&[clusterOrederRespone.pay_status isEqualToString:@"3"]){
        str=@"未成团,退款中";
        
    }
    else if ([clusterOrederRespone.status isEqualToString:@"4"]&&[clusterOrederRespone.pay_status isEqualToString:@"4"]){
        str=@"未成团,退款成功";
    }
    NSString*pricStr=[NSString stringWithFormat:@"￥%@",clusterOrederRespone.cluster_price];
    self.piceLabel.text=pricStr;
    NSString*muchStr=[NSString stringWithFormat:@"共%@件商品",clusterOrederRespone.goods_num];
    NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc]initWithString:muchStr];
    [muStr addAttribute:NSForegroundColorAttributeName value:RGB(233, 40, 46) range:NSMakeRange(muchStr.length-4, 1)];
    self.muchGoodsLabel.attributedText=muStr;
    self.all=[clusterOrederRespone.goods_num intValue]*[clusterOrederRespone.cluster_price floatValue];
    NSString*allStr=[NSString stringWithFormat:@"合计:￥%.2f",self.all];
    NSMutableAttributedString*muaAllStr=[[NSMutableAttributedString alloc]initWithString:allStr];
    [muaAllStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:16.5]}  range:NSMakeRange(3, allStr.length-3)];
    [muaAllStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(3, 1)];
     [muaAllStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(muaAllStr.length-2,2)];
    self.allMoneyLabel.attributedText=muaAllStr;
    self.stauesLabel.text=str;
    
    
    
    
}
-(UIImageView *)logoImageView{
    if (_logoImageView==nil) {
        _logoImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"110.jpg"]];
        
    }
    return _logoImageView;
}
-(UILabel *)shopNameLabel{
    if (_shopNameLabel==nil) {
        _shopNameLabel=[[UILabel alloc]init];
        _shopNameLabel.font=[UIFont systemFontOfSize:14];
        _shopNameLabel.text=@"";
        _shopNameLabel.textColor=AllTextColor;
    }
    return _shopNameLabel;
}
-(UILabel *)stauesLabel{
    if (_stauesLabel==nil) {
        _stauesLabel=[[UILabel label]init];
        _stauesLabel.textAlignment=NSTextAlignmentRight;
        _stauesLabel.font=[UIFont systemFontOfSize:14];
        _stauesLabel.textColor=RGBA(233, 40, 46, 1);
        _stauesLabel.text=@"";
    }
    return _stauesLabel;
}
-(UILabel *)oneLable{
    if (_oneLable==nil) {
        _oneLable=[[UILabel alloc]init];
        _oneLable.text=@"x1";
        _oneLable.font=[UIFont systemFontOfSize:12];
        _oneLable.textColor=RGB(80, 80, 80);
    }
    return _oneLable;
}
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=RGB(220, 220, 220);
    }
    return _lineView;
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=RGB(241, 241, 241);
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBlockAction)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}
-(void)tapBlockAction{
    if (self.tapBlock) {
        self.tapBlock();
    }
}
-(UIImageView *)goodsImageVievw{
    if (_goodsImageVievw==nil) {
        _goodsImageVievw=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"110.jpg"]];
    }
    return _goodsImageVievw;
}
-(UILabel *)goodsDetailLabel{
    if (_goodsDetailLabel==nil) {
        _goodsDetailLabel=[[UILabel alloc]init];
        _goodsDetailLabel.numberOfLines=2;
        _goodsDetailLabel.font=[UIFont systemFontOfSize:14];
        _goodsDetailLabel.text=@"";
        _goodsDetailLabel.textColor=AllTextColor;
    }
    return _goodsDetailLabel;
}
-(UILabel *)piceLabel{
    if (_piceLabel==nil) {
        _piceLabel=[[UILabel label]init];
        _piceLabel.textColor=AllTextColor;
        _piceLabel.font=[UIFont systemFontOfSize:14];
        _piceLabel.textAlignment=NSTextAlignmentRight;
        _piceLabel.text=@"";
        
    }
    return _piceLabel;
}
-(UILabel *)countLabel{
    if (_countLabel==nil) {
        _countLabel=[[UILabel alloc]init];
        _countLabel.textAlignment=NSTextAlignmentRight;
        _countLabel.font=[UIFont systemFontOfSize:14];
        _countLabel.text=@"";
        _countLabel.textColor=AllTextColor;
        
    }
    return _countLabel;
}
-(UIButton *)seeDetailButton{
    if (_seeDetailButton==nil) {
        _seeDetailButton=[UIButton buttonWithType:UIButtonTypeSystem];
        [_seeDetailButton setTitle:@"查看团购详情" forState:UIControlStateNormal];
        _seeDetailButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_seeDetailButton addTarget: self action:@selector(seeDetailButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_seeDetailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _seeDetailButton.layer.borderColor=RGB(60, 60, 60).CGColor;
        _seeDetailButton.layer.borderWidth=0.5;
        _seeDetailButton.layer.cornerRadius=4;
        _seeDetailButton.layer.masksToBounds=YES;
    }
    return _seeDetailButton;
}
-(void)seeDetailButtonAction{
    if (self.seeButtonBlock) {
        self.seeButtonBlock();
    }
}
-(UILabel *)muchGoodsLabel{
    if (_muchGoodsLabel==nil) {
        _muchGoodsLabel=[[UILabel alloc]init];
        _muchGoodsLabel.textColor=AllTextColor;
        _muchGoodsLabel.font=[UIFont systemFontOfSize:13];
        _muchGoodsLabel.text=@"";
    }
    return _muchGoodsLabel;
}
-(UILabel *)allMoneyLabel{
    if (_allMoneyLabel==nil) {
        _allMoneyLabel=[[UILabel alloc]init];
        _allMoneyLabel.textColor=AllTextColor;
        _allMoneyLabel.font=[UIFont systemFontOfSize:13];
        _allMoneyLabel.text=@"";
        
    }
    return _allMoneyLabel;
}
-(UILabel *)otherMoneyLabel{
    if (_otherMoneyLabel==nil) {
        _otherMoneyLabel=[[UILabel alloc]init];
        _otherMoneyLabel.text=@"";
    }
    return _otherMoneyLabel;
}
-(UIView *)bottonLineView{
    if (_bottonLineView==nil) {
        _bottonLineView=[[UIView alloc]init];
        _bottonLineView.backgroundColor=RGB(247, 247, 247);
    }
    return _bottonLineView;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.all=0;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.logoImageView];
        [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@15);
            make.left.equalTo(@10);
            make.top .equalTo(@10);
            
        }];
        [self.contentView addSubview:self.shopNameLabel];
        [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.logoImageView.mas_right).offset(5);
            make.height.equalTo(@15);
            make.centerY.equalTo(self.logoImageView.mas_centerY).offset(0);
            
        }];
        [self.contentView addSubview:self.stauesLabel];
        [self.stauesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.centerY.equalTo(self.logoImageView.mas_centerY).offset(0);
            make.height.equalTo(self.shopNameLabel.mas_height);
            
        }];
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@105);
            make.top.equalTo(self.logoImageView.mas_bottom).offset(10);
            make.left.right.equalTo(@0);
        }];
        [self.bgView addSubview:self.goodsImageVievw];
        [self.goodsImageVievw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.height.width.equalTo(@75);
            make.top.equalTo(@15);
            
        }];
        [self.bgView addSubview:self.goodsDetailLabel];
        [self.goodsDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsImageVievw.mas_right).offset(5);
            make.right.equalTo(@(-80));
            make.top.equalTo(@20);
            
        }];
        [self.bgView addSubview:self.piceLabel];
        [self.piceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.right.equalTo(@(-15));
            
        }];
        [self.bgView addSubview:self.oneLable];
        [self.oneLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-15));
            make.top.equalTo(self.piceLabel.mas_bottom).offset(15);
        }];
        [self.bgView addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView.mas_bottom).offset(10);
            make.right.equalTo(@(-10));
            make.left.equalTo(self.goodsDetailLabel.mas_right).offset(5);
        }];
        [self.contentView addSubview:self.otherMoneyLabel];
        [self.otherMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@17);
            make.top.equalTo(self.bgView.mas_bottom).offset(10);
            make.right.equalTo(@(-10));
            
        }];
        [self.contentView addSubview:self.allMoneyLabel];
        [self.allMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.otherMoneyLabel.mas_left).offset(-4);
            make.height.equalTo(@17);
            make.top.equalTo(self.bgView.mas_bottom).offset(10);

        }];
        [self.contentView addSubview:self.muchGoodsLabel];
        [self.muchGoodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView.mas_bottom).offset(12);
            make.height.equalTo(@15);
            
            make.right.equalTo(self.allMoneyLabel.mas_left).offset(-4);
            
        }];
        [self.contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.left.right.equalTo(@0);
            make.top.equalTo(self.allMoneyLabel.mas_bottom).offset(10);
        }];
        [self.contentView addSubview:self.bottonLineView];
        [self.bottonLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.left.right.equalTo(@0);
            make.top.equalTo(self.lineView.mas_bottom).offset(0);
        }];
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
