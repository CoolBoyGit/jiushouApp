//
//  TypeView.m
//  WCZ
//
//  Created by Bigzone on 16/6/24.
//  Copyright © 2016年 Bigzone. All rights reserved.
//

#import "TypeView.h"

@implementation TypeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat Bwidth = ([UIScreen mainScreen].bounds.size.width - 60) / 3;
        CGFloat Bheight = 40;
        NSArray *arr = @[@"软件问题",@"物流问题",@"商品问题",@"退换货问题",@"其他问题"];
        for (int i = 0; i < 5; i++) {
            NSInteger x = i % 3;
            NSInteger y = i / 3;
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20 + (Bwidth+ 20) * x, 25 + (Bheight + 25) * y, Bwidth, Bheight)];
            [self addSubview:btn];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f].CGColor;
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 0) {
                btn.selected = YES;
                btn.backgroundColor = [UIColor blackColor];
                self.myProblem = (allProblems)0;
            }
        }
    }
    return self;
}
- (void)click:(UIButton *)btn {
   
    for (UIButton * button in self.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            button.selected = NO;
            button.backgroundColor = [UIColor whiteColor];
        }
    }
    
    btn.selected = YES;
    btn.backgroundColor = [UIColor blackColor];
    _myProblem = (allProblems)(btn.tag - 100);
}
@end
