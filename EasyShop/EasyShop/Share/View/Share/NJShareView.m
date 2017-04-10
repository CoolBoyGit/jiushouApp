//
//  NJShareView.m
//  CBWallet4iPhone
//
//  Created by CocoaKier on 14-5-7.
//  Copyright (c) 2014年 chinabank payments. All rights reserved.
//

#import "NJShareView.h"

#pragma mark - NJShareView

#define btnTitle                        @"btnTitle"
#define btnNormalImage                  @"btnNormalImage"
#define btnPressedImage                 @"btnPressedImage"

@interface NJShareView ()
{
    NSArray                     *_dataArray;
    UIView                      *_bottomView;
}
@end

@implementation NJShareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.bounds.size.width,[UIApplication sharedApplication].keyWindow.bounds.size.height);
        
        NSDictionary *dic1 = @{btnTitle: @"朋友圈",btnNormalImage:@"loginWithOther0",btnPressedImage:@"loginWithOther0"};
        NSDictionary *dic2 = @{btnTitle: @"微信好友",btnNormalImage:@"loginWithOther1",btnPressedImage:@"loginWithOther1"};
        NSDictionary *dic3 = @{btnTitle: @"新浪微博",btnNormalImage:@"loginWithOther2",btnPressedImage:@"loginWithOther2"};
        _dataArray = @[dic1,dic2,dic3];
        
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    UIView *bgView = [[UIView alloc] initWithFrame:self.frame];
    bgView.backgroundColor =  ADeanHEXCOLOR(0x000000);
    bgView.layer.opacity = 0.6;
    [self addSubview:bgView];
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 175, ScreenWidth, 175)];
    _bottomView.backgroundColor = ADeanHEXCOLOR(0xffffff);
    [self addSubview:_bottomView];
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 175 - 46, ScreenWidth, 1);
    line.backgroundColor = ADeanHEXCOLOR(0xdcdcdc);
    [_bottomView addSubview:line];
    
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 20)];
    tipsLabel.text = @"分享到";
    tipsLabel.textColor = ADeanHEXCOLOR(0x919191);;
    tipsLabel.font = [UIFont systemFontOfSize:17.0];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    [_bottomView addSubview:tipsLabel];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 175 - 46, ScreenWidth, 46);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:19.0];
    [cancelBtn setTitleColor:ADeanHEXCOLOR(0x47a8cf) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:cancelBtn];
    
    for (int i = 0; i < 3; i ++) {
        NSDictionary *dic = _dataArray[i];
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [shareBtn setTitle:dic[btnTitle] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:dic[btnNormalImage]] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:dic[btnPressedImage]] forState:UIControlStateHighlighted];
        shareBtn.tag = i;
        [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        shareBtn.frame = CGRectMake((ScreenWidth - 86 * 3 + 33) / 2.f + (53 + 33) * i, 75 / 2, 53, 53);
        [_bottomView addSubview:shareBtn];
        
        UILabel *title = [[UILabel alloc] init];
        title.text = dic[btnTitle];
        title.textColor =  ADeanHEXCOLOR(0x919191);
        title.font = [UIFont systemFontOfSize:11];
        title.backgroundColor = [UIColor clearColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.frame = CGRectMake((ScreenWidth - 88 * 3 + 27) / 2.f + (61 + 27) * i, 75 / 2  + 53 + 10 ,61, 20);
        [_bottomView addSubview:title];
    }
}

- (void)shareAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (_delegate && [_delegate respondsToSelector:@selector(shareToPlatform:)]) {
//        [_delegate shareToPlatform:btn.tag];
    }
    [self hidden];
}

- (void)cancelBtnAction
{
    [self hidden];
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.layer.opacity = 1.0;
    _bottomView.frame = CGRectMake(0, self.frame.size.height, ScreenWidth, 175);
    [UIView animateWithDuration:0.5 animations:^{
        _bottomView.frame = CGRectMake(0, self.frame.size.height - 175, ScreenWidth, 175);
    }];
}

- (void)hidden
{
    [UIView animateWithDuration:0.3 animations:^{
        self.layer.opacity = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self hidden];
}


@end
