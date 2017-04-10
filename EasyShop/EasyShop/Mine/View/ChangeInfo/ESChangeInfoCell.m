//
//  ESChangeInfoCell.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/11.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESChangeInfoCell.h"
@interface ESChangeInfoCell()
@property (nonatomic,strong) UIView*lineView;


@end
@implementation ESChangeInfoCell
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=KCommontLineViewBagroudColor;
        
    }
    return _lineView;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.height.equalTo(@29.45);
        make.centerY.equalTo(@0);
    }];
    
    [self.contentView addSubview:self.userInfoLab];
    [self.userInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.left.equalTo(self.titleLab.mas_right).with.offset(10);
        make.height.equalTo(@29.45);
        make.centerY.equalTo(@0);
    }];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@0);
        make.right.equalTo(@50);
        make.height.equalTo(@0.35);
        make.bottom.equalTo(@0);
    }];
}

-(UILabel *)userInfoLab
{
    if (!_userInfoLab) {
        _userInfoLab = [[UILabel alloc] init];
        _userInfoLab.font = [UIFont systemFontOfSize:15];
        _userInfoLab.textAlignment = NSTextAlignmentRight;
        _userInfoLab.textColor=AllTextColor;
    }
    return _userInfoLab;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:15];
        _titleLab.textColor=AllTextColor;
    }
    return _titleLab;
}

@end
