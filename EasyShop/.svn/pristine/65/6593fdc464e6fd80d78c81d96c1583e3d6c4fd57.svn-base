




//
//  ESShareHeaderView.m
//  EasyShop
//
//  Created by wcz on 16/5/26.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShareHeaderView.h"

@interface ESShareHeaderView ()

@end

@implementation ESShareHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self initlizedView];
    }
    return self;
}

- (void)initlizedView
{
    NSArray *titleArray = @[@"默认",@"热评",@"关注"];
    
    CGFloat width = (ScreenWidth - 20 )/ 3;
    
    for (int i = 0; i < titleArray.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10 + width *i, 0, width, 44);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor ]forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:button];
    }
}

@end
