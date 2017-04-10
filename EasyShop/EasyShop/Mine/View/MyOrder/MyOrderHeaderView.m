//
//  MyOrderHeaderView.m
//  EasyShop
//
//  Created by guojian on 16/5/22.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "MyOrderHeaderView.h"
#import "GSTimeTool.h"

@interface MyOrderHeaderView()

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *stateLabel;
/** 分割线 */
@property (nonatomic,strong) UIView *lineView;
@end

@implementation MyOrderHeaderView

- (void)setOrderInfo:(OrderInfo *)orderInfo
{
    _orderInfo = orderInfo;
    
    self.dateLabel.text = [GSTimeTool formatterNumber:_orderInfo.create_time toType:GSTimeType_YYYYMMdd];
    switch (_orderInfo.orderStatus) {
        case OrderStatus_Cancel://已取消
            self.stateLabel.text=_orderInfo.orderDisplay;
            
            break;
        case OrderStatus_WaitPay://待付款
            self.stateLabel.text=_orderInfo.orderDisplay;
            break;
        case OrderStatus_WaitSend://待发货
            self.stateLabel.text = _orderInfo.refund_stau;
            break;
          case OrderStatus_WaitReply://待评价
            self.stateLabel.text=_orderInfo.orderDisplay;
            break;
         case OrderStatus_WaitSure://待收货
            self.stateLabel.text=_orderInfo.orderDisplay;
            break;
            
        default:
            break;
    }
    
    
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.stateLabel];
        [self.contentView addSubview:self.lineView];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@12);
            make.top.equalTo(@10);
        }];
        
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-12));
            make.top.equalTo(@(10));
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}


- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(236, 236, 236);
    }
    return _lineView;
}

- (UILabel *)dateLabel
{
    if (_dateLabel == nil) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = RGB(172, 172, 172);
        _dateLabel.font = [UIFont systemFontOfSize:13.5];
    }
    return _dateLabel;
}

- (UILabel *)stateLabel
{
    if (_stateLabel == nil) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.textColor =RGBA(233, 40, 46, 0.9);
        _stateLabel.font = [UIFont systemFontOfSize:14];
    }
    return _stateLabel;
}

@end