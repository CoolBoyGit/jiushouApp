//
//  ESCommentInfoCell.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/4/29.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESCommentInfoCell.h"

@interface ESCommentInfoCell()

@property (nonatomic, strong) UIImageView *timeImg;//时间图像
@property (nonatomic, strong) UILabel     *timeLab;//时间
@property (nonatomic, strong) UIImageView *locationImg;//位置图像
@property (nonatomic, strong) UILabel     *locationLab;//位置
@property (nonatomic, strong) UILabel     *contentLab;//内容

@end

@implementation ESCommentInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpViews
{
    [self.contentView addSubview:self.timeImg];
    [self.timeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(@15);
        make.width.height.mas_equalTo(@(15));
    }];
    
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.mas_equalTo(@15);
        make.left.mas_equalTo(self.timeImg.mas_right).offset(5);
        make.width.mas_equalTo(@(60));
    }];
    
    [self.contentView addSubview:self.locationImg];
    [self.locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.top.mas_equalTo(@15);
        make.left.mas_equalTo(self.timeLab.mas_right).offset(5);
    }];
    
    [self.contentView addSubview:self.locationLab];
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.mas_equalTo(@15);
        make.left.mas_equalTo(self.locationImg.mas_right).offset(5);
        make.width.mas_equalTo(@(200));
    }];

    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@10);
        make.top.mas_equalTo(self.timeImg.mas_bottom).offset(10);
        make.right.mas_equalTo(@-10);
        make.height.mas_equalTo(@(60));
    }];
}

-(UIImageView *)timeImg
{
    if (!_timeImg) {
        _timeImg = [[UIImageView alloc] init];
        _timeImg.image = [UIImage imageNamed:@"share_time"];
    }
    return _timeImg;
}
-(UILabel *)timeLab
{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.text = @"15分钟前";
        _timeLab.font = [UIFont systemFontOfSize:13];
        _timeLab.textColor = [UIColor blackColor];
    }
    return _timeLab;
}
-(UIImageView *)locationImg
{
    if (!_locationImg) {
        _locationImg = [[UIImageView alloc] init];
        _locationImg.image = [UIImage imageNamed:@"share_location"];
    }
    return _locationImg;
}
-(UILabel *)locationLab
{
    if (!_locationLab) {
        _locationLab = [[UILabel alloc] init];
        _locationLab.text = @"浙江省 杭州市";
        _locationLab.font = [UIFont systemFontOfSize:13];
        _locationLab.textColor = [UIColor blackColor];
    }
    return _locationLab;
}
-(UILabel *)contentLab
{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] init];
        _contentLab.text = @"恭喜交际花获得牛爷爷送出的鲜花！！！恭喜交际花获得牛爷爷送出的鲜花！！！恭喜交际花获得牛爷爷送出的鲜花！！！恭喜交际花获得牛爷爷送出的鲜花！！！";
        _contentLab.numberOfLines = 0;
        _contentLab.font = [UIFont systemFontOfSize:13];
        _contentLab.textColor = [UIColor blackColor];
    }
    return _contentLab;
}

@end
