//
//  HomeTitleView.m
//  O2BookStore
//
//  Created by 卢双 on 13-9-6.
//  Copyright (c) 2013年 卢双. All rights reserved.
//

#import "HomeTitleView.h"

#define TITLE_LABEL_RECT                CGRectMake(80, (20)+11, ScreenWidth-80*2, 18)

#define LEFT_IMAGE_RECT                 CGRectMake(10, (20)+12,15.5, 16.5)


@implementation HomeTitleView

- (id)initWithTile:(NSString *)title withBackRuturn:(BOOL)isBack
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)])
    {
        self.frame = CGRectMake(0, 0, ScreenWidth, 64);
        self.backgroundColor = [UIColor lightGrayColor];
        if (title) {
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:TITLE_LABEL_RECT];
            [titleLabel setBackgroundColor:[UIColor clearColor]];
            [titleLabel setTextAlignment:NSTextAlignmentCenter];
            [titleLabel setText:title];
            [titleLabel setFont:[UIFont systemFontOfSize:17]];
            [titleLabel setTextColor:[UIColor blackColor]];
            self.titleLabel = titleLabel;
            [self addSubview:titleLabel];

        }
        
        if (isBack)
        {
            UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            leftButton.frame = CGRectMake(5, (20)+4, 55, 64-(20)-4);
            [leftButton addTarget:self action:@selector(leftBtnCB) forControlEvents:UIControlEventTouchUpInside];
            leftButton.imageView.contentMode = UIViewContentModeCenter;
            [leftButton setImage:[UIImage imageNamed:@"left_back"] forState:UIControlStateNormal];
            [self addSubview:leftButton];
        }
        
    }
    return self;
}

- (void)setTitleView:(UIView *)titleView
{
    _titleView = titleView;
    titleView.center = CGPointMake(self.centerX, 42);
//    titleView.frame = CGRectMake(self.centerX, 42, titleView.frame.size.width, titleView.frame.size.height);
    [self addSubview:titleView];
}

- (void)setLeftView:(UIView *)leftView
{
    leftView.frame = CGRectMake(12,20+((44 - leftView.frame.size.height) / 2), leftView.frame.size.width,leftView.frame.size.height);
    [self addSubview:leftView];
}

- (void)setRightView:(UIView *)rightView
{
    rightView.frame = CGRectMake(ScreenWidth -rightView.frame.size.width - 12,20+((44 - rightView.frame.size.height) / 2), rightView.frame.size.width,rightView.frame.size.height);
    [self addSubview:rightView];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleView.center = CGPointMake(self.centerX, 42);
    
}


- (void)leftBtnCB
{
    if ([_delegate respondsToSelector:@selector(leftBtnPressed)]) {
        [_delegate leftBtnPressed];
    }
    
}

- (void)rightBtnCB
{
    
    if ([_delegate respondsToSelector:@selector(rightBtnPressed)]) {
        [_delegate rightBtnPressed];
    }
}


- (void)changeRightImageRect
{
//    [_rightBtn setFrame:CGRectMake(266, isIOS7?20:0, 30, TITLE_HEIGHT-10)];
}

@end
