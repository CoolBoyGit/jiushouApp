//
//  ESLogisticHeardView.m
//  EasyShop
//
//  Created by jiushou on 16/7/1.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESLogisticHeardView.h"
@interface ESLogisticHeardView()
/*物流状态*/
@property (nonatomic,strong)UILabel*logiticStaute;
/*运营公司*/
@property (nonatomic,strong)UILabel*nameLabel;
/*订单编号*/
@property (nonatomic,strong)UILabel*orderNumberLabel;
/*友情提示*/
@property (nonatomic,strong)UILabel*tipsLabel;
@property (nonatomic,strong)UIView*whiteView;
@property (nonatomic,strong)UIView*bgView;
@property (nonatomic,strong)NSString*state;
@property (nonatomic,strong)UIButton *pasteButton;
@end

@implementation ESLogisticHeardView
-(void)setOrderTracs:(OrderTracesInfo *)orderTracs{
    switch (orderTracs.State.intValue) {
        case 2:
            self.state=@"在途中";
            break;
        case 3:
            self.state=@"已签收";
            break;
        case 4:
            self.state=@"问题件";
            break;
        default:
            break;
    }
    if (orderTracs==NULL) {
        self.logiticStaute.text=[NSString stringWithFormat:@"物流状态    %@",@""];
        self.nameLabel.text=[NSString stringWithFormat:@"快递公司:   %@",@""] ;
        self.orderNumberLabel.text=[NSString stringWithFormat:@"运单编号:   %@",@""];
    }
    else{
        if ([self.state isEqualToString:@""]) {
            self.logiticStaute.text=[NSString stringWithFormat:@"物流状态    %@",@"暂无物流信息"];
        }else{
            self.logiticStaute.text=[NSString stringWithFormat:@"物流状态    %@",self.state];
        }
        
        self.nameLabel.text=[NSString stringWithFormat:@"快递公司:   %@",orderTracs.ShipperName] ;
        self.orderNumberLabel.text=[NSString stringWithFormat:@"运单编号:   %@",orderTracs.LogisticCode];
    }
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.whiteView];
        [self.contentView addSubview:self.logiticStaute];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.orderNumberLabel];
        [self.contentView addSubview:self.pasteButton];
        [self.contentView addSubview:self.tipsLabel];
        [self.contentView addSubview:self.bgView];
    }
    return self;
    
}
-(UIButton *)pasteButton{
    if (_pasteButton==nil) {
        _pasteButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _pasteButton.frame=CGRectMake(ScreenWidth-70, 70, 50, 20);
        [_pasteButton setTitle:@"复制" forState:UIControlStateNormal];
        _pasteButton.titleLabel.font=[UIFont systemFontOfSize:13];
        _pasteButton.layer.cornerRadius=3;
        _pasteButton.layer.masksToBounds=YES;
        _pasteButton.backgroundColor=RGB(233, 40, 46);
        [_pasteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_pasteButton addTarget:self action:@selector(pasteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pasteButton;
}
-(void)pasteButtonAction{
    if (self.pasteButtonBlock) {
        self.pasteButtonBlock();
    }
}
-(UIView*)whiteView{
    if (_whiteView==nil) {
        _whiteView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
        _whiteView.backgroundColor=[UIColor whiteColor];
    }
    return _whiteView;
}
-(UILabel *)logiticStaute{
    if (_logiticStaute==nil) {
        _logiticStaute=[[UILabel alloc]initWithFrame:CGRectMake(25, 20, ScreenWidth-50, 20)];
        _logiticStaute.font=[UIFont systemFontOfSize:15];
        
        _logiticStaute.textColor=[UIColor grayColor];
        _logiticStaute.text=@"物流状态    已签收";
        
    }
    return _logiticStaute;
}
-(UILabel *)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(25, 45, ScreenWidth-50, 20)];
        _nameLabel.font=[UIFont systemFontOfSize:15];
        _nameLabel.text=@"物流公司:   EMS";
        _nameLabel.textColor=[UIColor grayColor];
        
    }
    return _nameLabel;
}
-(UILabel *)orderNumberLabel{
    if (_orderNumberLabel==nil) {
        _orderNumberLabel=[[UILabel alloc]initWithFrame:CGRectMake(25, 70, 200, 20)];
        _orderNumberLabel.font=[UIFont systemFontOfSize:15];
        _orderNumberLabel.textColor=[UIColor grayColor];
        _orderNumberLabel.text=@"运单编号:   11111111";
    }
    return _orderNumberLabel;
}
-(UILabel*)tipsLabel{
    if (_tipsLabel==nil) {
        _tipsLabel=[[UILabel alloc]initWithFrame:CGRectMake(25, 95, ScreenWidth-50, 20)];
        _tipsLabel.textColor=[UIColor grayColor];
        _tipsLabel.font=[UIFont systemFontOfSize:15];
        _tipsLabel.text=@"友情提示:   具体请去快递100查询";
    }
    return _tipsLabel;
}
-(UIView*)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 130, ScreenWidth, 10)];
        _bgView.backgroundColor=RGB(245, 245, 245);
        
    }
    return _bgView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
