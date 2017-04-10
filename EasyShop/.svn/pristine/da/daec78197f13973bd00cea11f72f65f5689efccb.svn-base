//
//  ESComFunctionCell.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/4/29.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESComFunctionCell.h"
#import "AppDelegate+ESExtension.h"
#import "CreateCommentViewController.h"

@implementation ESComFunctionCell

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
    NSArray *titleArr = @[@"私聊",@"喜欢",@"分享",@""];
    NSArray *imageArr = @[@"share_siliao",@"share_xihuan",@"share_fenxiang",@"share_dian"];
    for (int i = 0; i < 4; i++) {
        CGFloat W = ScreenWidth / 4.0f;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(W*i, 12, W, 20);
        button.tag = i;
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 5);
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:button];
    }
}

-(void)btnClick:(UIButton *)button
{
    if (button.tag == 2) {
        CreateCommentViewController *vc = [[CreateCommentViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [[AppDelegate shared] pushViewController:vc animated:YES];
    }
}

@end
