//
//  ESRefoundCell.m
//  EasyShop
//
//  Created by 就手国际 on 17/1/9.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import "ESRefoundCell.h"
#import "ESRefoundTexdField.h"
@interface ESRefoundCell()
@property (nonatomic,strong) UILabel*tipsLabel;
@property (nonatomic,strong) ESRefoundTexdField*textField;
@property (nonatomic,strong) UITextView*textView;
@property (nonatomic,strong) UILabel*starLabel;
@property (nonatomic,strong) UIButton*tapButton;
@end
@implementation ESRefoundCell
-(void)setIsHidden:(BOOL)isHidden{
    self.tapButton.hidden=isHidden;
}
-(void)setModel:(ESRefoundResonModel *)model{
    _model=model;
    self.tipsLabel.text=model.tipsStr;
    self.textField.text=model.resonStr;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor=RGBA(237, 237, 237, 1);
        [self.contentView addSubview:self.tipsLabel];
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.top.equalTo(@0);
            make.left.equalTo(@10);
            
        }];
        [self.contentView addSubview:self.starLabel];
        [self.starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tipsLabel.mas_right).offset(0);
            make.height.equalTo(@40);
            make.top.equalTo(@0);
        }];
        
        [self.contentView addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.height.equalTo(@50);
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(0);
        }];
        [self.contentView addSubview:self.tapButton];
        [self.tapButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.height.equalTo(@50);
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(0);
        }];
    }
    return self;
}
-(UIButton *)tapButton{
    if (_tapButton==nil) {
        _tapButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _tapButton.backgroundColor=[UIColor clearColor];
        _tapButton.hidden=YES;
        [_tapButton addTarget:self action:@selector(tapButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tapButton;
}
-(void)tapButtonAction{
    if (self.model.tapBlaock) {
        self.model.tapBlaock();
    }
}
-(UILabel *)starLabel{
    if (_starLabel==nil) {
        _starLabel=[[UILabel alloc]init];
        _starLabel.textColor=RGB(233, 40, 46);
        _starLabel.text=@"*";
    }
    return _starLabel;
}
-(UILabel *)tipsLabel{
    if (_tipsLabel==nil) {
        _tipsLabel=[[UILabel alloc]init];
        _tipsLabel.textColor=RGB(60, 60, 60);
        _tipsLabel.font=[UIFont systemFontOfSize:14];
    }
    return _tipsLabel;
}
-(ESRefoundTexdField *)textField{
    if (_textField==nil) {
        _textField=[[ESRefoundTexdField alloc]initWithLeftTitleName:@"  " andBOOL:@""];
        _textField.layer.borderColor=RGBA(228, 228, 228, 1).CGColor;
        _textField.layer.borderWidth=1;
        _textField.enabled=NO;
        _textField.backgroundColor=[UIColor whiteColor];
        _textField.textColor=RGBA(70, 70, 70, 1);
    }
    return _textField;
}
-(UITextView *)textView{
    if (_textView==nil) {
        _textView=[[UITextView alloc]init];
        _textView.scrollEnabled=YES;
    }
    return _textView;
}
@end
