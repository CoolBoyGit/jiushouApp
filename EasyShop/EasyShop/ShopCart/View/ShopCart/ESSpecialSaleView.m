//
//  ESSpecialSaleView.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/8.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESSpecialSaleView.h"

@interface ESSpecialSaleView()

@property (nonatomic, strong) UILabel *promoteLab;
@property (nonatomic, strong) UILabel *leftLine;
@property (nonatomic, strong) UILabel *rightLine;
@property (nonatomic,strong ) UIView*bgView;

@end

@implementation ESSpecialSaleView
-(void)setText:(NSString *)text{
    self.promoteLab.text=text;
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]init];
        _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenHeight, 20)];
        _bgView.backgroundColor=[UIColor grayColor];
    }
    return _bgView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.promoteLab];
        [self.promoteLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(@10);
            make.height.equalTo(@20);
            make.width.equalTo(@150);
        }];
        
        [self addSubview:self.leftLine];
        [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.promoteLab.mas_centerY).with.offset(0);
            make.right.equalTo(self.promoteLab.mas_left).with.offset(-5);
            make.height.equalTo(@.5);
            make.left.equalTo(@15);
        }];
        
        [self addSubview:self.rightLine];
        [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.promoteLab.mas_centerY).with.offset(0);
            make.left.equalTo(self.promoteLab.mas_right).with.offset(5);
            make.height.equalTo(@0.5);
            make.right.equalTo(@(-15));
        }];
    }
    return self;
}

-(UILabel *)promoteLab
{
    if (!_promoteLab) {
        _promoteLab = [[UILabel alloc] init];
        _promoteLab.font = ADeanFONT18;
        _promoteLab.text = @"猜 你 喜 欢";
        _promoteLab.textAlignment = NSTextAlignmentCenter;
        _promoteLab.textColor = ADeanHEXCOLOR(0x999999);
    }
    return _promoteLab;
}
-(UILabel *)leftLine
{
    if (!_leftLine) {
        _leftLine = [[UILabel alloc] init];
        _leftLine.backgroundColor = [UIColor grayColor];
    }
    return _leftLine;
}
-(UILabel *)rightLine
{
    if (!_rightLine) {
        _rightLine = [[UILabel alloc] init];
        _rightLine.backgroundColor = [UIColor grayColor];
    }
    return _rightLine;
}

@end
