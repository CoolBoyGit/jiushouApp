//
//  ICKeyBoardTopView.m
//  Picker
//
//  Created by wcz on 15/12/11.
//  Copyright © 2015年 wcz. All rights reserved.
//

#import "ICKeyBoardTopView.h"

@implementation ICKeyBoardTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = RGBA(246, 246, 246, 1);
        [self initalizedView];
    }
    return self;
}

- (void)initalizedView
{
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    cancelButton.tag = 101;
    [cancelButton setTitleColor:RGBA(233, 40, 46, 1) forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(buttonBeTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
    UIButton *completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [completeButton setTitle:@"完成" forState:UIControlStateNormal];
    completeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    completeButton.tag = 102;
    [completeButton addTarget:self action:@selector(buttonBeTouch:) forControlEvents:UIControlEventTouchUpInside];
    [completeButton setTitleColor:RGBA(233, 40, 46, 1) forState:UIControlStateNormal];
    [self addSubview:completeButton];
    [completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.top.equalTo(@10);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
}

- (void)buttonBeTouch:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ICkeyBoardTopViewButtonBeClick:)])
    {
        [self.delegate ICkeyBoardTopViewButtonBeClick:button.tag - 100];
    }
}

@end
