//
//  ESShopCommentReusableView.m
//  EasyShop
//
//  Created by wcz on 16/6/5.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShopCommentReusableView.h"

@interface ESShopCommentReusableView ()

@property (nonatomic, strong) UILabel *rateLabel;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic,strong) NSMutableArray*buttonArray;
@end

@implementation ESShopCommentReusableView
-(NSMutableArray *)buttonArray{
    if (_buttonArray==nil) {
        _buttonArray=[[NSMutableArray alloc]init];
        
    }
    return _buttonArray;
}
- (UILabel *)rateLabel
{
    if (_rateLabel == nil) {
        _rateLabel = [[UILabel alloc]init];
        _rateLabel.textColor = [UIColor blackColor];
        _rateLabel.font = [UIFont systemFontOfSize:14];
        _rateLabel.layer.cornerRadius=3 ;
        _rateLabel.layer.masksToBounds=YES;
        _rateLabel.backgroundColor=RGB(245, 245, 245);
    }
    return _rateLabel;
}

- (UIView *)backView
{
    if (_backView == nil) {
        _backView = [[UIView alloc]init];
    }
    return _backView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initalizedView];
    }
    return self;
}

- (void)initalizedView
{
//    [self addSubview:self.rateLabel];
//    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@12);
//        make.top.equalTo(@8);
//        make.height.equalTo(@25);
//    }];
    [self addSubview:self.backView ];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@5);
    }];
}

- (void)setEvluationInfo:(EvaluationInfo *)evluationInfo
{
    _evluationInfo = evluationInfo;
    
    for (UIView *view in self.backView.subviews) {
        [view removeFromSuperview];
    }
    int count = _evluationInfo.count.intValue;
    int good  = _evluationInfo.good_count.intValue;
    int img   = _evluationInfo.img_count.intValue;
    int rate  = count > 0 ? (good / count)*100 : 0;
    self.rateLabel.text = [NSString stringWithFormat:@"%d%% 的好评",rate];
    
    NSArray *array = @[[NSString stringWithFormat:@"全部(%d)",count],
                       [NSString stringWithFormat:@"好评(%d)",good],
                       [NSString stringWithFormat:@"图片(%d)",img],
                       ];
    for (int i = 0; i < array.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10 + ((80)*(i%3)), 30 * (i / 3), 70, 30);
        //button.layer.borderWidth = .5;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
       // button.layer.borderColor = RGB(233, 40, 46).CGColor;
        button.layer.cornerRadius=3;
        button.layer.masksToBounds=YES;
        [button setTitleColor:AllTextColor forState:UIControlStateNormal];
        button.tag=100+i;
        if (button.tag==100) {
            button.selected=YES;
        }
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"comment_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"comment_select"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitle:array[i] forState:UIControlStateNormal];
        [self.buttonArray addObject:button];
        [self.backView addSubview:button];
        
    }
}
-(void)buttonAction:(UIButton *)button{
    for (UIButton*button in self.buttonArray) {
        button.selected=NO;
    }
    button.selected=YES;
}

@end
