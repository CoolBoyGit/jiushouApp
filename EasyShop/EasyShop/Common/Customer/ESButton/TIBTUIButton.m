//
//  PushView.m
//  MFBank
//
//  Created by mairong on 15/12/19.
//  Copyright © 2015年 MFBank. All rights reserved.
//

#import "TIBTUIButton.h"

@implementation TIBTUIButton

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
        _leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 27, 27)];
        _leftImg.contentMode = UIViewContentModeCenter;
        _leftImg.center= CGPointMake(self.width/2, 25);
        [self addSubview:_leftImg];
    }
    return _leftImg;
}

- (UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 63, self.width, 10)];
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.textAlignment=NSTextAlignmentCenter;
        _rightLabel.font = ADeanFONT11;
        
        _rightLabel.center=CGPointMake(self.width/2, self.leftImg.bottom+15);
        [self addSubview:_rightLabel];
    }
    return _rightLabel;
}
@end
