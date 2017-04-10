
//
//  ESRefoundTexdField.m
//  EasyShop
//
//  Created by wcz on 16/6/23.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESRefoundTexdField.h"
@interface ESRefoundTexdField()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,assign) BOOL isNeedChangeClear;
@property (nonatomic,strong) UIView *view;

@end
@implementation ESRefoundTexdField

-(void)setLeftStr:(NSString *)leftStr{
    self.nameLabel.text=leftStr;
}
-(void)setIsAddress:(BOOL)isAddress{
    if (isAddress) {
        self.view.frame=CGRectMake(0, 0, 100, 30);
    }
}
- (instancetype)initWithLeftTitleName:(NSString *)leftName andBOOL:(BOOL) isNeedChangeClear
{
    if (self = [super initWithFrame:CGRectZero])
    {
        self.isNeedChangeClear=isNeedChangeClear;
        self.view = [self initalieViewWithName:leftName];
        self.view.contentMode   = UIViewContentModeScaleAspectFit;
        self.layer.cornerRadius=4;
        self.layer.masksToBounds=YES;
        self.view.frame = CGRectMake(0, 0, 15, 50);
        self.leftView           = self.view;
        self.font = [UIFont systemFontOfSize:15];
        self.leftViewMode       = UITextFieldViewModeAlways;
    }
    return self;
}


- (UIView *)initalieViewWithName:(NSString *)leftName
{
    UIView *view = [[UIView alloc]init];
//    UILabel *label = [[UILabel alloc]init];
//    label.textColor = [UIColor redColor];
//    label.text = @"*";
//    label.textAlignment=NSTextAlignmentLeft;
//    [view addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@12);
//        make.centerY.equalTo(@0);
//    }];
//    
    self.nameLabel = [[UILabel alloc] init];
    //self.nameLabel.textColor = RGB(205, 206, 207);
    self.nameLabel.textColor=[UIColor blackColor];
    self.nameLabel.text = leftName;
    self.nameLabel.font=[UIFont systemFontOfSize:14];
    [view addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
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