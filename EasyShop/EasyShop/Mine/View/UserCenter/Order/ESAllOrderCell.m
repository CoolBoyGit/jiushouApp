//
//  AllOrderCell.m
//  Glife
//
//  Created by 脉融iOS开发 on 16/3/15.
//  Copyright © 2016年 MFBank. All rights reserved.
//

#import "ESAllOrderCell.h"
@interface ESAllOrderCell()
@property(nonatomic,strong) UILabel*label;
@end
@implementation ESAllOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel*lable=[[UILabel alloc]init];
        lable.alpha=1;
        lable.backgroundColor=RGB(210, 210, 210);
        [self.contentView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(@0);
            make.width.equalTo(@(ScreenWidth));
            make.height.equalTo(@(0.5));
        }];
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@18);
            make.top.bottom.equalTo(@0);
            make.width.equalTo(@100);
        }];

    }
    return self;
}
-(UILabel *)label{
    if (_label==nil) {
        _label=[[UILabel alloc]init];
        _label.textAlignment=NSTextAlignmentLeft;
        _label.textColor=AllTextColor;
        _label.font=[UIFont systemFontOfSize:13];
    }
    return _label;
}
-(void)setTitleStr:(NSString *)titleStr
{
    _label.text=titleStr;
}


@end
