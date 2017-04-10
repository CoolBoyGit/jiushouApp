//
//  HomeCell1Btn.m
//  Youhu
//
//  Created by 脉融iOS开发 on 16/1/5.
//  Copyright (c) 2016年 Youhu. All rights reserved.
//

#import "TIBTButton.h"

@implementation TIBTButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{

}

- (UIImageView *)picImgView
{
    if (!_picImgView) {
        _picImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 35)/2, 15, 35, 25)];
        //_picImgView.backgroundColor = [UIColor clearColor];
        _picImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_picImgView];
    }
    return _picImgView;
}

- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.picImgView.bottom, self.width, 25)];
        _descLabel.font = [UIFont systemFontOfSize:10];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.textColor = RGB(9, 9, 9);
        [self addSubview:_descLabel];
    }
    return _descLabel;
}

@end
