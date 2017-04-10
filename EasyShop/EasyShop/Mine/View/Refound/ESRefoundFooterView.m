//
//  ESRefoundFooterView.m
//  EasyShop
//
//  Created by 就手国际 on 17/1/9.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import "ESRefoundFooterView.h"
#define MAX_LIMIT_NUMS 200;
@interface ESRefoundFooterView()<UITextViewDelegate>
@property (nonatomic,strong) UILabel*tipsLabel;
@property (nonatomic,strong) UITextView*messageTextView;
@property (nonatomic,strong) UILabel*starLabel;
@property (nonatomic,strong) UIView *bView;//边框
@property (nonatomic,strong) UILabel*countLabel;//显示限制的label
@end
@implementation ESRefoundFooterView
-(void)setModel:(ESRefoundResonModel *)model{
    self.tipsLabel.text=model.tipsStr;
    _model=model;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.tipsLabel];
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.top.equalTo(@0);
            make.left.equalTo(@10);
            
        }];
        [self addSubview:self.starLabel];
        [self.starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tipsLabel.mas_right).offset(0);
            make.height.equalTo(@40);
            make.top.equalTo(@0);
        }];
        [self addSubview:self.bView];
        [self.bView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(0);
            make.bottom.equalTo(@0);
        }];
        [self addSubview:self.messageTextView];
        [self.messageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@25);
            make.right.equalTo(@-25);
            make.top.equalTo(self.bView.mas_top).offset(5);
            make.bottom.equalTo(self.bView.mas_bottom).offset(-25);
        }];
        [self addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bView.mas_right).offset(-15);
            make.bottom.equalTo(self.bView.mas_bottom).offset(-5);
            
        }];

    }
    return self;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        if (offsetRange.location < 200) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
            self.countLabel.text = [NSString stringWithFormat:@"%d/%d",0,200];
        }
        return NO;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum >200)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:200];
        
        [textView setText:s];
    }
    self.model.resonStr=textView.text;
    //不让显示负数 口口日
    self.countLabel.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,200 - existTextNum),200];
}
-(UIView *)bView{
    if (_bView==nil) {
        _bView=[[UIView alloc]init];
        _bView.backgroundColor=[UIColor whiteColor];
        _bView.layer.borderColor=RGB(237, 237, 237).CGColor;
        _bView.layer.borderWidth=1;
    }
    return _bView;
}
-(UITextView *)messageTextView{
    if (_messageTextView==nil) {
        _messageTextView=[[UITextView alloc]init];
        _messageTextView.scrollEnabled=YES;
        _messageTextView.delegate=self;
        _messageTextView.font=[UIFont systemFontOfSize:14];
    }
    return _messageTextView;
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
        _tipsLabel.text=@"腿货理由";
        _tipsLabel.textColor=RGB(60, 60, 60);
        _tipsLabel.font=[UIFont systemFontOfSize:14];
    }
    return _tipsLabel;
}
-(UILabel *)countLabel{
    if (_countLabel==nil) {
        _countLabel=[[UILabel alloc]init];
        _countLabel.text=@"200";
    }
    return _countLabel;
}
@end
