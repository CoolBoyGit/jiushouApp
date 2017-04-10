//
//  ESSureBottonView.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/15.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESSureBottonView.h"
#import "ESPayListController.h"

@interface ESSureBottonView()

@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UILabel  *allMOneyLabel;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic,strong)  UILabel*countLbale;
@end

@implementation ESSureBottonView

- (void)setConfirmInfo:(OrderConfirmInfo *)confirmInfo
{
    _confirmInfo = confirmInfo;
    NSString*str=[NSString stringWithFormat:@"合计:￥%0.2f",confirmInfo.cost];
    NSMutableAttributedString*mustr=[[NSMutableAttributedString alloc]initWithString:str];
    [mustr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGB(233, 40, 46)} range:NSMakeRange(3, 1)];
     [mustr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.5],NSForegroundColorAttributeName:RGB(233, 40, 46)} range:NSMakeRange(4, str.length-4)];
     [mustr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGB(233, 40, 46)} range:NSMakeRange(str.length-2, 2)];
    self.allMOneyLabel.attributedText=mustr;
    NSString*cstr=[NSString stringWithFormat:@"共%d件商品",confirmInfo.count];
    NSMutableAttributedString*mucstr=[[NSMutableAttributedString alloc]initWithString:cstr];
    [mucstr addAttribute:NSForegroundColorAttributeName value:RGB(233, 40, 46) range:NSMakeRange(1, cstr.length-4)];
    self.countLbale.attributedText=mucstr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setUpViews];
    }
    return self;
}
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=RGB(170, 170, 170);
        
        
    }
    return _lineView;
}
-(void)setUpViews
{
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@0.35);
    }];
    [self addSubview:self.sureButton];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(@0);
        make.top.equalTo(@0.35);
        make.width.equalTo(@128.5);
    }];
    [self addSubview:self.allMOneyLabel];
    [self.allMOneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.top.equalTo(@0.35);
        make.left.equalTo(@20);
    }];
    [self addSubview:self.countLbale];
    [self.countLbale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allMOneyLabel.mas_right).offset(10);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}
-(UILabel *)countLbale{
    if (_countLbale==nil) {
        _countLbale=[[UILabel alloc]init];
        _countLbale.textColor=AllTextColor;
        _countLbale.font=[UIFont systemFontOfSize:14.5];
    }
    return _countLbale;
}
-(UILabel *)allMOneyLabel
{
    if (!_allMOneyLabel) {
        _allMOneyLabel = [[UILabel alloc] init];
        _allMOneyLabel.textAlignment = NSTextAlignmentLeft;
        _allMOneyLabel.font = [UIFont systemFontOfSize:14.5];
        _allMOneyLabel.textColor =AllTextColor;
    }
    return _allMOneyLabel;
}
-(UIButton *)sureButton
{
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.backgroundColor = RGB(233, 40, 46);
        [_sureButton setTitle:@"确认订单" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

-(void)sureAction
{
    if (self.sureBlock) {
        self.sureBlock();
    }
}

@end
