
//
//  ESThemeViewCell.m
//  EasyShop
//
//  Created by 就手国际 on 17/3/9.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import "ESThemeViewCell.h"

@implementation ESThemeViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.contentView addSubview:self.colorLable];
        [self.colorLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.centerY.equalTo(self.mas_centerY);
            make.width.height.equalTo(@30);
        }];
        [self .contentView addSubview:self.rightLabel];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}
-(void)setColor:(UIColor *)color{
    self.colorLable.backgroundColor=color;
}
-(void)setLabelText:(NSString *)labelText{
    self.rightLabel.text=labelText;
}
-(UILabel *)colorLable{
    if (_colorLable==nil) {
        _colorLable=[[UILabel alloc]init];
        _colorLable.layer.cornerRadius=15;
        _colorLable.layer.masksToBounds=YES;
        
    }
    return _colorLable;
}
-(UILabel *)rightLabel{
    if (_rightLabel==nil) {
        _rightLabel=[[UILabel alloc]init];
        _rightLabel.font=[UIFont systemFontOfSize:17];
        _rightLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _rightLabel;
}
@end
