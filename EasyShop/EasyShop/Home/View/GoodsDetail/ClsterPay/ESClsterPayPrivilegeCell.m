//
//  EStoPrivilegeCell.m
//  EasyShop
//
//  Created by jiushou on 16/10/10.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClsterPayPrivilegeCell.h"
@interface ESClsterPayPrivilegeCell()
@property(nonatomic,strong) UILabel *shopPriName;
@property (nonatomic,strong) UILabel*priceLabel;
@property (nonatomic,strong) UIImageView*tipsImageView;
@property (nonatomic,strong) UIView *lineView;
@end
@implementation ESClsterPayPrivilegeCell
-(void)setCountStr:(NSString *)countStr{
    NSString*str=[NSString stringWithFormat:@"可用优惠卷%@张",countStr];
    NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc]initWithString:str];
    [muStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(5, str.length-6)];
    self.priceLabel.attributedText=muStr;
   // self.priceLabel.text=[NSString stringWithFormat:@"可用优惠卷%@张",countStr];
}
-(void)setCouponInfo:(CouponInfo *)couponInfo{
    NSString*str=[NSString stringWithFormat:@"优惠金额:￥%@",couponInfo.c_value];
    NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc]initWithString:str];
    [muStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(5, str.length-5)];
    self.priceLabel.attributedText=muStr;
    
    //self.priceLabel.text=[NSString stringWithFormat:@"优惠金额%@",couponInfo.c_value];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.shopPriName];
        [self.shopPriName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.bottom.equalTo(@(-1));
            make.left.equalTo(@10);
            make.width.equalTo(@120);
        }];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.bottom.equalTo(@(-1));
            make.right.equalTo(@(-10));
        }];
        [self.contentView addSubview:self.tipsImageView];
        [self.tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(@10);
            make.width.equalTo(@10);
            make.height.equalTo(@10);
        }];
        [self .contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
            make.height.equalTo(@1);
            make.left.equalTo(@10);
            make.right.equalTo(@(-10));
        }];
    }
    return self;
}

-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=RGBA(235, 235, 235, 1);
    }
    return _lineView;
}
-(UILabel *)shopPriName{
    if (_shopPriName==nil) {
        _shopPriName=[[UILabel alloc]init];
        _shopPriName.text=@"店铺优惠卷";
        _shopPriName.textColor=AllTextColor;
        _shopPriName.font=[UIFont systemFontOfSize:14];
    }
    return _shopPriName;
}
-(UILabel *)priceLabel{
    if (_priceLabel==nil) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.text=@"-3元";
        _priceLabel.textColor=AllTextColor;
        _priceLabel.font=[UIFont systemFontOfSize:14];
        
    }
    return _priceLabel;
}
-(UIImageView *)tipsImageView{
    if (_tipsImageView==nil) {
        _tipsImageView=[[UIImageView alloc]init];
        _tipsImageView.backgroundColor=[UIColor yellowColor];
        _tipsImageView.image=[UIImage imageNamed:@"sureOrderLeftButton"];
    }
    return _tipsImageView;
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
