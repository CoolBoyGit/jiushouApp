//
//  ESCollectHeaderView.m
//  EasyShop
//
//  Created by 就手国际 on 16/12/16.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESCollectHeaderView.h"
@interface ESCollectHeaderView ()
@property (nonatomic,strong) UILabel*topLabel;
@property (nonatomic,strong) UILabel*twoLabel;
@property (nonatomic,strong) UIImageView*bgImageVeiw;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *rightView;
@property (nonatomic,strong) UILabel*tipsLable;
@end
@implementation ESCollectHeaderView
-(void)setTopStr:(NSString *)topStr{
    self.topLabel.text=topStr;
    self.twoLabel.text=@"看看小就有什么推荐吧";
    self.bgImageVeiw.image=[UIImage imageNamed:@"shopCarAlone"];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=RGB(234, 234, 234);
        [self addSubview:self.bgImageVeiw];
        [self.bgImageVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@60);
            make.width.height.equalTo(@80);
            make.centerX.equalTo(self.mas_centerX);
        }];
        [self addSubview:self.topLabel];
        [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgImageVeiw.mas_bottom).offset(30);
            make.left.right.equalTo(@0);
            
        }];
        [self addSubview:self.twoLabel];
        [self.twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(self.topLabel.mas_bottom).offset(15);
        }];
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.bottom.equalTo(@0);
            make.height.equalTo(@35);
        }];
        [self.bgView addSubview:self.tipsLable];
        [self.tipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bgView.mas_centerY).offset(0);
            make.centerX.equalTo(self.mas_centerX).offset(0);
        }];
        [self.bgView addSubview:self.leftView];
        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(self.tipsLable.mas_left).offset(-15);
            make.height.equalTo(@1);
            make.centerY.equalTo(self.bgView.mas_centerY).offset(0);
        }];
        [self.bgView addSubview:self.rightView];
        [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tipsLable.mas_right).offset(15);
            make.right.equalTo(@(-10));
            make.height.equalTo(@1);
            make.centerY.equalTo(self.bgView. mas_centerY).offset(0);
        }];
    }
    return self;
}
-(UILabel *)topLabel{
    if (_topLabel==nil) {
        _topLabel=[[UILabel alloc]init];
        _topLabel.textColor=AllTextColor;
        _topLabel.font=[UIFont systemFontOfSize:14];
        _topLabel.textAlignment=NSTextAlignmentCenter;
        _topLabel.text=@"你还没有相关订单";
    }
    return _topLabel;
}
-(UILabel *)twoLabel{
    if (_twoLabel==nil) {
        _twoLabel=[[UILabel alloc]init];
        _twoLabel.textColor=[UIColor lightGrayColor];
        _twoLabel.textAlignment=NSTextAlignmentCenter;
        _twoLabel.font=[UIFont systemFontOfSize:14];
        _twoLabel.text=@"看看有哪些想买的";
    }
    return _twoLabel;
}
-(UIImageView *)bgImageVeiw{
    if (_bgImageVeiw==nil) {
        _bgImageVeiw=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_order_none"]];
    }
    return _bgImageVeiw;
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=RGB(240, 240, 240);
        //_bgView.backgroundColor=[UIColor whiteColor];
    }
    return _bgView;
}
-(UIView *)leftView{
    if (_leftView==nil) {
        _leftView=[[UIView alloc]init];
        _leftView.backgroundColor=RGB(228, 228, 228);
        
    }
    return _leftView;
}
-(UIView *)rightView{
    if (_rightView==nil) {
        _rightView=[[UIView alloc]init];
        _rightView.backgroundColor=RGB(228, 228, 228);
        
    }
    return _rightView;
}
-(UILabel *)tipsLable{
    if (_tipsLable==nil) {
        _tipsLable=[[UILabel alloc]init];
        _tipsLable.textColor=AllTextColor;
        _tipsLable.font=[UIFont systemFontOfSize:14];
        _tipsLable.textAlignment=NSTextAlignmentCenter;
        _tipsLable.text=@"就手猜你喜欢";
    }
    return _tipsLable
    ;
}
@end
