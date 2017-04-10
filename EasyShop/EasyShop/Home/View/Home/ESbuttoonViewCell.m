//
//  ESbuttoonViewCell.m
//  EasyShop
//
//  Created by jiushou on 16/6/7.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESbuttoonViewCell.h"
@interface ESbuttoonViewCell()
@property(nonatomic,strong)UILabel*moreLabel;
@property(nonatomic,strong)UILabel*seeMoreLabel;
@property(nonatomic,strong)UIView*lineView;
@property(nonatomic,strong)UIView*bgView;
@end
@implementation ESbuttoonViewCell
-(UILabel*)moreLabel{
    if (_moreLabel==nil) {
        _moreLabel=[[UILabel alloc]init];
        _moreLabel.textAlignment=NSTextAlignmentCenter;
        _moreLabel.text=@"查看更多";
        _moreLabel.textColor=RGB(233, 40, 46);
        _moreLabel.font=[UIFont systemFontOfSize:14];
//        _moreLabel.layer.borderColor=RGB(90, 90, 90).CGColor;//
//        _moreLabel.layer.borderWidth=0.8f;
        
    }
    return _moreLabel;
}
-(UILabel *)seeMoreLabel{
    if (_seeMoreLabel==nil) {
        _seeMoreLabel=[[UILabel alloc]init];
        _seeMoreLabel.textColor=RGB(100, 100, 100);
        _seeMoreLabel.text=@"See more";
        _seeMoreLabel.font=[UIFont systemFontOfSize:13];
    }
    return _seeMoreLabel;
        
}
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=RGB(140, 140, 140);
    }
    return _lineView;
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]init];
        _bgView.layer.borderWidth=0.8f;
        _bgView.layer.borderColor=RGB(120, 120, 120).CGColor;
    }
    return _bgView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self.contentView addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX).offset(-10                         );
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(120, 120));
        }];
        [self.bgView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView.mas_centerX);
            make.centerY.equalTo(self.bgView.mas_centerY);
            make.width.equalTo(@50);
            make.height.equalTo(@0.6);
        }];
        [self.bgView addSubview:self.moreLabel];
        [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView.mas_centerX);
            make.bottom.equalTo(self.lineView.mas_top).offset(-3);
        }];
        [self.bgView addSubview:self.seeMoreLabel];
        [self.seeMoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView.mas_centerX);
            make.top.equalTo(self.lineView.mas_bottom).offset(2);
        }];
    }
    return self;
}
@end
