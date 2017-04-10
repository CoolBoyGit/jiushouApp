//
//  ESOrderBottonCell.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/12.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESOrderBottonCell.h"

@interface ESOrderBottonCell()

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *payButton;

@end

@implementation ESOrderBottonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupViews
{
    [self.contentView addSubview:self.payButton];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-12));
        make.centerY.equalTo(@0);
        make.width.equalTo(@70);
        make.height.equalTo(@25);
    }];
    
    
    [self.contentView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.payButton.mas_left).offset(-20);
        make.centerY.equalTo(@0);
        make.width.equalTo(@70);
        make.height.equalTo(@25);
    }];
}

-(UIButton *)cancelButton
{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _cancelButton.layer.borderWidth = 1;
        _cancelButton.layer.cornerRadius = 4;
        _cancelButton.layer.borderColor = RGB(159, 159, 159).CGColor;
        [_cancelButton setTitleColor:RGB(159, 159, 159) forState:UIControlStateNormal];
    }
    return _cancelButton;
}

-(UIButton *)payButton
{
    if (_payButton == nil) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitle:@"立即付款" forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:15];
        //        _payButton.layer.borderWidth = 1;
        _payButton.layer.cornerRadius = 4;
        _payButton.backgroundColor = [UIColor redColor];
        //        _payButton.layer.borderColor = [UIColor blackColor].CGColor;
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _payButton;
}

@end
