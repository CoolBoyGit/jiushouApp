//
//  ESFootViewGray.m
//  EasyShop
//
//  Created by LDZPro on 16/6/30.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESFootViewGray.h"
@interface ESFootViewGray()
@property (nonatomic,strong) UILabel*moneyLabel;
@property (nonatomic,strong) UILabel*muchLabel;
@property (nonatomic,strong) UIView*bgView;
@end
@implementation ESFootViewGray
-(void)setDetailInfo:(OrderDetailInfo *)detailInfo{
    self.muchLabel.text=[NSString stringWithFormat:@"共%ld件商品",detailInfo.order_goods.count];
    NSString*allStr=[NSString stringWithFormat:@"合计:￥%.2f",[detailInfo.total_fee floatValue]];
    NSMutableAttributedString*muaAllStr=[[NSMutableAttributedString alloc]initWithString:allStr];
    [muaAllStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:14.5]}  range:NSMakeRange(3, allStr.length-3)];
    [muaAllStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}  range:NSMakeRange(3, 1)];
    [muaAllStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}  range:NSMakeRange(muaAllStr.length-2, 2)];
    self.moneyLabel.attributedText=muaAllStr;
    
}
-(UILabel *)moneyLabel{
    if (_moneyLabel==nil) {
        _moneyLabel=[[UILabel alloc]init];
        _moneyLabel.font=[UIFont systemFontOfSize:13];
        _moneyLabel.text=@"123444444";
        _moneyLabel.textColor=RGB(172, 172, 172);
        
    }
    return _moneyLabel;
}
-(UILabel *)muchLabel{
    if (_muchLabel==nil) {
        _muchLabel=[[UILabel alloc]init];
        _muchLabel.textColor=RGB(172, 172, 172);
        _muchLabel.font=[UIFont systemFontOfSize:13];
        
    }
    return _muchLabel;
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=[UIColor whiteColor];
    }
    return _bgView;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=RGB(247, 247, 247);
        
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right.equalTo(@0);
            make.bottom.equalTo(@(-10));
        }];
        [self addSubview:self.moneyLabel];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.bottom.equalTo(@(-18));
        }];
        
        [self addSubview:self.muchLabel];
        [self.muchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-18));
            make.right.equalTo(self.moneyLabel.mas_left).offset(-5);
        }];
}
     return self;
}
@end
