//
//  LIRTUIButton.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/12.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "LIRTUIButton.h"

@implementation LIRTUIButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self addSubview:self.leftImg];
    [self addSubview:self.rightLabel];
}

#pragma mark -
- (UIImageView *)leftImg
{
    if (!_leftImg) {
        _leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2.0-30, 0, 30, 20)];
        _leftImg.contentMode = UIViewContentModeScaleAspectFit;
        _leftImg.center=CGPointMake(self.width/2-15, self.height/2);
        [self addSubview:_leftImg];
    }
    return _leftImg;
}

- (UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2.0+5, 0, self.width, self.height)];
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.textAlignment=NSTextAlignmentLeft;
        _rightLabel.font = ADeanFONT14;
        _rightLabel.textColor=RGB(70, 70, 70);
        [self addSubview:_rightLabel];
    }
    return _rightLabel;
}

@end
