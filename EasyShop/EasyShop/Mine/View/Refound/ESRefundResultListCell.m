//
//  ESRefundResultListCell.m
//  EasyShop
//
//  Created by 就手国际 on 16/11/21.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESRefundResultListCell.h"
@interface ESRefundResultListCell()
@property (nonatomic,strong) UIView*lineView;
@end
@implementation ESRefundResultListCell
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=KCommontLineViewBagroudColor;
    }
    return _lineView;
}
-(UILabel *)label{
    if (_label==nil) {
        _label=[[UILabel alloc]init];
        _label.textColor=RGB(80, 80, 80);
        _label.font=[UIFont systemFontOfSize:15];
    }
    return _label;
}
-(UILabel *)messageLabel{
    if (_messageLabel==nil) {
        _messageLabel=[[UILabel alloc]init];
        _messageLabel.font=[UIFont systemFontOfSize:15];
        _messageLabel.textColor=RGB(90, 90, 90);
    }
    return _messageLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.bottom.top.equalTo(@0);
            make.width.equalTo(@80);
            
        }];
        [self.contentView addSubview:self.messageLabel];
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.left.equalTo(self.label.mas_right).offset(10);
            make.right.equalTo(@(-10));
        }];
        [self.contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
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
