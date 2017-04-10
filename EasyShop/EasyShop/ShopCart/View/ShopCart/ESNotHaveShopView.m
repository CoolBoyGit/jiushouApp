//
//  ESNotHaveShopView.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/8.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESNotHaveShopView.h"

@interface ESNotHaveShopView()

@property (nonatomic, strong) UILabel *promptLab;
@property (nonatomic, strong) UIButton *gotoSeeShop;

@end

@implementation ESNotHaveShopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.promptLab];
        [self.promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(@80);
            make.height.equalTo(@20);
        }];
        
        [self addSubview:self.gotoSeeShop];
        [self.gotoSeeShop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(self.promptLab.mas_bottom).with.offset(10);
            make.height.equalTo(@30);
            make.width.equalTo(@100);
        }];
    }
    return self;
}

-(UILabel *)promptLab
{
    if (!_promptLab) {
        _promptLab = [[UILabel alloc] init];
        _promptLab.text = @"购物车还没有商品，快去逛逛吧。";
        _promptLab.textAlignment = NSTextAlignmentCenter;
        _promptLab.font = [UIFont systemFontOfSize:20];
    }
    return _promptLab;
}

-(UIButton *)gotoSeeShop
{
    if (!_gotoSeeShop) {
        _gotoSeeShop = [UIButton buttonWithType:UIButtonTypeCustom];
        [_gotoSeeShop setTitle:@"去逛逛" forState:UIControlStateNormal];
        _gotoSeeShop.titleLabel.font = [UIFont systemFontOfSize:22];
        [_gotoSeeShop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _gotoSeeShop.backgroundColor = ADeanHEXCOLOR(0xcccccc);
        [_gotoSeeShop addTarget:self action:@selector(gotoSeeShopAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gotoSeeShop;
}

-(void)gotoSeeShopAction
{
    
}

@end
