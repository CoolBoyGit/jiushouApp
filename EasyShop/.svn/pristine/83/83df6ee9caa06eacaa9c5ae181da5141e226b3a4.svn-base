//
//  CanStarRatingView.m
//  MFBank
//
//  Created by lyywhg on 15/11/2.
//  Copyright © 2015年 MFBank. All rights reserved.
//

#import "CanStarRatingView.h"

@interface CanStarRatingView ()

@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;

@end

@implementation CanStarRatingView

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame numberOfStar:5];
}

- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number
{
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfStar = number;
        self.starBackgroundView = [self buidlStarViewWithImageName:@"backgroundStar"];
        self.starForegroundView = [self buidlStarViewWithImageName:@"foregroundStar"];
        [self addSubview:self.starBackgroundView];
        [self addSubview:self.starForegroundView];
    }
    return self;
}

- (void)updateStarRatingWithScore:(CGFloat)score
{
    CGPoint tPoint = CGPointMake((self.frame.size.width * score / _numberOfStar), 0);
    [self noUpdateChangeStarForegroundViewWithPoint:tPoint];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if(CGRectContainsPoint(rect,point))
    {
        [self changeStarForegroundViewWithPoint:point];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak CanStarRatingView * weekSelf = self;
    
    [UIView transitionWithView:self.starForegroundView
                      duration:0.2
                       options:UIViewAnimationOptionCurveEaseInOut
                    animations:^{
         [weekSelf changeStarForegroundViewWithPoint:point];
     } completion:^(BOOL finished) {
    
     }];
}

- (UIView *)buidlStarViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int i = 0; i < self.numberOfStar; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        //imageView.frame = CGRectMake(i * frame.size.width / self.numberOfStar, 0, frame.size.width / self.numberOfStar, frame.size.height);
        imageView.frame = CGRectMake(i * 40, 0, 20, frame.size.height);

        [view addSubview:imageView];
    }
    return view;
}

- (void)noUpdateChangeStarForegroundViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    if (p.x < 0)
    {
        p.x = 0;
    }
    else if (p.x > self.frame.size.width)
    {
        p.x = self.frame.size.width;
    }
    
    NSString * str = [NSString stringWithFormat:@"%0.2f",p.x / self.frame.size.width];
    float score = [str floatValue];
    
//    NSInteger iScore = ((NSInteger)((NSInteger)(score * 10)) / 5) * 5;
//    score = ((float)iScore) / 10;

    p.x = score * self.frame.size.width;
    self.starForegroundView.frame = CGRectMake(0, 0, p.x, self.frame.size.height);
}


- (void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    if (p.x < 0)
    {
        p.x = 0;
    }
    else if (p.x > self.frame.size.width)
    {
        p.x = self.frame.size.width;
    }
    
    NSString * str = [NSString stringWithFormat:@"%0.2f",p.x / self.frame.size.width];
    float score = [str floatValue];
    
//    NSInteger iScore = ((NSInteger)((NSInteger)(score * 10)) / 5) * 5;
//    score = ((float)iScore) / 10;
    //lcj start
    if (score > 0.93) {
        score = 1.0;
    }
    p.x = score * self.frame.size.width;
    self.starForegroundView.frame = CGRectMake(0, 0, p.x, self.frame.size.height);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(starRatingView: score:)])
    {
        [self.delegate starRatingView:self score:score];
    }
}

@end
