//
//  ESTogeDetailOtherCell.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterOrderDetailOtherCell.h"
@interface ESClusterOrderDetailOtherCell()
@property (nonatomic,strong)UILabel*typeLable;
@property (nonatomic,strong)UILabel*timeLabel;
@property (nonatomic,strong)UIView*lineView;
@end
@implementation ESClusterOrderDetailOtherCell
-(void)setTypeStr:(NSString *)typeStr{
    self.typeLable.text=typeStr;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.typeLable];
        [self.typeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView. mas_centerY).offset(0);
            make.left.equalTo(@10);
            make.height.equalTo(@10);
        }];
//        [self.contentView addSubview:self.timeLabel];
//        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.contentView. mas_centerY).offset(0);
//            make.right.equalTo(@(-10));
//            make.height.equalTo(@10);
//        }];
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@1);
            make.bottom.equalTo(@0);
        }];
    }
    return self;
}
-(UILabel *)typeLable{
    if (_typeLable==nil) {
        _typeLable=[[UILabel alloc]init];
        _typeLable.font=[UIFont systemFontOfSize:13];
        _typeLable.text=@"成交时间:";
        _typeLable.textColor=AllTextColor;
    }
    return _typeLable;
}
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=RGB(224, 224, 224);
    }
    return _lineView;
}
-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.textAlignment=NSTextAlignmentRight;
        _timeLabel.font=[UIFont systemFontOfSize:13];
        _timeLabel.textColor=AllTextColor;
        _timeLabel.text=@"2020-10-30 11:100";
    }
    return _timeLabel;
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
