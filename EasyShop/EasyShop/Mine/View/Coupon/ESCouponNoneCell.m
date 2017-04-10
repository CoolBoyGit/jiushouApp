//
//  ESCouponNoneCell.m
//  EasyShop
//
//  Created by jiushou on 16/7/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESCouponNoneCell.h"

@implementation ESCouponNoneCell
-(void)setIsShow:(BOOL)isShow{
    if (isShow) {
        self.tipsLabel.hidden=NO;
        self.bgImageView.hidden=YES;
    }else{
        self.tipsLabel.hidden=YES;
        self.bgImageView.hidden=NO;
    }
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.tipsLabel];
        [self.tipsLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.centerX.equalTo(self.mas_centerX);
            make.height.with.equalTo(@100);
        }];
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(@200);
            make.height.equalTo(@100);
        }];
    }
    return self;
}
-(UIImageView *)bgImageView{
    if (_bgImageView==nil) {
        _bgImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_noneCoupon"]];
        _bgImageView.hidden=YES;
        
    }
    return _bgImageView;
}
-(UILabel *)tipsLabel{
    if (_tipsLabel==nil) {
        _tipsLabel=[[UILabel alloc]init];
        _tipsLabel.backgroundColor=[UIColor whiteColor];
        _tipsLabel.hidden=YES;
        _tipsLabel.text=@"没有可领取优惠卷";
        _tipsLabel.textAlignment=NSTextAlignmentCenter;
        _tipsLabel.textColor=[UIColor colorWithWhite:0.735 alpha:0.898];
    }
    return _tipsLabel;
}
@end
