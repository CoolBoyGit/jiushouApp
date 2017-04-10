//
//  ESComBottonView.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/3.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESComBottonView.h"
#import "CreateCommentViewController.h"
#import "AppDelegate+ESExtension.h"

@implementation ESComBottonView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setUpViews];
    }
    return self;
}

-(void)setUpViews
{
    NSArray *titleArr = @[@"9",@"13",@"分享"];
    NSArray *imageArr = @[@"share_duihua",@"share_xihuan2",@"share_fenxiang2"];
    for (int i = 0; i < 3; i++) {
        CGFloat W = ScreenWidth / 3.0f;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(W*i, 0, W, 30);
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
        button.imageView.width = 15;
        button.imageView.height = 15;
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.imageEdgeInsets = UIEdgeInsetsMake(7, 0, 8, 0);
        [self addSubview:button];
    }
}

-(void)btnClick:(UIButton *)button
{
    CreateCommentViewController *vc = [[CreateCommentViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [[AppDelegate shared] pushViewController:vc animated:YES];
}

@end
