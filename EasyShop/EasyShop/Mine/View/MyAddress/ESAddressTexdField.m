
//
//  ESRefoundTexdField.m
//  EasyShop
//
//  Created by wcz on 16/6/23.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESAddressTexdField.h"
@interface ESAddressTexdField()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,assign) BOOL isNeedChangeClear;
@property (nonatomic,strong) UIView *view;

@end
@implementation ESAddressTexdField

-(void)setLeftStr:(NSString *)leftStr{
    self.nameLabel.text=leftStr;
}
- (instancetype)initWithLeftTitleName:(NSString *)leftName andBOOL:(BOOL) isNeedChangeClear
{
    if (self = [super initWithFrame:CGRectZero])
    {
        self.isNeedChangeClear=isNeedChangeClear;
        self.view = [self initalieViewWithName:leftName];
        self.view.contentMode   = UIViewContentModeScaleAspectFit;
        self.backgroundColor=[UIColor clearColor];
        self.layer.cornerRadius=4;
        self.textColor=AllTextColor;
        self.layer.masksToBounds=YES;
        self.view.frame = CGRectMake(0, 0, 80, 30);
        self.leftView           = self.view;
        self.font = [UIFont systemFontOfSize:15];
        self.leftViewMode       = UITextFieldViewModeAlways;
    }
    return self;
}


- (UIView *)initalieViewWithName:(NSString *)leftName
{
    UIView *view = [[UIView alloc]init];
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor=RGBA(164, 164, 164, 1);
    self.nameLabel.text = leftName;
    self.nameLabel.font=[UIFont systemFontOfSize:14];
    [view addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(@0);
    }];
    return view;
}
//重写清除按钮的位置
- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    CGRect rect = [super clearButtonRectForBounds:bounds];
    if (self.isNeedChangeClear) {
        return CGRectMake(rect.origin.x-76, rect.origin.y, rect.size.width, rect.size.height);
    } else
        return rect;
}

@end
