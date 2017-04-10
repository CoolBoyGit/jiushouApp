//
//  ESPayListCell.m
//  EasyShop
//
//  Created by 就手国际 on 17/1/17.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import "ESPayListCell.h"
@interface ESPayListCell()
@property (nonatomic,strong) UILabel*leftLabel;
@property (nonatomic,strong) UILabel*rightLabel;

@end
@implementation ESPayListCell
-(void)setCountStr:(NSString *)countStr{
    NSString*str=[NSString stringWithFormat:@"可用优惠卷%@张",countStr];
    NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc]initWithString:str];
    [muStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(5, str.length-6)];
    self.rightLabel.attributedText=muStr;

}
-(void)setCouponInfo:(CouponInfo *)couponInfo{
    NSString*str=[NSString stringWithFormat:@"优惠金额:￥%@",couponInfo.c_value];
    NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc]initWithString:str];
    [muStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:17]} range:NSMakeRange(5, str.length-5)];
    [muStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.5] range:NSMakeRange(5, 1)];
    [muStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.5] range:NSMakeRange(str.length-2, 2)];
    self.rightLabel.attributedText=muStr;

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.leftLabel];
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.top.bottom.equalTo(@0);
        }];
        [self.contentView addSubview:self.rightLabel];
        [self .rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.right.equalTo(@-20);
        }];
    }
    return self;
}
-(UILabel *)leftLabel{
    if (_leftLabel==nil) {
        _leftLabel=[[UILabel alloc]init];
        _leftLabel.text=@"使用优惠卷";
        _leftLabel.textColor=AllTextColor;
        _leftLabel.font=[UIFont systemFontOfSize:15];
        
    }
    return _leftLabel;
}
-(UILabel *)rightLabel{
    if (_rightLabel==nil) {
        _rightLabel=[[UILabel alloc]init];
        _rightLabel.textColor=AllTextColor;
        _rightLabel.textAlignment=NSTextAlignmentRight;
        _rightLabel.font=[UIFont systemFontOfSize:15];
    }
    return _rightLabel;
}
@end
