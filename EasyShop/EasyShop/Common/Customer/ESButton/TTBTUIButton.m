//
//  TTBTUIButton.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/9.
//  Copyright © 2016年 wcz. All rights reserved.
//  上下都是文字的.

#import "TTBTUIButton.h"

@implementation TTBTUIButton

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
    [self addSubview:self.topLabel];
    [self addSubview:self.bottonLabel];
}

#pragma mark -
- (UILabel *)topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 30, 25)];
        _topLabel.backgroundColor = [UIColor clearColor];
        _topLabel.textAlignment=NSTextAlignmentCenter;
        _topLabel.font = ADeanFONT12;
        _topLabel.textColor = ADeanHEXCOLOR(0x333333);
        _topLabel.center=CGPointMake(self.width/2, 25);
        [self addSubview:_topLabel];
    }
    return _topLabel;
}
- (UILabel *)bottonLabel
{
    if (!_bottonLabel) {
        _bottonLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 63, self.width, 10)];
        _bottonLabel.backgroundColor = [UIColor clearColor];
        _bottonLabel.textAlignment=NSTextAlignmentCenter;
        _bottonLabel.font = ADeanFONT12;
        _bottonLabel.textColor = ADeanHEXCOLOR(0x333333);
        _bottonLabel.center=CGPointMake(self.width/2, self.topLabel.bottom+12);
        [self addSubview:_bottonLabel];
    }
    return _bottonLabel;
}

-(void)setImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets{
    
    
}
-(void)setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets{
    
}
@end
