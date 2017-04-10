//
//  NewAddressCell.m
//  EasyShop
//
//  Created by guojian on 16/5/17.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "NewAddressCell.h"
#import "ESAddressTexdField.h"

@interface NewAddressCell()<UITextFieldDelegate>
{
    CGFloat left,top,width,height;
    CGFloat margin;
}
/** field */
@property (nonatomic,strong) ESAddressTexdField *textField;
/** button */
@property (nonatomic,weak) UIButton *locationButton;
@property (nonatomic,weak) UIButton *button;
@property (nonatomic,strong) UIView *lineView;
@end

@implementation NewAddressCell

- (void)setItem:(NewAddressItem *)item
{

        _item = item;
    
}
-(void)setIsChangAddress:(BOOL)isChangAddress{
    if (isChangAddress) {
        self.textField.leftStr=_item.placeholer;
        self.textField.text = _item.text;
        self.textField.enabled = (_item.tapBlock == nil);
    }else{
        self.textField.leftStr=_item.placeholer;
        //self.textField.placeholder = _item.placeholer;
        if (self.row==4) {
            self.textField.text=_item.text;
        }else{
            self.textField.placeholder = _item.text;
        }
        
        //    }
        self.textField.enabled = (_item.tapBlock == nil);
    }
}
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=RGBA(235, 235, 235, 1);
    }
    return _lineView;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.textField=[[ESAddressTexdField alloc]initWithLeftTitleName:self.item.text andBOOL:NO];
       
        self.textField.delegate=self;
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.contentView addSubview:self.textField];
        UIButton *button        = [[UIButton alloc] init];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        button.hidden           = YES;
        self.button             = button;
        //利用通知来传值
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self.textField];
         [self.contentView addSubview:self.lineView];        
    }
    return self;
}
-(void)locationButtonAction{
    if (self.tapBlock) {
        self.tapBlock();
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}

- (void)textDidChange:(NSNotification *)notification
{
    UITextField *textField = notification.object;
    if (textField == self.textField) {
        self.item.text = textField.text;
    }
}

- (void)buttonAction
{
    if (self.item.tapBlock) {
        self.item.tapBlock();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    width = self.contentView.width;
    height = self.contentView.height;
    left = 15;
    top = 0;
    self.lineView.frame=CGRectMake(10, height-0.5, ScreenWidth-20, 0.5);
    self.textField.frame = CGRectMake(0, 5, ScreenWidth-10, height-5);
    self.button.frame = CGRectMake(0, 0, ScreenWidth-30, height-0.5);
    self.button.hidden = !self.item.tapBlock;
}

@end