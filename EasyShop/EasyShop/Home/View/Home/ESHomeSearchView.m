
//
//  ESHomeSearchView.m
//  EasyShop
//
//  Created by wcz on 16/3/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESHomeSearchView.h"
#import "ESShopSSearchController.h"


static const CGFloat STTextFieldHeight = 28;
static const CGFloat STSearchBarMargin = 1;

@interface ESHomeSearchView()<UITextFieldDelegate>
/** 1.输入框 */
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) BOOL  pushSearchVC;
/** 3.搜索图标 */
@property (nonatomic, strong) UIImageView *imageIcon;
/** 4.中间视图 */
@property (nonatomic, strong) UIButton *buttonCenter;
@end

@implementation ESHomeSearchView
-(void)setIsEditing:(BOOL)isEditing{
    if (isEditing) {
        self.imageIcon.hidden=NO;
        self.buttonCenter.hidden=YES;
    }else{
        [self.textField resignFirstResponder];
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.layer.cornerRadius = 4;
        [self intalizedView];
    }
    return self;
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self.buttonCenter setTitle:placeholder forState:UIControlStateNormal];
    [self.buttonCenter sizeToFit];
    self.buttonCenter.center = self.textField.center;
}
- (UIButton *)buttonCenter
{
    if (!_buttonCenter) {
        UIButton *buttonCenter = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonCenter setImage:[UIImage imageNamed:@"icon_STSearchBar"] forState:UIControlStateNormal];
        [buttonCenter setTitleColor:[UIColor colorWithRed:(142.0/255) green:(142.0/255) blue:(147.0/255) alpha:1] forState:UIControlStateNormal];
        [buttonCenter.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [buttonCenter setEnabled:NO];
        buttonCenter.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [buttonCenter sizeToFit];
        _buttonCenter = buttonCenter;
    }
    return _buttonCenter;
}

- (UIImageView *)imageIcon
{
    if (!_imageIcon) {
        UIImageView *imageIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_STSearchBar"]];
        [imageIcon setHidden:YES];
        _imageIcon = imageIcon;
    }
    return _imageIcon;
}

- (void)intalizedView
{
    self.backgroundColor = RGB(232, 236, 237);
    [self addSubview:self.textField];
    [self addSubview:self.buttonCenter];
    
}
-(void)setText:(NSString *)text{
    
    self.textField.text=text;
}
-(void)setTextColor:(UIColor *)textColor{
    self.textField.textColor=textColor;
}
- (UITextField *)textField
{
    if (!_textField) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(2, STSearchBarMargin, self.frame.size.width-STSearchBarMargin*2, STTextFieldHeight)];
        textField.delegate = self;
        textField.borderStyle = UITextBorderStyleNone;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.enablesReturnKeyAutomatically = YES;
        textField.font = [UIFont systemFontOfSize:14.0f];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textField addTarget:self
                      action:@selector(textFieldDidChange:)
            forControlEvents:UIControlEventEditingChanged];
        textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        textField.borderStyle=UITextBorderStyleNone;
        textField.layer.cornerRadius = 4.0f;
        textField.delegate=self;
        textField.layer.masksToBounds=YES;
        [textField setLeftViewMode:UITextFieldViewModeAlways];
        textField.leftView = self.imageIcon;
        [textField setClipsToBounds:YES];
        _textField = textField;
        
    }
    return _textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.buttonCenter setHidden:NO];
    [self.imageIcon setHidden:YES];
     self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName:self.placeholderColor}];
    [UIView animateWithDuration:0.6 animations:^{
            self.textField.frame = CGRectMake(STSearchBarMargin, STSearchBarMargin, self.frame.size.width-STSearchBarMargin*2, STTextFieldHeight);
        
        self.buttonCenter.center = self.textField.center;
    } completion:^(BOOL finished) {
        
    }];
    self.textField.text = @"";
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    if (self.isAllowToPush) {
        ESShopSearchController *vc = [[ESShopSearchController alloc] init];
        vc.isSearchView = YES;
        [[AppDelegate shared]pushViewController:vc animated:YES];
        return NO;
    }
    CGRect frameButtonCenter = self.buttonCenter.frame;
    frameButtonCenter.origin.x = CGRectGetMinX(self.textField.frame);
    [UIView animateWithDuration:0.6 animations:^{
        self.buttonCenter.frame = frameButtonCenter;
        
           self.textField.frame = CGRectMake(STSearchBarMargin, STSearchBarMargin, self.frame.size.width-STSearchBarMargin*2, STTextFieldHeight);
        
    } completion:^(BOOL finished) {
        [self.buttonCenter setHidden:YES];
        [self.imageIcon setHidden:NO];
        self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:self.placeholderColor}];
    }];
    
        return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
//    [self endEditing:YES];
//    
//    if ([self.delegate respondsToSelector:@selector(addHistoryKeyword:)]) {
//        [self.delegate addHistoryKeyword:textField.text];
//    }
    return YES;
}
- (void)textFieldDidChange:(UITextField *)textField
{
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidChange:)]) {
        [self.delegate textFieldDidChange:textField.text];
    }
}
@end
