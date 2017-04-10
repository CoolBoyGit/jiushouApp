//
//  ESJoinButtonCell.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterDetailButtonCell.h"
@interface ESClusterDetailButtonCell()
@property (nonatomic,strong)UIButton*button;//点击显示分组的cell.
@end
@implementation ESClusterDetailButtonCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=RGB(247, 247, 247);
        [self.contentView addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(UIButton *)button{
    if (_button==nil) {
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        _button.titleLabel.font=[UIFont systemFontOfSize:13];
        [_button setTitle:@"查看全部团购详情" forState:UIControlStateNormal];
        [_button setBackgroundColor:RGB(247, 247, 247)];
        [_button setTitleColor:AllTextColor forState:UIControlStateNormal];
        [_button setTitle:@"收起全部团购详情" forState:UIControlStateSelected];
        [_button setTitleColor:AllTextColor forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [_button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        
    }
    return _button;
}
-(void)buttonAction{
    _button.selected=!_button.selected;
    DZLog(@"%d",_button.selected);
    if (self.buttoonBlock) {
        self.buttoonBlock(_button.selected);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
