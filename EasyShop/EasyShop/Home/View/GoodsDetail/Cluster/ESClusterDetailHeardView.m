//
//  ESJoinListHeardView.m
//  EasyShop
//在点击我要参团跳转的页面的头部视图
//  Created by jiushou on 16/10/12.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterDetailHeardView.h"
@interface ESClusterDetailHeardView()
@property (nonatomic,strong)UILabel*introduceLabel;
@property (nonatomic,strong)UIImageView*goodsImageView;
@property (nonatomic,strong)UILabel*priceLabel;
@property (nonatomic,strong)UILabel*clusterMemberLabel;
@property (nonatomic,strong)UIView*lineView;
@property (nonatomic,strong) UIImageView*tipsImageView;
@end
@implementation ESClusterDetailHeardView
-(void)setDetailInfo:(GetClusterDetailRespone *)detailInfo{
    self.introduceLabel.text=detailInfo.goods_name;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:detailInfo.goods_image] placeholderImage:[UIImage imageNamed:@"110.jpg"]];
    self.clusterMemberLabel.text=[NSString stringWithFormat:@"%@人团:",detailInfo.s_num];
    NSString*str=[NSString stringWithFormat:@"￥%@",detailInfo.goods_price];
    
    NSMutableAttributedString*mabStr=[[NSMutableAttributedString alloc]initWithString:str];
    
    [mabStr addAttribute:NSForegroundColorAttributeName value:RGB(233, 40, 46) range:NSMakeRange(1, str.length-1)];
    [mabStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(1, str.length-1)];
    [mabStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(str.length-2, 2)];
    self.priceLabel.attributedText=mabStr;
    if ([detailInfo.status isEqualToString:@"2"]) {
        self.tipsImageView.image=[UIImage imageNamed:@"clusterDetailprocess"];
    }else if ([detailInfo.status isEqualToString:@"3"]){
        self.tipsImageView.image=[UIImage imageNamed:@"clusterDetailsucce"];
        
    }else if ([detailInfo.status isEqualToString:@"4"]){
        self.tipsImageView.image=[UIImage imageNamed:@"clusterDetailFail"];
        
    }
    
    
    
    
}
-(UIImageView *)tipsImageView{
    if (_tipsImageView==nil) {
        _tipsImageView=[[UIImageView alloc]init];
        
    }
    return _tipsImageView;
}

-(UILabel *)clusterMemberLabel{
    if (_clusterMemberLabel==nil) {
        _clusterMemberLabel=[[UILabel alloc]init];
        _clusterMemberLabel.font=[UIFont systemFontOfSize:12];
        _clusterMemberLabel.textAlignment=NSTextAlignmentLeft;
        _clusterMemberLabel.textColor=AllTextColor;
        _clusterMemberLabel.baselineAdjustment=UIBaselineAdjustmentNone;
        
    }
    return _clusterMemberLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.bottom.equalTo(@(-15));
            make.left.equalTo(@10);
            make.width.equalTo(@90);
        }];
        [self addSubview:self.introduceLabel];
        [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsImageView.mas_right).offset(10);
            make.right.equalTo(@(-15));
            make.top.equalTo(@25);
        }];
        [self addSubview:self.clusterMemberLabel];
        [self.clusterMemberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsImageView.mas_right).offset(10);
            make.bottom.equalTo(@(-28));
            
        }];
        [self addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.clusterMemberLabel.mas_right).offset(10);
            make.bottom.equalTo(@(-25));
            make.right.equalTo(@0);
            //make.height.equalTo(@20);
        }];
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.right.left.bottom.equalTo(@0);
            
        }];
        [self addSubview:self.tipsImageView];
        [self.tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.right.equalTo(@(-30));
            make.width.height.equalTo(@90);
        }];
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)tapAction{
    if (self.tapBlock) {
        self.tapBlock();
    }
}
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=RGB(240, 240, 240);
        
    }
    return _lineView;
}
-(UILabel *)introduceLabel{
    if (_introduceLabel==nil) {
        _introduceLabel=[[UILabel alloc]init];
        _introduceLabel.numberOfLines=2;
        _introduceLabel.textColor=AllTextColor;
        _introduceLabel.font=[UIFont systemFontOfSize:14];
        _introduceLabel.text=@"你会相信一个畏缩胆小的男生在这个时候，能够挺身而出，以强硬而蛮横的姿态挡在被全世界抛弃的那个女孩面前吗？";
    }
    return _introduceLabel;
}
-(UIImageView *)goodsImageView{
    if (_goodsImageView==nil) {
        _goodsImageView=[[UIImageView alloc]init];
        _goodsImageView.image=[UIImage imageNamed:@"110.jpg"];
    }
    return _goodsImageView;
}
-(UILabel *)priceLabel{
    if (_priceLabel==nil) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.textColor=RGBA(233, 42, 40, 1);
        _priceLabel.font=[UIFont systemFontOfSize:11];
        _priceLabel.baselineAdjustment=UIBaselineAdjustmentNone;
        
        _priceLabel.text=@"2人团: $16.5/件";
    }
    return _priceLabel;
}
@end
