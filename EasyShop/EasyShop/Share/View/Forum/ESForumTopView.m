//
//  ESForumTopView.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/3.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESForumTopView.h"

@interface ESForumTopView()

@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;

@end

@implementation ESForumTopView

- (UIView *)line1
{
    if (_line1 == nil) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor redColor];
//        _line1.hidden = YES;
    }
    return _line1;
}

- (UIView *)line2
{
    if (_line2 == nil) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor redColor];
        _line2.hidden = YES;
    }
    return _line2;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setUpViews];
    }
    return self;
}

-(void)setUpViews
{
    
    NSArray *titleArr = @[@"论坛",@"分享"];
    UIButton *forumpageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forumpageButton setTitle:titleArr[0] forState:UIControlStateNormal];
    forumpageButton.tag = 0;
    [forumpageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forumpageButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [forumpageButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forumpageButton];
    [forumpageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.centerY.equalTo(@0);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    [self addSubview:self.line1];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.height.equalTo(@1);
        make.bottom.equalTo(@-5);
        make.centerX.equalTo(forumpageButton.mas_centerX);
    }];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setTitle:titleArr[1] forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:17];
    shareButton.tag = 1;
    [shareButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-12));
        make.centerY.equalTo(@0);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    [self addSubview:self.line2];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.height.equalTo(@1);
        make.bottom.equalTo(@-5);
        make.centerX.equalTo(shareButton.mas_centerX);
    }];
}

-(void)btnClick:(UIButton *)button
{
    if (button.tag == 0) {
        self.line1.hidden = NO;
        self.line2.hidden = YES;
    } else {
        self.line2.hidden = NO;
        self.line1.hidden = YES;
    }
    if (_buttonSelect) {
        _buttonSelect(button.tag);
    }
}

- (void)scrollviewToIndex:(NSInteger)index
{
    if (index == 0) {
        self.line1.hidden = NO;
        self.line2.hidden = YES;
    } else
    {
        self.line2.hidden = NO;
        self.line1.hidden = YES;

    }
}

@end
