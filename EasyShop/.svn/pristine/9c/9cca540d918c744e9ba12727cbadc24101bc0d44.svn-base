//
//  ESShareFunctionCell.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/18.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShareFunctionCell.h"

@interface ESShareFunctionCell()

@property (nonatomic, strong) UILabel  *bottonLine;

@end

@implementation ESShareFunctionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpViews];
    }
    return self;
}

-(void)setUpViews
{
    NSArray *array = @[@"汇总",@"关注",@"精选"];
    CGFloat W = ScreenWidth/array.count;
    for (int i = 0; i < array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(W*i, 0, W, 42);
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i ;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
    }
    
//    self.bottonLine = [[UILabel alloc] initWithFrame:CGRectMake((W-40)/2.0, 43, 40, 1)];
//    self.bottonLine.backgroundColor = [UIColor blackColor];
//    [self.contentView addSubview:self.bottonLine];
}

-(void)btnClick:(UIButton *)btn
{
    //CGFloat W = ScreenWidth/5.0f;
    //int count = (int)btn.tag;
//    self.bottonLine.frame = CGRectMake((W-40)/2.0+count*W, 43, 40, 1);
}

@end
