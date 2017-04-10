//
//  ESMyScoreListCell.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/21.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESMyScoreListCell.h"

@interface ESMyScoreListCell()

@property (nonatomic, strong) UILabel     *memberLoginLab;//会员登录
@property (nonatomic, strong) UILabel     *memberAboutLab;//会员相关
@property (nonatomic, strong) UILabel     *scoreNumLab;//获取积分的数目
@property (nonatomic, strong) UILabel     *timeLab;//时间

@end

@implementation ESMyScoreListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupViews
{
    self.memberLoginLab.text = @"会员登录";
    [self.contentView addSubview:self.memberLoginLab];
    [self.memberLoginLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.height.equalTo(@20);
        make.width.equalTo(@150);
    }];
    
    self.memberAboutLab.text = @"会员相关";
    [self.contentView addSubview:self.memberAboutLab];
    [self.memberAboutLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@60);
        make.left.height.equalTo(@20);
        make.width.equalTo(@150);
    }];
    
    self.scoreNumLab.text = @"+ 1";
    [self.contentView addSubview:self.scoreNumLab];
    [self.scoreNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(@20);
        make.width.equalTo(@150);
        make.right.equalTo(@-20);
    }];
    
    self.timeLab.text = @"2015-04-21";
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@60);
        make.height.equalTo(@20);
        make.width.equalTo(@150);
        make.right.equalTo(@-20);
    }];
}
- (UILabel *)memberLoginLab
{
    if (!_memberLoginLab) {
        _memberLoginLab = [[UILabel alloc] init];
        _memberLoginLab.font = ADeanFONT15;
        _memberLoginLab.backgroundColor = [UIColor clearColor];
    }
    return _memberLoginLab;
}
- (UILabel *)memberAboutLab
{
    if (!_memberAboutLab) {
        _memberAboutLab = [[UILabel alloc] init];
        _memberAboutLab.font = ADeanFONT15;
        _memberAboutLab.textColor = [UIColor grayColor];
        _memberAboutLab.backgroundColor = [UIColor clearColor];
    }
    return _memberAboutLab;
}
- (UILabel *)scoreNumLab
{
    if (!_scoreNumLab) {
        _scoreNumLab = [[UILabel alloc] init];
        _scoreNumLab.textAlignment = NSTextAlignmentRight;
        _scoreNumLab.font = ADeanFONT15;
        _scoreNumLab.textColor = [UIColor greenColor];
        _scoreNumLab.backgroundColor = [UIColor clearColor];
    }
    return _scoreNumLab;
}
- (UILabel *)timeLab
{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.textAlignment = NSTextAlignmentRight;
        _timeLab.font = ADeanFONT15;
        _timeLab.textColor = [UIColor grayColor];
        _timeLab.backgroundColor = [UIColor clearColor];
    }
    return _timeLab;
}


@end
