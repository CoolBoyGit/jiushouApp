//
//  TipViewAnimation.m
//  EasyShop
//
//  Created by jiushou on 16/7/9.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "TipViewAnimation.h"
@interface TipViewAnimation()
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,strong) UILabel*label;
@end
@implementation TipViewAnimation


-(instancetype)initWithFrame:(CGRect)frame andTip:(NSString*)str{
    if (self=[super initWithFrame:frame]) {
        self.width=[str widthOfFont:[UIFont systemFontOfSize:15]];
        self.frame=kKeyWindow.frame;
        
        
        [self setUpView:str andFrame:frame];
    }
    
    return self;
}
-(void)setUpView:(NSString*)str andFrame:(CGRect)frame{

//    
    //self.backgroundColor=RGBA(245, 245, 245, 0.6);
    self.backgroundColor=[UIColor clearColor];
    self.label=[[UILabel alloc]init];
    self.label.textAlignment=NSTextAlignmentCenter;
    self.label.backgroundColor=RGBA(70, 70, 70, 1);
    self.label.textColor=[UIColor whiteColor];
    self.label.text=str;
    
    
    self.label.font=[UIFont systemFontOfSize:15];
    self.label.frame=CGRectMake((ScreenWidth-self.width-20)/2.0, -20, 0, 0);
    self.label.layer.cornerRadius=10;
    self.label.layer.masksToBounds=YES;
    [self addSubview:self.label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        
    });


}
-(void)show{
    [kKeyWindow addSubview:self];
    [UIView animateWithDuration:1 animations:^{
        self.label.frame=CGRectMake((ScreenWidth-self.width-20)/2.0, kKeyWindow.centerY-80, self.width+20, 40);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
