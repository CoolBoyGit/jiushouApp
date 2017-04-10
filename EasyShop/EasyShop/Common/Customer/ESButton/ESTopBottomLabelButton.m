//
//  ESTopBottomLabelButton.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/28.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESTopBottomLabelButton.h"

@implementation ESTopBottomLabelButton
-(instancetype)init{
    if (self=[super init]) {
        [self addSubview:self.topLabel];
        [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@8);
            make.centerX.equalTo(self.mas_centerX).offset(0);
            make.height.equalTo(@12);
        }];
        [self addSubview:self.bottomLbel];
        [self .bottomLbel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topLabel.mas_bottom).offset(8);
            make.height.equalTo(@10);
            make.centerX.equalTo(self.mas_centerX).offset(0);

        }];
    }
    return self;
}
-(UILabel *)topLabel{
    if (_topLabel==nil) {
        _topLabel=[[UILabel alloc]init];
        _topLabel.backgroundColor = [UIColor clearColor];
        _topLabel.textAlignment=NSTextAlignmentCenter;
        _topLabel.font = ADeanFONT15;
        _topLabel.textColor = [UIColor whiteColor];
    }
    return _topLabel;
}
-(UILabel *)bottomLbel{
    if (_bottomLbel==nil) {
        _bottomLbel=[[UILabel alloc]init];
        _bottomLbel.textColor=[UIColor whiteColor];
        _bottomLbel.textAlignment=NSTextAlignmentCenter;
        _bottomLbel.backgroundColor=[UIColor clearColor];
        _bottomLbel.font=[UIFont systemFontOfSize:15];
        
    }
    return _bottomLbel;
}
@end
