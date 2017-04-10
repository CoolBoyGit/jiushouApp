//
//  ESShopDetailHeaderTitleView.m
//  EasyShop
//
//  Created by wcz on 16/3/31.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShopDetailHeaderTitleView.h"

@interface ESShopDetailHeaderTitleView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView*linieView;
@property (nonatomic,strong) UIView*topView;
@end

@implementation ESShopDetailHeaderTitleView
-(void)setIsShowLine:(BOOL)isShowLine{
    //self.linieView.hidden=isShowLine;
}
-(UIView*)linieView{
    if (_linieView==nil) {
        _linieView=[[UIView alloc]init];
        _linieView.backgroundColor=KCommontLineViewBagroudColor;
    }
    return _linieView;
}
- (UIButton *)button
{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button addTarget:self action:@selector(buttonBetouch) forControlEvents:UIControlEventTouchUpInside];
        [_button setImage:[UIImage imageNamed:@"icon_home_arrow"] forState:UIControlStateNormal];
    }
    return _button;
}
-(UIView *)topView{
    if (_topView==nil) {
        _topView=[[UIView alloc]init];
        _topView.backgroundColor=RGB(245, 245, 245);
    }
    return _topView;
}
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = ADeanFONT15;
        _titleLabel.text = @"商品详情";
        _titleLabel.textColor = ADeanHEXCOLOR(0x999999);
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.topView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.left.right.equalTo (@0);
            make.top.equalTo(@0);
            
        }];
        [self addSubview:self.titleLabel];
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.mas_centerY).offset(5);
            make.left.equalTo(@15);
        }];
        
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-3));
            make.width.equalTo(@30);
            make.centerY.equalTo(self.mas_centerY).offset(5);
            make.height.equalTo(@30);
        }];

        [self addSubview:self.linieView];
        [self.linieView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.left.equalTo(@0);
            make.right.equalTo(@(0));
            make.bottom.equalTo(@0);
        }];
    }
    return self;
}
-(void)tapAction{
    if (self.tapBlock) {
        self.tapBlock();
    }
}
- (void)buttonBetouch
{
    if (_callBack) {
        _callBack ();
    }
}

- (void)setModel:(id)model
{
    self.titleLabel.text = model;
}

@end
