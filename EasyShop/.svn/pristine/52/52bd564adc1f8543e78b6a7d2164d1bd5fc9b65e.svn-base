//
//  JoinCircleDetailCell.m
//  ixln
//
//  Created by 脉融iOS开发 on 15/9/25.
//  Copyright (c) 2015年 ixln. All rights reserved.
//

#import "ESCommentListCell.h"

@interface ESCommentListCell()

@property (nonatomic, strong) UIImageView  *userImage;//圈子头像
@property (nonatomic, strong) UILabel      *userNameLab;//圈子名称
@property (nonatomic, strong) UILabel      *timeLabel;//时间
@property (nonatomic, strong) UIView       *topLine;//底线
@property (nonatomic, strong) UILabel      *contentLabel;//内容
@property (nonatomic, strong) UIButton     *priseBtn;//收藏按钮

@end

@implementation ESCommentListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.userImage.alpha = 1.0f;
    self.userNameLab.text = @"小肉哦乳";
    self.timeLabel.text = @"09-10 20:20";
    self.contentLabel.text = @"爱吃货这是真是好爱吃";
    self.priseBtn.alpha = 1.0f;
    self.topLine.alpha = 1.0f;
}

#pragma mark view init
- (UIView *)topLine
{
    if (!_topLine) {
        _topLine = [[UIImageView alloc] init];
        _topLine.backgroundColor = ADeanHEXCOLOR(0xcde7ff);
        [self.contentView addSubview:_topLine];
        [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).with.offset(0);
            make.right.mas_equalTo(self.mas_right).with.offset(0);
            make.top.mas_equalTo(self.mas_top).with.offset(0);
            make.height.mas_equalTo(@.5);
        }];
    }
    return _topLine;
}
- (UIImageView *)userImage
{
    if (!_userImage) {
        _userImage = [[UIImageView alloc] init];
        _userImage.image = [UIImage imageNamed:@"icon_home_cate"];;
        _userImage.layer.cornerRadius = 20;
        _userImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_userImage];
        [_userImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).with.offset(10);
            make.top.mas_equalTo(self.mas_top).with.offset(10);
            make.height.mas_equalTo(@40);
            make.width.mas_equalTo(@40);
        }];
    }
    return _userImage;
}
- (UILabel *)userNameLab
{
    if (!_userNameLab) {
        _userNameLab = [[UILabel alloc] init];
        _userNameLab.font = ADeanFONT15;
        _userNameLab.textColor = [UIColor blackColor];
        _userNameLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_userNameLab];
        [_userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userImage.mas_right).with.offset(10);
            make.top.mas_equalTo(self.mas_top).with.offset(10);
            make.height.mas_equalTo(@22);
            make.width.mas_equalTo(@100);
        }];
    }
    return _userNameLab;
}
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = ADeanFONT10;
        _timeLabel.textColor = ADeanHEXCOLOR(0x989898);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userImage.mas_right).with.offset(10);
            make.top.mas_equalTo(self.userNameLab.mas_bottom).with.offset(5);
            make.height.mas_equalTo(@15);
            make.width.mas_equalTo(@100);
        }];
    }
    return _timeLabel;
}
- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.userInteractionEnabled = YES;
        _contentLabel.font = ADeanFONT13;
        _contentLabel.numberOfLines = 3;
        _contentLabel.textColor = ADeanHEXCOLOR(0x323232);
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userNameLab.mas_left).with.offset(0);
            make.right.mas_equalTo(self.mas_right).with.offset(0);
            make.top.mas_equalTo(self.userImage.mas_bottom).with.offset(5);
            make.height.mas_equalTo(@20);
        }];
    }
    return _contentLabel;
}
- (UIButton *)priseBtn
{
    if (!_priseBtn) {
        _priseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_priseBtn setImage:[UIImage imageNamed:@"share_dianzan"] forState:UIControlStateNormal];
//        [_priseBtn setImage:[UIImage imageNamed:@"rightBtn_Circle"] forState:UIControlStateSelected];
        [_priseBtn setTitleColor:ADeanHEXCOLOR(0x646464) forState:UIControlStateNormal];
        _priseBtn.titleLabel.font = ADeanFONT13;
        _priseBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_priseBtn setTitle:@"0" forState:UIControlStateNormal];
        [_priseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_priseBtn addTarget:self action:@selector(priseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _priseBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
        [self.contentView addSubview:_priseBtn];
        [_priseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.userImage.mas_centerY).with.offset(0);
            make.right.mas_equalTo(self.mas_right).with.offset(-10);
            make.height.mas_equalTo(@20);
            make.width.mas_equalTo(@60);
        }];
    }
    return _priseBtn;
}

-(void)priseBtnAction:(UIButton *)button
{
    button.selected = !button.selected;
}

@end
