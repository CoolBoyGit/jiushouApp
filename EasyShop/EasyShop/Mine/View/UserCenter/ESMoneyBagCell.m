//
//  ESMoneyBagCell.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/9.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESMoneyBagCell.h"
#import "TTBTUIButton.h"

@implementation ESMoneyBagCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setTopTitleArr:(NSArray *)topTitleArr
{
    _topTitleArr = topTitleArr;
    int count = (int)topTitleArr.count;
    CGFloat w = ScreenWidth / count;
    for (int i = 0; i < count; i++) {
        TTBTUIButton *btn = [[TTBTUIButton alloc]initWithFrame:CGRectMake(w*(i%5), 0, w, 65)];
        btn.tag = i;
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = 5.0f;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.topLabel.text = topTitleArr[i];
        btn.bottonLabel.text = self.bottonTitleArr[i];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
    }
}
- (void)btnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (_delegate && [_delegate respondsToSelector:@selector(clickHomePush:)]) {
        [_delegate clickHomePush:btn.tag];
    }
}


@end
