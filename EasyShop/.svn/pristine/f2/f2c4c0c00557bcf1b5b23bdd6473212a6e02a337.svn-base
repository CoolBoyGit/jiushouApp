//
//  ESCouponFooterReusableView.m
//  EasyShop
//
//  Created by jiushou on 16/7/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESCouponFooterReusableView.h"
@interface ESCouponFooterReusableView()
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIView *graryView;
@end
@implementation ESCouponFooterReusableView
-(UIView *)graryView{
    if (_graryView==nil) {
        _graryView=[[UIView alloc]init];
        _graryView.backgroundColor=RGB(245, 245, 245);
        
    }
    return _graryView;
}
-(UILabel *)label{
    if (_label==nil) {
        _label=[[UILabel alloc]init];
        _label.text=@"就手温馨提示: 当你使用现金卷购买的商品发生退货款时,现金卷所抵购的费用将不会退还";
        _label.numberOfLines=0;
        _label.font=[UIFont systemFontOfSize:13];
        _label.textColor=RGB(174, 174, 174);
    }
    return _label;
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=[UIColor whiteColor];
        
    }
    return _bgView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.graryView];
        [self.graryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(@(-10));
            make.top.bottom.equalTo(@0);
        }];
        [self.graryView addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right .equalTo(@0);
            make.height.equalTo(@10);
            
            
        }];
        [self.graryView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.width.equalTo(@(ScreenWidth-40));
            make.top.equalTo(@15);
        }];
        self.backgroundColor=[UIColor whiteColor];
        
    }
    return self;
}
@end
