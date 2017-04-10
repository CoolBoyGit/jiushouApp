//
//  ESTogetherHeardView.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterOrderDetailHeardView.h"
@interface ESClusterOrderDetailHeardView()
@property (nonatomic,strong)UIImageView*tipsImageView;
@property (nonatomic,strong)UIImageView*addressImageView;
@property (nonatomic,strong)UILabel*nameLabel;
@property (nonatomic,strong)UILabel*phoneLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UIView*bottomLineView;
@property (nonatomic,strong)UIView*bgView;
@property (nonatomic,strong) UIView*whitheView;
@property (nonatomic,strong) UILabel*tipsLabel;
@property (nonatomic,strong) UILabel*persionLabel;

@end
@implementation ESClusterOrderDetailHeardView
-(void)setClusterOrederRespone:(GetClusterOrderDetailRespone *)clusterOrederRespone{
    self.nameLabel.text= [NSString stringWithFormat:@"收件人: %@",clusterOrederRespone.name];
    self.phoneLabel.text=[NSString stringWithFormat:@"%@",[clusterOrederRespone.mobile stringByReplacingCharactersInRange:NSMakeRange(4, 3) withString:@"***"]];
    NSString*addStr=[NSString stringWithFormat:@"%@",clusterOrederRespone.address];
    NSAttributedString*astr=[addStr ParaStyleheightOfLineSpacing:5 andFont:[UIFont systemFontOfSize:14]];
    self.addressLabel.attributedText=astr;

self.persionLabel.text=[NSString stringWithFormat:@"身份证: %@",[clusterOrederRespone.personid stringByReplacingCharactersInRange:NSMakeRange(4, 9) withString:@"*********"]];
    NSString*str=[[NSString alloc]init];
    if ([clusterOrederRespone.status isEqualToString:@"2"]) {
        str=[NSString stringWithFormat:@"%@\n%@",@"正在拼团",@"邀请小伙伴来拼团把~~"];
        //str=@"正在拼团\n邀请小伙伴来拼团把~~";
    }else if ([clusterOrederRespone.status isEqualToString:@"3"]&&clusterOrederRespone.clusterOrderStatus==ClusterOrderStatus_WaitSend){
        str=[NSString stringWithFormat:@"%@\n%@",@"拼团成功",@"等待卖家发货"];
    }else if (clusterOrederRespone.clusterOrderStatus==ClusterOrderStatus_WaitSure){
        str=[NSString stringWithFormat:@"%@\n%@",@"拼团成功",@"等待卖家发货"];
        str=@"拼团成功,待收货";
    }
    else if ([clusterOrederRespone.status isEqualToString:@"4"]&&[clusterOrederRespone.pay_status isEqualToString:@"3"]){
        str=[NSString stringWithFormat:@"%@\n%@",@"未成团",@"退款中"];
        
        
    }
    else if ([clusterOrederRespone.status isEqualToString:@"4"]&&[clusterOrederRespone.pay_status isEqualToString:@"4"]){
        str=[NSString stringWithFormat:@"%@\n%@",@"未成团",@"退款成功"];
        
    }else if ([clusterOrederRespone.status isEqualToString:@"4"]&&[clusterOrederRespone.pay_status isEqualToString:@"5"]){
        str=[NSString stringWithFormat:@"%@\n%@",@"未成团,退款失败",@"具体请致电15088132593和客服联系"];
        
    }
    self.tipsLabel.text=str;

}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.tipsImageView];
        [self.tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(ScreenWidth *(205/617.0)));
            make.left.right.equalTo(@0);
            make.top.equalTo(@0);
            
        }];
        [self.tipsImageView addSubview:self.tipsLabel];
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.tipsImageView.mas_centerY).offset(0);
            make.left.equalTo(@30);
            make.right.equalTo(@(-80));
        }];
        [self addSubview:self.whitheView];
        [self.whitheView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-10));
            make.top.equalTo(self.tipsImageView.mas_bottom).offset(0);
            make.left.right.equalTo(@0);
        }];
        [self.whitheView addSubview: self.addressImageView];
        [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.width.height.equalTo(@25);
            make.centerY.equalTo(self.whitheView.mas_centerY).offset(0);
            
        }];
        [self.whitheView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.left.equalTo(@43);
            make.width.equalTo(@150);
            make.top.equalTo(self.tipsImageView.mas_bottom).offset(15);
        }];
        [self.whitheView addSubview: self.phoneLabel];
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).offset(30);
            make.centerY.equalTo(self.nameLabel.mas_centerY).offset(0);
            make.right.equalTo(@0);
        }];
        [self.whitheView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_left).offset(0);
            make.right.equalTo(@(-40));
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        }];
        [self.whitheView addSubview:self.persionLabel];
        [self.persionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.addressLabel.mas_bottom).offset(10);
             make.left.equalTo(self.nameLabel.mas_left).offset(0);
            
        }];
        [self.whitheView addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.left.right.equalTo(@0);
            make.top.equalTo(self.persionLabel.mas_bottom).offset(10);
        }];
        [self.whitheView addSubview:self.bottomLineView];
        [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.left.right.equalTo(@0);
            make.bottom.equalTo(self.bgView.mas_top).offset(0);
            
            
        }];

    }
    return self;
}
-(UIView *)whitheView{
    if (_whitheView==nil) {
        _whitheView=[[UIView alloc]init];
        _whitheView.backgroundColor=[UIColor whiteColor];
        
    }
    return _whitheView;
}
-(UILabel *)persionLabel{
    if (_persionLabel==nil) {
        _persionLabel=[[UILabel alloc]init];
        _persionLabel.font=[UIFont systemFontOfSize:14];
        _persionLabel.textColor=AllTextColor;
    }
    return _persionLabel;
}
-(UILabel *)tipsLabel{
    if (_tipsLabel==nil) {
        _tipsLabel=[[UILabel alloc]init];
        _tipsLabel.textColor=[UIColor whiteColor];
        _tipsLabel.numberOfLines=0;
        _tipsLabel.font=[UIFont systemFontOfSize:15];
    }
    return _tipsLabel;
}
-(UIImageView *)tipsImageView{
    if (_tipsImageView==nil) {
        _tipsImageView=[[UIImageView alloc]init];
        _tipsImageView.image=[UIImage imageNamed:@"clusterDetailheadView"];
    }
    return _tipsImageView;
}
-(UIImageView *)addressImageView{
    if (_addressImageView==nil) {
        _addressImageView=[[UIImageView alloc]init];
        _addressImageView.image=[UIImage imageNamed:@"share_location"];
    }
    return _addressImageView;
}
-(UILabel *)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.font=[UIFont systemFontOfSize:14];
        _nameLabel.text=@"";
        _nameLabel.textColor=AllTextColor;
        
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel{
    if (_phoneLabel==nil) {
        _phoneLabel=[[UILabel alloc]init];
        _phoneLabel.text=@"15088228288";
        _phoneLabel.textColor=AllTextColor;
        _phoneLabel.font=[UIFont systemFontOfSize:14];
        _phoneLabel.textAlignment=NSTextAlignmentLeft;
        
    }
    return _phoneLabel;
}
-(UILabel *)addressLabel{
    if (_addressLabel==nil) {
        _addressLabel=[[UILabel alloc]init];
        _addressLabel.text=@"";
        _addressLabel.textColor=AllTextColor;
        _addressLabel.numberOfLines=0;
    }
    return _addressLabel;
}
-(UIView *)bottomLineView{
    if (_bottomLineView==nil) {
        _bottomLineView=[[UIView alloc]init];
        _bottomLineView.backgroundColor=RGB(247, 247, 247);
    }
    return _bottomLineView;
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=RGB(247, 247, 247);
    }
    return _bgView;
}
@end
