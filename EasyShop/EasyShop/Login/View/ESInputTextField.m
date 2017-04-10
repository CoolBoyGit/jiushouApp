


//
//  ESInputTextField.m
//  EasyShop
//
//  Created by wcz on 16/4/3.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESInputTextField.h"

@interface ESInputTextField()<UITextFieldDelegate>

/** 底部分割线 */
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UIImageView*imageView;
@property (nonatomic,strong) UIButton*mobileButton;
@property (nonatomic,strong) UIButton*passWordButton;
@end

@implementation ESInputTextField
-(void)setIsHiden:(BOOL)isHiden{
    self.mobileButton.hidden=YES;
    self.passWordButton.hidden=YES;

}

-(void)setIsHiddenButton:(BOOL)isHiddenButton{
    if (isHiddenButton) {
        self.mobileButton.hidden=YES;
        self.passWordButton.hidden=NO;
    }else{
        self.passWordButton.hidden=YES;
        self.mobileButton.hidden=NO;
    }
}
-(UIButton *)passWordButton{
    if (_passWordButton==nil) {
        _passWordButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _passWordButton.frame=CGRectMake(ScreenWidth-73, 7, 25, 25);
        [_passWordButton setBackgroundImage:[UIImage imageNamed:@"loginhiddenPassWord"] forState:UIControlStateNormal];
        [_passWordButton setBackgroundImage:[UIImage imageNamed:@"loginshowPassWord"] forState:UIControlStateSelected];
        [_passWordButton addTarget:self action:@selector(passWordButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _passWordButton.hidden=YES;
    }
    return _passWordButton;
}
-(void)passWordButtonAction{
    self.passWordButton.selected=!self.passWordButton.selected;
    if (self.passWordBlock) {
        self.passWordBlock(self.passWordButton.selected);
    }
}
-(UIButton *)mobileButton{
    if (_mobileButton==nil) {
        _mobileButton.hidden=YES;
        _mobileButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_mobileButton setImage :[UIImage imageNamed:@"logindownarrow"] forState:UIControlStateNormal];
        _mobileButton.frame=CGRectMake(ScreenWidth- 73, 10, 20, 20);
        [_mobileButton addTarget:self action:@selector(mobileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mobileButton;
}
-(void)mobileButtonAction:(UIButton*)button{
    self.mobileButton.selected=!self.mobileButton.selected;
    if (self.mobileButton.selected) {
        [UIView animateWithDuration:0.3 animations:^{
            button.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            button.imageView.transform = CGAffineTransformIdentity;
        }];
    }
    if (self.mobileBlock) {
        self.mobileBlock(self.mobileButton.selected);
    }
}
-(void)chngeMobileButton{
    self.mobileButton.selected=NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.mobileButton.imageView.transform = CGAffineTransformIdentity;
    }];
}
- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor whiteColor];
    }
    return _bottomLine;
}
-(void)setImage:(UIImage *)image{
    self.imageView.image=image;
}
- (instancetype)initWithImage:(UIImage *)image
{
    if (self = [super initWithFrame:CGRectZero])
    {
        self.backgroundColor=RGB(242, 242, 242);
        self.textAlignment  = NSTextAlignmentLeft;
        self.font           = ADeanFONT15;
        self.layer.cornerRadius=17.5;
        self.textColor=AllTextColor;
        self.layer.masksToBounds=YES;
        [self addTarget:self action:@selector(inputTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        if (self.isLogin) {
            self.imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 18)];
        }
        else{
            self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        }
        self.imageView.contentMode   = UIViewContentModeScaleAspectFit;
        self.imageView.image         = self.image;
        self.leftView           = self.imageView;
        self.leftViewMode       = UITextFieldViewModeAlways;
        
        [self addSubview:self.bottomLine];
        [self addSubview:self.mobileButton];
        [self addSubview:self.passWordButton];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(chngeMobileButton) name:ESLoginUserImageView object:nil];
    }
    return self;
}
-(void)inputTextFieldDidChange:(UITextField*)textFiled{
    if ([self.TextDelete respondsToSelector:@selector(inputTextFieldDidChange:)]) {
        [self.TextDelete inputTextFieldDidChange:textFiled.text];
    }
}
- (instancetype)initWithImage:(UIImage *)image needChange:(BOOL)needChange andIsLogin:(BOOL)isLogin{
    self.isNeedChangeClear = needChange;
    self.isLogin=isLogin;
    return [self initWithImage:image];;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: RGB(175 , 175, 175)}];

}
- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    CGRect rect = [super clearButtonRectForBounds:bounds];
    if (self.isNeedChangeClear) {
        return CGRectMake(rect.origin.x-33, rect.origin.y, rect.size.width, rect.size.height);
    } else
        return rect;
}


@end
