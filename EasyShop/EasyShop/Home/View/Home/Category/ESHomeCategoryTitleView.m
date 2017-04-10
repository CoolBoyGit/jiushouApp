//
//  ESHomeCategoryTitleView.m
//  EasyShop
//
//  Created by wcz on 16/3/26.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESHomeCategoryTitleView.h"

@implementation ESHomeCategoryTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = ADeanHEXCOLOR(0xeeeeee).CGColor;
        self.backgroundColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.text = @"精品推荐";
        self.textColor =AllTextColor;
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

@end
