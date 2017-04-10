
//
//  ESToNumberCell.m
//  EasyShop
//
//  Created by jiushou on 16/10/10.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClsterPayNumberCell.h"
@interface ESClsterPayNumberCell()
@property (nonatomic,strong) UILabel*textlabel;
@property (nonatomic,strong) UIButton*addButton;
@property (nonatomic,strong) UIButton*minusButton;
@property (nonatomic,strong) UILabel*countLabel;
@property (nonatomic,strong) UIView*lineView;

@end
@implementation ESClsterPayNumberCell
-(void)setCount:(int)count{
    if (count==1) {
        self.minusButton.enabled=NO;
    }else{
        self.minusButton.enabled=YES;
    }
    self.countLabel.text=[NSString stringWithFormat:@"%d",count];
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.textLabel];
        self.selectionStyle=UITableViewCellSelectionStyleNone;

        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@10);
            make.width.equalTo(@50);
            make.bottom.equalTo(@(-1));
        }];
        [self.contentView addSubview:self.addButton];
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.width.equalTo(@30);
            make.height.equalTo(@29);
            make.top.equalTo(@5);
        }];
        
        [self.contentView addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@5);
            make.height.equalTo(@29);
            make.right.equalTo(self.addButton.mas_left).with.offset(-5);
            make.width.equalTo(@50);
        }];
        
        [self.contentView addSubview:self.minusButton];
        [self.minusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.countLabel.mas_left).with.offset(-5);
            make.top.equalTo(@5);
            make.height.equalTo(@29);
            make.width.equalTo(@30);
        }];
        [self .contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
            make.height.equalTo(@1);
            make.left.equalTo(@10);
            make.right.equalTo(@(-10));
        }];
        
    }
    return self;
}
-(UILabel *)textLabel{
    if (_textlabel==nil) {
        _textlabel=[[UILabel alloc]init];
        _textlabel.font=[UIFont systemFontOfSize:14];
        _textlabel.text=@"数量";
        _textlabel.textColor=AllTextColor;
    }
    return _textlabel;
    
}
-(UIButton *)addButton{
    if (_addButton==nil) {
        _addButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setTitle:@"+" forState:UIControlStateNormal];
        [_addButton setBackgroundColor:RGB(247, 247, 247)];
        [_addButton setTitleColor:RGBA(233, 40, 46, 1) forState:UIControlStateNormal];
        
        [_addButton addTarget:self action:@selector(addButtonACtion) forControlEvents:UIControlEventTouchUpInside];
        _addButton.titleLabel.font=[UIFont systemFontOfSize:18];
        
    }
    return _addButton;
}
-(void)addButtonACtion{
    if (self.addBlock) {
        self.addBlock();
    }
}
-(UIButton *)minusButton{
    if (_minusButton==nil) {
        _minusButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_minusButton setTitleColor:RGB(233, 40, 46) forState:UIControlStateNormal];
        [_minusButton setTitle:@"-" forState:UIControlStateNormal];
        [_minusButton addTarget:self action:@selector(minusButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_minusButton setBackgroundColor:RGB(247, 247, 247)];
        _minusButton.titleLabel.font=[UIFont systemFontOfSize:18];
    }
    return _minusButton;
    
}
-(void)minusButtonAction{
    if (self.minuBlock) {
        self.minuBlock();
    }
}
-(UILabel *)countLabel{
    if (_countLabel==nil) {
        _countLabel=[[UILabel alloc]init];
        _countLabel.text=[NSString stringWithFormat:@"%d",1];
        _countLabel.textAlignment=NSTextAlignmentCenter;
        _countLabel.textColor=RGB(233, 40, 46);
        _countLabel.backgroundColor=RGB(247, 247, 247);
        _countLabel.font=[UIFont systemFontOfSize:18];
    }
    return _countLabel;
}
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=RGBA(235, 235, 235, 1);
    }
    return _lineView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
