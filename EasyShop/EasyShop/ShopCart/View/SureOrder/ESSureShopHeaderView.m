//
//  ESSureShopHeaderView.m
//  EasyShop
//
//  Created by guojian on 16/5/21.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESSureShopHeaderView.h"

@interface ESSureShopHeaderView ()

@property (nonatomic, strong) UILabel                   *shopName;
@property (nonatomic, strong) UIButton                  *editBtn;

@end

@implementation ESSureShopHeaderView

- (void)setShopInfo:(OrderConfirmShopInfo *)shopInfo
{
    _shopInfo = shopInfo;
    
    _shopName.text          = _shopInfo ? shopInfo.ddescription.shop_name : @"";
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.editBtn.alpha = 1.0f;
    self.shopName.alpha = 1.0f;
}

#pragma mark view init
- (UILabel *)shopName
{
    if (!_shopName) {
        _shopName = [[UILabel alloc] init];
        _shopName.backgroundColor = [UIColor clearColor];
        _shopName.text = @"";
        _shopName.font = [UIFont systemFontOfSize:14.f];
        _shopName.textColor=AllTextColor;
        [self.contentView addSubview:_shopName];
        [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@5);
            make.left.equalTo(@20);
            make.height.equalTo(@20);
            make.width.equalTo(@200);
        }];
    }
    return _shopName;
}

- (UIButton *)editBtn
{
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_editBtn setBackgroundColor:[UIColor clearColor]];
        [_editBtn setImage:[UIImage imageNamed:@"shopcart_selected_icon"] forState:UIControlStateNormal];
        [_editBtn setImage:[UIImage imageNamed:@"shopcart_selected_icon"] forState:UIControlStateSelected];
//        [self addSubview:_editBtn];
//        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(@0);
//            make.left.equalTo(self.contentView.mas_left).with.offset(10);
//            make.height.equalTo(@30);
//            make.width.equalTo(@30);
//        }];
    }
    return _editBtn;
}

@end
