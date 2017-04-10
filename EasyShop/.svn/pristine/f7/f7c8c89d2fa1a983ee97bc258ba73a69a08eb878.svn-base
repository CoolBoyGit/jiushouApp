//
//  ESSearchView.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/19.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESSearchView.h"

@interface ESSearchView()<UITextFieldDelegate>

@end

@implementation ESSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self intalizedView];
    }
    return self;
}

- (void)intalizedView
{
    self.backgroundColor = ADeanHEXCOLOR(0xcccccc);
    
    //搜索图片
    UIButton *imgeview = [[UIButton alloc] init];
    [imgeview setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [imgeview setTitle:@"宝贝" forState:UIControlStateNormal];
    imgeview.titleLabel.font = [UIFont systemFontOfSize:13];
    imgeview.imageEdgeInsets = UIEdgeInsetsMake(3, 10, 3, -50);
    imgeview.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    imgeview.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imgeview];
    [imgeview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.centerY.equalTo(@0);
        make.width.equalTo(@40);
        make.height.equalTo(@20);
    }];
    
    // 提示
    UITextField *searchTextField = [[UITextField alloc] init];
    searchTextField.placeholder = @"中国制造有好货";
    searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"中国制造有好货" attributes:@{NSForegroundColorAttributeName:ADeanHEXCOLOR(0x999999),
                                                                                                                NSFontAttributeName:ADeanFONT14,
                                                                                                                NSBaselineOffsetAttributeName:@-2}];
    searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    searchTextField.returnKeyType = UIReturnKeyGo;
    searchTextField.delegate = (id<UITextFieldDelegate>)self;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:searchTextField];
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.centerY.equalTo(@0);
        make.width.equalTo(@180);
        make.height.equalTo(@25);
    }];
    self.searchField            = searchTextField;
    
    UIButton *camera = [[UIButton alloc] init];
    [camera setImage:[UIImage imageNamed:@"compose_photograph"] forState:UIControlStateNormal];
    camera.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:camera];
    [camera mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.centerY.equalTo(@0);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.searchBlock) {
        self.searchBlock();
    }
    
    return YES;
}

@end
