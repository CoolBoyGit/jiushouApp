//
//  ESComShopListCell.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/4/29.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESComShopListCell.h"

@interface ESComShopListCell()

@property (nonatomic, strong) UIImageView *shopImg;//商品图像
@property (nonatomic, strong) UILabel     *shopNameLab;//时间
@property (nonatomic, strong) UIImageView *arrowImg;//位置图像
@property (nonatomic, strong) UILabel     *preceLab;//价格

@end

@implementation ESComShopListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpViews
{
    UIView *BG = [[UIView alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth-20, 50)];
    BG.backgroundColor = ADeanHEXCOLOR(0xcccccc);
    [self.contentView addSubview:BG];
    
    [BG addSubview:self.shopImg];
    [self.shopImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(@5);
        make.width.height.mas_equalTo(@(40));
    }];
    
    [BG addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@-5);
        make.width.mas_equalTo(@(10));
        make.height.mas_equalTo(@(20));
        make.centerY.mas_equalTo(@0);
    }];
    
    [BG addSubview:self.shopNameLab];
    [self.shopNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.mas_equalTo(@10);
        make.left.mas_equalTo(self.shopImg.mas_right).offset(5);
        make.width.mas_equalTo(@(200));
    }];
    
    [BG addSubview:self.preceLab];
    [self.preceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@10);
        make.bottom.mas_equalTo(@-10);
        make.left.mas_equalTo(self.shopImg.mas_right).offset(5);
        make.width.mas_equalTo(@(100));
    }];
}


-(UIImageView *)shopImg
{
    if (!_shopImg) {
        _shopImg = [[UIImageView alloc] init];
        _shopImg.image = [UIImage imageNamed:@"share_shop"];
    }
    return _shopImg;
}
-(UIImageView *)arrowImg
{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.image = [UIImage imageNamed:@"share_arrow"];
    }
    return _arrowImg;
}
-(UILabel *)shopNameLab
{
    if (!_shopNameLab) {
        _shopNameLab = [[UILabel alloc] init];
        _shopNameLab.text = @"15分钟前";
        _shopNameLab.font = [UIFont systemFontOfSize:13];
        _shopNameLab.textColor = [UIColor blackColor];
    }
    return _shopNameLab;
}
-(UILabel *)preceLab
{
    if (!_preceLab) {
        _preceLab = [[UILabel alloc] init];
        _preceLab.text = @"15分钟前";
        _preceLab.font = [UIFont systemFontOfSize:13];
        _preceLab.textColor = [UIColor blackColor];
    }
    return _preceLab;
}
//-(UIImageView *)timeImg
//{
//    if (!_timeImg) {
//        _timeImg = [[UIImageView alloc] init];
//        _timeImg.backgroundColor = [UIColor redColor];
//    }
//    return _timeImg;
//}

@end
