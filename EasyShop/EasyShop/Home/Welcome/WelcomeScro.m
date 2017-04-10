//
//  WelcomeScro.m
//  EasyShop
//
//  Created by jiushou on 16/8/13.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "WelcomeScro.h"
@interface WelcomeScro()<UIScrollViewDelegate>
@property (nonatomic,copy) GoBlock block;

@end
@implementation WelcomeScro
-(id)initWithImageArray:(NSArray *)imageArray andFrame:(CGRect)frame andBlock:(GoBlock)block{
    
    if (self=[super init]) {
        self.frame=frame;
        [self createUIWithImageArray:imageArray];
        self.block=block;
        
        
    }
    return self;
}
-(void)createUIWithImageArray:(NSArray*)array{
    UIScrollView*scro=[[UIScrollView alloc]initWithFrame:self.bounds];
    scro.backgroundColor=[UIColor whiteColor];
    scro.contentSize=CGSizeMake((array.count)*ScreenWidth, ScreenHeight);
    scro.bounces=NO;
    scro.pagingEnabled=YES;
    scro.showsHorizontalScrollIndicator=YES;
    scro.delegate=self;
    for (int i=0; i<array.count; i++) {
        UIImageView*imageVie=[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, ScreenHeight)];
        imageVie.image=[UIImage imageNamed:array[i]];
        imageVie.userInteractionEnabled=YES;
        [scro addSubview:imageVie];
        if (i==array.count -1) {
            UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBack)];
            [imageVie addGestureRecognizer:tap];
        }
        
        
    }
    [self addSubview:scro];
}
-(void)goBack{
    self.block();
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
