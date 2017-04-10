//
//  MyOrderFooterView.m
//  EasyShop
//
//  Created by guojian on 16/5/22.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "MyOrderFooterView.h"

@interface MyOrderFooterView()

/** 分割线 */
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic, strong) UILabel *productCountLabel;//共多少件
@property (nonatomic, strong) UILabel *productPriceLabe;;//应付总款
@property (nonatomic, strong) UIButton *cancelButton;//取消支付
@property (nonatomic, strong) UIButton *payButton;//立刻支付
@property (nonatomic ,strong) UIButton *applyButton;//申请退款
@property (nonatomic ,strong) UIButton *refoundButton;
@property (nonatomic ,strong) UILabel*taxFeelLabel;//税费

/** 分割view */
@property (nonatomic,strong) UIView *bottomView;

@end

@implementation MyOrderFooterView
-(UILabel *)taxFeelLabel{
    if (_taxFeelLabel==nil) {
        _taxFeelLabel=[[UILabel alloc]init];
        _taxFeelLabel.textColor=RGB(172, 172, 172);
        _taxFeelLabel.textAlignment=NSTextAlignmentRight;
        _taxFeelLabel.font=[UIFont systemFontOfSize:13];
        
    }
    return _taxFeelLabel;
}
- (void)setOrderInfo:(OrderInfo *)orderInfo
{
    _orderInfo = orderInfo;
    int count =0;
    NSString*newStr=_orderInfo.tax_fee;
    NSString*taxStr=[newStr stringByReplacingOccurrencesOfString:@"." withString:@"0"];
    for (int i=0;i<[taxStr length];i++) {
        unichar ch=[taxStr characterAtIndex:i];
        NSString *str = [NSString stringWithFormat:@"%c",ch];
        if ([str isEqualToString:@"0"]) {
            count++;
        }
    }
    if (count==[taxStr length]) {
        
        self.taxFeelLabel.hidden=YES;
        
    }else{
        self.taxFeelLabel.hidden=NO;
        
    }
    
    self.taxFeelLabel.text=[NSString stringWithFormat:@"税费:¥%.2f",[_orderInfo.tax_fee floatValue]];
    self.productCountLabel.text = [NSString stringWithFormat:@"共%@件",_orderInfo.total_goods_num];
    self.refoundButton.hidden=YES;
    self.applyButton.hidden=YES;
    self.cancelButton.hidden = YES;
    self.payButton.hidden = YES;
    NSString *priceText = @"";
    NSString*taxFeelText=@"";
    switch (_orderInfo.orderStatus) {
        case OrderStatus_Cancel://取消订单
            
        {
            
            if (count==[taxStr length]){
                priceText = [NSString stringWithFormat:@"合计:¥%.2f",_orderInfo.total_fee.floatValue];
            }else{
                taxFeelText = [NSString stringWithFormat:@"合计(含税):¥%.2f",_orderInfo.total_fee.floatValue];
            }

        }
            break;
        case OrderStatus_WaitPay://等待支付
        {
            if (count==[taxStr length]){
                priceText = [NSString stringWithFormat:@"合计:¥%.2f",_orderInfo.total_fee.floatValue];
            }else{
                taxFeelText = [NSString stringWithFormat:@"合计(含税):¥%.2f",_orderInfo.total_fee.floatValue];
            }
            
            
            self.cancelButton.hidden = NO;
            self.payButton.hidden = NO;
            [self.cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.payButton setTitle:@"去支付" forState:UIControlStateNormal];
        }
            break;
        case OrderStatus_WaitSend://待发货
        {
            self.applyButton.hidden=NO;
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
            
            [self.applyButton setTitle:title forState:UIControlStateNormal];
            if (count==[taxStr length]){
                priceText = [NSString stringWithFormat:@"合计:¥%.2f",_orderInfo.total_fee.floatValue];
            }else{
                taxFeelText = [NSString stringWithFormat:@"合计(含税):¥%.2f",_orderInfo.total_fee.floatValue];
            }
            
            
        }
            break;
        case OrderStatus_WaitReply://待评价
        {  self.refoundButton.hidden=NO;
            self.cancelButton.hidden=NO;
            [self.cancelButton setTitle:@"查看物流" forState:UIControlStateNormal];
            self.payButton.hidden = NO;
            [self.payButton setTitle:@"去评价" forState:UIControlStateNormal];
            if (count==[taxStr length]){
                priceText = [NSString stringWithFormat:@"合计:¥%.2f",_orderInfo.total_fee.floatValue];
            }else{
                taxFeelText = [NSString stringWithFormat:@"合计(含税):¥%.2f",_orderInfo.total_fee.floatValue];
            }
            
        }
            break;
        case OrderStatus_WaitSure://待确认
        {
            self.cancelButton.hidden=NO;
            [self.cancelButton setTitle:@"查看物流" forState:UIControlStateNormal];
            self.payButton.hidden = NO;
            [self.payButton setTitle:@"确认收货" forState:UIControlStateNormal];
            if (count==[taxStr length]){
                priceText = [NSString stringWithFormat:@"合计:¥%.2f",_orderInfo.total_fee.floatValue];
            }else{
                taxFeelText = [NSString stringWithFormat:@"合计(含税):¥%.2f",_orderInfo.total_fee.floatValue];
            }
            
            
        }
            break;
            
    }
    
    
    if (count==[taxStr length]){
        if (priceText.length==0) {
            
        }else{
            NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc]initWithString:priceText];
            [muStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(3, 1)];
            [muStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:14.5]} range:NSMakeRange(4, priceText.length-4)];
            [muStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(priceText.length-2, 2)];
            self.productPriceLabe.attributedText = muStr;
        }
        
    }else{
        if (taxFeelText.length==0) {
            
        }else{
            NSMutableAttributedString*tmuStr=[[NSMutableAttributedString alloc]initWithString:taxFeelText];
            [tmuStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(7, 1)];
            [tmuStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:14.5]} range:NSMakeRange(8, taxFeelText.length-8)];
            [tmuStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(taxFeelText.length-2, 2)];
            self.productPriceLabe.attributedText=tmuStr;
        }
        
    }
    [self setNeedsLayout];
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.productCountLabel];
        [self.contentView addSubview:self.productPriceLabe];
        [self.contentView addSubview:self.taxFeelLabel];
        [self.contentView addSubview:self.cancelButton];
        [self.contentView addSubview:self.payButton];
        [self.contentView addSubview:self.bottomView];
        [self.contentView addSubview:self.applyButton];
        [self.contentView addSubview:self.refoundButton];
        
        
        self.taxFeelLabel.hidden=YES;
    }
    return self;
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@30);
        make.height.equalTo(@0.35);
        make.left.right.equalTo(@0);
    }];
    [self.productPriceLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lineView.mas_top).offset(-5);
        make.right.equalTo(@(-12));
    }];
    
    [self.productCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.productPriceLabe.mas_left).offset(-12);
        make.bottom.equalTo(self.lineView.mas_top).offset(-5);
        
    }];
    [self.taxFeelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.productCountLabel.mas_left).offset(-12);
         make.bottom.equalTo(self.lineView.mas_top).offset(-5);
        
    }];

    if (self.orderInfo) {
        switch (self.orderInfo.orderStatus) {
            case OrderStatus_WaitPay://等待支付
                
            case OrderStatus_WaitReply://待评价{
            {
                [self.refoundButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.cancelButton.mas_left).offset(-10);
                    make.top.equalTo(self.lineView.mas_bottom).offset(5);
                    make.width.equalTo(@84);
                    make.height.equalTo(@30);
                }];
            }
            case OrderStatus_WaitSure://待确认
            {
                [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(@(-12));
                    make.top.equalTo(self.lineView.mas_bottom).offset(5);
                    make.width.equalTo(@84);
                    make.height.equalTo(@30);
                }];
                
                [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.payButton.mas_left).offset(-10);
                    make.top.equalTo(self.lineView.mas_bottom).offset(5);
                    make.width.equalTo(@84);
                    make.height.equalTo(@30);
                }];
            }
                break;
            case OrderStatus_Cancel:
            case OrderStatus_WaitSend://待发货
            {
                [self.applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(@(-12));
                    make.top.equalTo(self.lineView.mas_bottom).offset(5);
                    make.width.equalTo(@84);
                    make.height.equalTo(@30);
                }];
                
            }
                break;
        }
    }
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@10);
    }];
    
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor clearColor];
    }
    return _lineView;
}

- (UILabel *)productCountLabel
{
    if (_productCountLabel == nil) {
        _productCountLabel = [[UILabel alloc] init];
        _productCountLabel.textColor = RGB(172, 172, 172);
        _productCountLabel.font = [UIFont systemFontOfSize:13];
    }
    return _productCountLabel;
}

- (UILabel *)productPriceLabe
{
    if (_productPriceLabe == nil) {
        _productPriceLabe = [[UILabel alloc] init];
        _productPriceLabe.textColor = RGB(172, 172, 172);
        _productPriceLabe.font = [UIFont systemFontOfSize:13];
    }
    return _productPriceLabe;
}

-(UIButton *)cancelButton
{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        //        _cancelButton.layer.cornerRadius = 4;
        //
        //        _cancelButton.layer.masksToBounds=YES;
        //        _cancelButton.backgroundColor=RGB(233, 40, 46);
        // [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        
        _cancelButton.layer.cornerRadius=2;
        _cancelButton.layer.masksToBounds=YES;
        _cancelButton.backgroundColor=[UIColor whiteColor];
        [_cancelButton setTitleColor:RGB(76, 79, 80) forState:UIControlStateNormal];
        _cancelButton.layer.borderColor=RGB(150, 150, 150).CGColor;
        _cancelButton.layer.borderWidth=1;
        
    }
    return _cancelButton;
}

-(UIButton *)payButton
{
    if (_payButton == nil) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitle:@"立即付款" forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_payButton addTarget:self action:@selector(payButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _payButton.layer.cornerRadius=2;
        _payButton.layer.masksToBounds=YES;
        _payButton.backgroundColor=[UIColor whiteColor];
        [_payButton setTitleColor:RGB(233, 40, 46) forState:UIControlStateNormal];
        _payButton.layer.borderColor=RGB(233, 40, 46 ).CGColor;
        _payButton.layer.borderWidth=1;
        
    }
    return _payButton;
}
-(UIButton*)refoundButton{
    if (_refoundButton==nil) {
        
        _refoundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_refoundButton setTitle:@"申请退货" forState:UIControlStateNormal];
        _refoundButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _refoundButton.hidden=YES;
        [_refoundButton addTarget:self action:@selector(refoundButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _refoundButton.layer.cornerRadius=2;
        _refoundButton.layer.masksToBounds=YES;
        _refoundButton.backgroundColor=[UIColor whiteColor];
        [_refoundButton setTitleColor:RGB(76, 79, 80) forState:UIControlStateNormal];
        _refoundButton.layer.borderColor=RGB(150, 150, 150).CGColor;
        _refoundButton.layer.borderWidth=1;
    }
    return _refoundButton;
}
-(UIButton *)applyButton{
    if (_applyButton==nil) {
        
        _applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_applyButton setTitle:@"申请退款" forState:UIControlStateNormal];
        _applyButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_applyButton addTarget:self action:@selector(applyButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _applyButton.layer.cornerRadius=2;
        _applyButton.layer.masksToBounds=YES;
        _applyButton.backgroundColor=[UIColor whiteColor];
        [_applyButton setTitleColor:RGB(76, 79, 80) forState:UIControlStateNormal];
        _applyButton.layer.borderColor=RGB(150, 150, 150).CGColor;
        _applyButton.layer.borderWidth=1;
        
    }
    return _applyButton;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        //_bottomView.backgroundColor = RGB(240, 240, 240);
        _bottomView.backgroundColor=RGBA(247, 247, 247, 1);;
    }
    return _bottomView;
}

- (void)cancelAction
{
    if (self.cancleBlock) {
        self.cancleBlock();
    }
}
-(void)refoundButtonAction{
    if (self.refoundBlock) {
        self.refoundBlock();
    }
}
-(void)payButtonAction
{
    if (self.rightBlock) {
        self.rightBlock();
    }
}
-(void)applyButtonAction{
    if (self.applyMoney) {
        self.applyMoney();
    }
}
@end
