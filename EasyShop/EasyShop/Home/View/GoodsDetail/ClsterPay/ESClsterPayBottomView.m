//
//  ESToPayBottomView.m
//  EasyShop
//
//  Created by jiushou on 16/10/11.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClsterPayBottomView.h"
#import "ClusterPayMoneyItem.h"
@interface ESClsterPayBottomView()
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UIButton*sureButton;
@property (nonatomic,strong) NSNumber*price;
@property (nonatomic,strong) ClusterPayMoneyItem*item;
@end

@implementation ESClsterPayBottomView
-(void)setSimpleGoods:(GetSimpGoodsRespone *)simpleGoods{
    _price=simpleGoods.cluster_price;
    NSMutableAttributedString*str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"合计:￥%.2f",simpleGoods.cluster_price.floatValue]];
    [str addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:RGB(233, 40, 46)} range:NSMakeRange(3, str.length-3)];
    [str addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.5],NSForegroundColorAttributeName:RGB(233, 40, 46)} range:NSMakeRange(3, 1)];
     [str addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.5],NSForegroundColorAttributeName:RGB(233, 40, 46)} range:NSMakeRange(str.length-2    , 2)];
    self.priceLabel.attributedText=str;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.sureButton];
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right. bottom.equalTo(@0);
            make.width.equalTo(@150);
            
        }];
        [self addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.top.bottom. equalTo(@0);
        }];
        [self addNotifa];
    }return self;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)addNotifa{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeCountLabel:) name:CountCLusterPriceChange object:nil];
}
-(void)changeCountLabel:(NSNotification*)notifa{
    self.item=notifa.userInfo[@"count"];
    NSString*pstr=[NSString stringWithFormat:@"合计:￥%.2f",self.item.count*[self.item.price floatValue]-[self.item.coupnonValue floatValue]];
    
   // NSString*str=[NSString stringWithFormat:@"%.2f",self.item.count*[self.item.price floatValue]-[self.item.coupnonValue floatValue]];
    NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc]initWithString:pstr];
    [muStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:RGB(233, 40, 46)} range:NSMakeRange(3, pstr.length-3)];
    [muStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.5],NSForegroundColorAttributeName:RGB(233, 40, 46)} range:NSMakeRange(3, 1)];
    [muStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.5],NSForegroundColorAttributeName:RGB(233, 40, 46)} range:NSMakeRange(pstr.length-2,2)];
    self.priceLabel.attributedText=muStr;
    
}
-(UILabel *)priceLabel{
    if (_priceLabel==nil) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.text=@"";
        _priceLabel.font=[UIFont systemFontOfSize:14];
        _priceLabel.textColor=AllTextColor;
        _priceLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _priceLabel;
}
-(UIButton *)sureButton{
    if (_sureButton==nil) {
        _sureButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.backgroundColor=RGBA(233, 40, 46, 1);
        [_sureButton setTitle:@"确认支付" forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _sureButton;
}
-(void)sureButtonAction{
    if (self.sureButtonBlock) {
        self.sureButtonBlock();
    }
}
@end
