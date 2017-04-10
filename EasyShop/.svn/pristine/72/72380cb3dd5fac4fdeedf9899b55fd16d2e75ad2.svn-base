
//
//  HomePushCell.m
//  MFBank
//
//  Created by mairong on 15/12/19.
//  Copyright © 2015年 MFBank. All rights reserved.
//

#import "ESForumPushCell.h"
#import "PushView.h"

@implementation ESForumPushCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    CGFloat w = ( ScreenWidth -20-3*10) / 4.f;
    for (int i = 0; i < 8; i++) {
        PushView *btn = [[PushView alloc] initWithFrame:CGRectMake(10 + (w+10)*(i%4), 10+ (i/4)*80, w, 75)];
        btn.tag = i;
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.cornerRadius = 5.0f;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn.imageView setContentMode:UIViewContentModeCenter];
        btn.leftImg.contentMode = UIViewContentModeScaleToFill;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.leftImg.image = [UIImage imageNamed:@"icon_home_cate"];
        btn.rightLabel.text = @"论坛";
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

+ (CGFloat)heightOfCell:(NSArray *)arr
{
    NSInteger h = arr.count % 4 == 0 ? arr.count / 4 : (arr.count / 4 + 1);
    return 85 * h;
}

@end
