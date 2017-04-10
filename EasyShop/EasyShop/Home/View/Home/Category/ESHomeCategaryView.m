


//
//  ESHomeCategaryView.m
//  EasyShop
//
//  Created by wcz on 16/3/26.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESHomeCategaryView.h"
#import "TIBTButton.h"

@implementation ESHomeCategaryView


- (instancetype)initWithFrame:(CGRect)frame
{
self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
    }
    return self;
}

-(void)setUpViews
{
    //NSArray *images = @[@"home_categary1",@"home_categary2",@"home_categary3",@"home_categary4"];
    NSArray *images = @[@"home_categary1",@"home_categary2",@"home_categary3"];
    //NSArray *title = @[@"全球海购",@"限时抢购",@"每日上新",@"限时包邮"];
    NSArray *title = @[@"限时抢购",@"超级拼团",@"每日上新"];

    self.backgroundColor = [UIColor whiteColor];
    CGFloat w =  (ScreenWidth - 20) / 3.f;
    
    for (int i = 0; i < title.count; i++) {
        TIBTButton *btn = [[TIBTButton alloc]initWithFrame:CGRectMake( 10 + i*w, 0, w, 80)];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.picImgView.image = [UIImage imageNamed:images[i]];
        btn.descLabel.text = title[i];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:btn];
    }
}

-(void)btnClick:(TIBTButton *)btn
{
    if ([self glassButtonClickBlock]) {
        [self glassButtonClickBlock]((ProductCategary)btn.tag);
    }
}
@end
