//
//  ESComPraiseCell.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/4/29.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESComPraiseCell.h"

@implementation ESComPraiseCell

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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"heartLove_Circle"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"rightBtn_Circle"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@10);
        make.width.height.mas_equalTo(@(15));
        make.centerY.mas_equalTo(@0);
    }];
    
    for (int i = 0 ; i < 6; i++) {
        UIImageView *headImg = [[UIImageView alloc] init];
        headImg.layer.cornerRadius = 20;
        headImg.layer.masksToBounds = YES;
        headImg.image = [UIImage imageNamed:@"icon_home_cate"];
        [self.contentView addSubview:headImg];
        [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@(30+45*i));
            make.width.height.mas_equalTo(@(40));
            make.centerY.mas_equalTo(@0);
        }];
    }
    
    UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
    [more setTitle:@"13" forState:UIControlStateNormal];
    more.backgroundColor = [UIColor redColor];
    more.titleLabel.font = [UIFont systemFontOfSize:11];
    [more setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    more.layer.cornerRadius = 10;
    more.layer.masksToBounds = YES;
    [more setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [more addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:more];
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@20);
        make.height.mas_equalTo(@(20));
        make.width.mas_equalTo(@(80));
        make.centerY.mas_equalTo(@0);
    }];
}

-(void)btnClick:(UIButton *)button
{
    button.selected = !button.selected;
}
-(void)more
{
    
}

@end
