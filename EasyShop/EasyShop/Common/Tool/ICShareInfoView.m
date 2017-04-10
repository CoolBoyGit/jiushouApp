
//
//  ICShareInfoView.m
//  iCarePregnant
//
//  Created by wcz on 16/5/23.
//  Copyright © 2016年 oenius. All rights reserved.
//

#import "ICShareInfoView.h"
#import "TIBTButton.h"

@interface ICShareInfoView ()

@property (nonatomic, strong) NSArray *array;
@property (nonatomic,strong) UIView* bgView;
@end

@implementation ICShareInfoView

- (NSArray *)array
{
    if (_array == nil) {
        _array = @[
                   @{
                    @"title":@"朋友圈",
                    @"image":@"share_friend",
                    },
                   @{
                       @"title":@"微信",
                       @"image":@"share_wechat",
                       },
//                   @{
//                       @"title":@"微博",
//                       @"image":@"loginWithOther2",
//                       },
                   @{
                       @"title":@"复制链接",
                       @"image":@"share_copy",
                       },
                   
                   ];
    }
    return _array;
}

- (void)showPopView
{
     [kKeyWindow addSubview:self.bgView];
    [kKeyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame=CGRectMake(0, ScreenHeight-160, ScreenWidth,160 );
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidePopView
{
    
    [self.bgView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 160);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
   
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor=RGBA(226, 226, 226, 1);
        self.bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-100)];
        self.bgView.backgroundColor=RGBA(63, 62, 60,0.5);
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePopView)];
        [self.bgView addGestureRecognizer:tap];
            [self intalizedView];
    }
    return self;
}

- (void)intalizedView
{
    CGFloat width = ScreenWidth / 4;
    for (int i = 0; i < 3; i ++)
    {
        TIBTButton *button = [[TIBTButton alloc] initWithFrame:CGRectMake(width * i, 5, width, width - 15)];
        button.descLabel.text = self.array[i][@"title"];
        button.picImgView.image = [UIImage imageNamed:self.array[i][@"image"]];
        button.picImgView.contentMode = UIViewContentModeScaleAspectFit;
        button.picImgView.frame = CGRectMake(0, 5, button.bounds.size.width, button.bounds.size.height - 35);

        button.descLabel.frame = CGRectMake(0, CGRectGetMaxY(button.picImgView.frame) + 5, button.bounds.size.width, 20);
        button.descLabel.font = [UIFont systemFontOfSize:13];
        button.descLabel.textColor=AllTextColor;
        button.tag = i;
        [button addTarget:self action:@selector(selectShareButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (button.tag==0||button.tag==1) {
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                
                
            }else {
                button.hidden=YES;
                
            }
            
        
        }
        
        

    }
    UILabel*label=[[UILabel alloc]init];
    label.text=@"取消";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:15];
    label.backgroundColor=[UIColor whiteColor];
    label.textColor=AllTextColor;
    label.userInteractionEnabled=YES;
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelButton)];
    [self addSubview:label];
    [label addGestureRecognizer:tap];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@40);
    }];
}

- (void)cancelButton
{
    [self hidePopView];
}

- (void)selectShareButton:(UIButton *)button
{
    if (_selectShareButton)
    {
        _selectShareButton(button.tag);
    }
    [self hidePopView];
}

@end
