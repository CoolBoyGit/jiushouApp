//
//  OrderDetailBottomView.m
//  EasyShop
//
//  Created by guojian on 16/5/31.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "OrderDetailBottomView.h"

@interface OrderDetailBottomView()

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *payButton;
/*申请退货*/
@property (nonatomic,strong)  UIButton *refundGoosButton;
@property (nonatomic,strong)  UIView *view;
@end

@implementation OrderDetailBottomView

- (void)setOrderInfo:(OrderDetailInfo *)orderInfo
{
    _orderInfo = orderInfo;
    
    switch (orderInfo.orderStatus) {
        case OrderStatus_WaitPay://等待支付
        {
            self.payButton.hidden = NO;
            [self.payButton setTitle:@"去支付" forState:UIControlStateNormal];
        }
            break;
        case OrderStatus_WaitSend://等待发货
        {
            NSString*title=nil;
            switch (_orderInfo.refund_status.intValue) {
                case 0:
                    title=@"申请退款";
                    break;
                case 2:
                    title=@"正在审核";
                    break;
                case 3:
                    title=@"通过审核";
                    break;
                case 4:
                    title=@"拒绝退款";
                    break;
                case 5:
                    title=@"退款完成";
                    break;
                case 6:
                    title=@"退款中";
                    break;
                default:
                    break;
            }

            self.payButton.hidden = NO;
            [self.payButton setTitle:title forState:UIControlStateNormal];
        }
            break;
        case OrderStatus_WaitReply://待评价
        {
            self.refundGoosButton.hidden=NO;
            self.cancelButton.hidden=NO;
            [self.cancelButton setTitle:@"查看物流" forState:UIControlStateNormal];
            self.payButton.hidden = NO;
            [self.payButton setTitle:@"去评价" forState:UIControlStateNormal];
        }
            break;
        case OrderStatus_WaitSure://待收货
        {
            self.cancelButton.hidden = NO;
            [self.cancelButton setTitle:@"查看物流" forState:UIControlStateNormal];
            self.payButton.hidden = NO;
            [self.payButton setTitle:@"确认收货" forState:UIControlStateNormal];
        }
            break;
        default: break;
    }
}
-(UIView*)view{
    if (_view==nil) {
        _view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
        _view.backgroundColor=RGB(178, 179, 180);
        
        
    }
    return _view;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
         self.backgroundColor=RGBA(220, 220, 220, 0.6);
        
        [self addSubview:self.payButton];
        [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.top.equalTo(@20);
            make.bottom.equalTo(@(-20));
            make.width.equalTo(@84);
            }];
         [self addSubview:self.cancelButton];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.payButton.mas_left).offset(-10);
           
            make.width.equalTo(@84);
            make.top.equalTo(@20);
            make.bottom.equalTo(@(-20));
        }];
        [self addSubview:self.refundGoosButton];
        [self.refundGoosButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.cancelButton.mas_left).offset(-10);
            
            make.width.equalTo(@84);
            make.top.equalTo(@20);
            make.bottom.equalTo(@(-20));
        }];
        self.refundGoosButton.hidden=YES;
        self.cancelButton.hidden = YES;
        self.payButton.hidden = YES;
    }
    return self;
}


- (void)buttonAction:(UIButton *)button
{
    if (button == self.cancelButton) {
        if (self.leftBlock) {
            self.leftBlock();
        }
    }else if (button == self.payButton){
        if (self.rightBlock) {
            self.rightBlock();
        }
    }else if (button==self.refundGoosButton){
        if (self.RefoundBlock) {
            self.RefoundBlock();
        }
    }
}

-(UIButton *)cancelButton
{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _cancelButton.layer.cornerRadius = 2;
        _cancelButton.backgroundColor = [UIColor whiteColor];
        [_cancelButton setTitleColor:RGB(76, 78, 80) forState:UIControlStateNormal];
        _cancelButton.layer.borderColor=RGB(76, 78, 80).CGColor;
        _cancelButton.layer.borderWidth=1;
        [_cancelButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(UIButton *)payButton
{
    if (_payButton == nil) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitle:@"立即付款" forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _payButton.layer.cornerRadius = 2;
        _payButton.layer.masksToBounds=YES;
        _payButton.backgroundColor = [UIColor whiteColor];
        [_payButton setTitleColor:RGB(233, 40, 46) forState:UIControlStateNormal];
        _payButton.layer.borderColor=RGB(233, 40, 46).CGColor;
        _payButton.layer.borderWidth=1;
        [_payButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}
-(UIButton *)refundGoosButton{
    if (_refundGoosButton==nil) {
        _refundGoosButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_refundGoosButton setTitle:@"申请退货" forState:UIControlStateNormal];
        _refundGoosButton.titleLabel.font=[UIFont systemFontOfSize:14];
        _refundGoosButton.layer.cornerRadius=4;
        _refundGoosButton.layer.masksToBounds=YES;
        _refundGoosButton.backgroundColor = [UIColor whiteColor];
        [_refundGoosButton setTitleColor:RGB(76, 78, 80) forState:UIControlStateNormal];
        _refundGoosButton.layer.borderColor=RGB(76, 78, 80).CGColor;
        _refundGoosButton.layer.borderWidth=1;
        [_refundGoosButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refundGoosButton;
}

@end
