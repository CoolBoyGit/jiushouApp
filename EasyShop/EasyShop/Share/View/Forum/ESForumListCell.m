//
//  ESForumListCell.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/3.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESForumListCell.h"

@interface ESForumListCell()

@property (nonatomic, strong) UILabel      *forumNameLab;//论坛帖子名称
@property (nonatomic, strong) UILabel      *forumNumLab;//论坛帖子数量
@property (nonatomic, strong) UILabel      *forumContentLab;//论坛帖子内容
@property (nonatomic, strong) UIImageView  *forumUserImg;//用户图像
@property (nonatomic, strong) UILabel      *forumUserLab;//发帖人的名字
@property (nonatomic, strong) UIImageView  *forumTimeImg;//时间图像
@property (nonatomic, strong) UILabel      *forumTimeLab;//时间

@end

@implementation ESForumListCell

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
    [self.contentView addSubview:self.forumNameLab];
    [self.forumNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.height.equalTo(@15);
        make.left.equalTo(@5);
        make.width.equalTo(@200);
    }];
    
    [self.contentView addSubview:self.forumNumLab];
    [self.forumNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.height.equalTo(@15);
        make.width.equalTo(@40);
        make.left.equalTo(self.forumNameLab.mas_right).with.offset(0);
    }];
    
    [self.contentView addSubview:self.forumContentLab];
    [self.forumContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(self.forumNameLab.mas_bottom).with.offset(5);
        make.height.equalTo(@40);
    }];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(110*i+10, self.forumContentLab.bottom+5, 100, 60);
        imgView.image = [UIImage imageNamed:@"page2"];
        [self.contentView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.forumContentLab.mas_bottom).with.offset(5);
            make.left.equalTo(@(110*i+10));
            make.width.equalTo(@100);
            make.height.equalTo(@60);
        }];
    }
    
    [self.contentView addSubview:self.forumUserImg];
    [self.forumUserImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.width.height.equalTo(@15);
        make.bottom.equalTo(@-5);
    }];
    
    [self.contentView addSubview:self.forumUserLab];
    [self.forumUserLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.forumUserImg.mas_right).with.offset(5);
        make.height.equalTo(self.forumUserImg.mas_height);
        make.width.equalTo(@60);
        make.bottom.equalTo(self.forumUserImg.mas_bottom);
    }];
    
    [self.contentView addSubview:self.forumTimeImg];
    [self.forumTimeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.forumUserLab.mas_right).with.offset(10);
        make.width.height.equalTo(@15);
        make.bottom.equalTo(self.forumUserImg.mas_bottom);
    }];
    
    [self.contentView addSubview:self.forumTimeLab];
    [self.forumTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.forumTimeImg.mas_right).with.offset(5);
        make.height.equalTo(self.forumUserImg.mas_height);
        make.width.equalTo(@60);
        make.bottom.equalTo(self.forumUserImg.mas_bottom);
    }];

}


-(UILabel *)forumNameLab
{
    if (!_forumNameLab) {
        _forumNameLab = [[UILabel alloc] init];
        _forumNameLab.text = @"［论坛］这个商铺的东西很好";
        _forumNameLab.font = [UIFont systemFontOfSize:15];
        _forumNameLab.textColor = [UIColor blackColor];
    }
    return _forumNameLab;
}
-(UILabel *)forumNumLab
{
    if (!_forumNumLab) {
        _forumNumLab = [[UILabel alloc] init];
        _forumNumLab.textAlignment  = NSTextAlignmentCenter;
        _forumNumLab.text = @"1024";
        _forumNumLab.layer.borderWidth = 0.5;
        _forumNumLab.layer.borderColor = [UIColor grayColor].CGColor;
        _forumNumLab.font = [UIFont systemFontOfSize:13];
        _forumNumLab.textColor = [UIColor redColor];
    }
    return _forumNumLab;
}
-(UILabel *)forumContentLab
{
    if (!_forumContentLab) {
        _forumContentLab = [[UILabel alloc] init];
        _forumContentLab.text = @"看了这么长时间的最强大脑，我觉得这个节目真的很好看呀。看了这么长时间的最强大脑，我觉得这个节目真的很好看呀。";
        _forumContentLab.font = [UIFont systemFontOfSize:13];
        _forumContentLab.textColor = [UIColor blackColor];
        _forumContentLab.numberOfLines = 3;
    }
    return _forumContentLab;
}
-(UIImageView *)forumUserImg
{
    if (!_forumUserImg) {
        _forumUserImg = [[UIImageView alloc] init];
        _forumUserImg.image = [UIImage imageNamed:@"icon_tab_me"];
    }
    return _forumUserImg;
}
-(UILabel *)forumUserLab
{
    if (!_forumUserLab) {
        _forumUserLab = [[UILabel alloc] init];
        _forumUserLab.text = @"秋分落叶";
        _forumUserLab.font = [UIFont systemFontOfSize:13];
        _forumUserLab.textColor = [UIColor blackColor];
    }
    return _forumUserLab;
}
-(UIImageView *)forumTimeImg
{
    if (!_forumTimeImg) {
        _forumTimeImg = [[UIImageView alloc] init];
        _forumTimeImg.image = [UIImage imageNamed:@"share_time"];
    }
    return _forumTimeImg;
}
-(UILabel *)forumTimeLab
{
    if (!_forumTimeLab) {
        _forumTimeLab = [[UILabel alloc] init];
        _forumTimeLab.text = @"刚刚";
        _forumTimeLab.font = [UIFont systemFontOfSize:13];
        _forumTimeLab.textColor = [UIColor blackColor];
    }
    return _forumTimeLab;
}

@end
