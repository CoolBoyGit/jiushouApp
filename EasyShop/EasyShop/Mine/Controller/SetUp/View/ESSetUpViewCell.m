//
//  ESSetUpViewCell.m
//  EasyShop
//
//  Created by 就手国际 on 17/3/8.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import "ESSetUpViewCell.h"
@interface ESSetUpViewCell ()
@property (nonatomic,strong) UILabel*leftLabel;
@property (nonatomic,strong) UILabel*rightLabel;
@end
@implementation ESSetUpViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.leftLabel];
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.centerY.equalTo(self.mas_centerY);
        }];
        [self.contentView addSubview:self.rightLabel];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}
-(void)setRightString:(NSString *)rightString{
    self.rightLabel.text=rightString;
}
-(UILabel *)rightLabel{
    if (_rightLabel==nil) {
        _rightLabel=[[UILabel alloc]init];
        _rightLabel.textAlignment=NSTextAlignmentRight;
        _rightLabel.textColor=AllTextColor;
    }
    return _rightLabel;
}
-(UILabel *)leftLabel{
    if (_leftLabel==nil) {
        _leftLabel=[[UILabel alloc]init];
        _leftLabel.font=[UIFont systemFontOfSize:16];
        _leftLabel.textColor=AllTextColor;
    }
    return _leftLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)setLeftString:(NSString *)leftString{
    self.leftLabel.text=leftString;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
