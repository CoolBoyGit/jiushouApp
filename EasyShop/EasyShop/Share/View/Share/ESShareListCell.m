//
//  ESShareListCell.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/18.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShareListCell.h"
#import "ESCommentController.h"

@interface ESShareListCell()

@property (nonatomic, strong) UIImageView *userImg;//用户头像
@property (nonatomic, strong) UILabel     *nameLab;//用户名称
@property (nonatomic, strong) UILabel     *signLab;//用户签名信息
@property (nonatomic, strong) UIButton    *attenBtn;//＋关注
@property (nonatomic, strong) UIImageView *shopImg;//用户头像
@property (nonatomic, strong) UILabel     *contentLab;//用户名称
@property (nonatomic, strong) UIButton    *shareBtn;//分享
@property (nonatomic, strong) UIButton    *commonBtn;//评论

@end

@implementation ESShareListCell

- (void)setFeedInfo:(ShareFeedInfo *)feedInfo
{
    _feedInfo = feedInfo;
    
    [self.shopImg sd_setImageWithURL:[NSURL URLWithString:_feedInfo.src_addr]
                    placeholderImage:[UIImage imageNamed:@"page2"]];
    self.contentLab.text = _feedInfo.feed_content;
}

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
    [self.contentView addSubview:self.userImg];
    [self.userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(@10);
        make.width.height.mas_equalTo(@(60));
    }];
    
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userImg.mas_right).with.offset(5);
        make.top.mas_equalTo(self.userImg.mas_top).with.offset(10);;
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@150);
    }];
    
    [self.contentView addSubview:self.signLab];
    [self.signLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userImg.mas_right).with.offset(5);
        make.bottom.mas_equalTo(self.userImg.mas_bottom).with.offset(-10);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@150);
    }];
    
    [self.contentView addSubview:self.attenBtn];
    [self.attenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@(-10));
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@20);
        make.centerY.mas_equalTo(self.userImg.mas_centerY).with.offset(0);;
    }];
    
    [self.contentView addSubview:self.shopImg];
    [self.shopImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userImg.mas_bottom).with.offset(5);
        make.left.right.mas_equalTo(@0);
        make.height.mas_equalTo(@(200));
    }];
    
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shopImg.mas_bottom).with.offset(10);
        make.left.right.mas_equalTo(@10);
        make.height.mas_equalTo(@(40));
    }];
    
    [self.contentView addSubview:self.shareBtn];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@(-15));
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@20);
        make.bottom.mas_equalTo(@-10);
    }];
    
    [self.contentView addSubview:self.commonBtn];
    [self.commonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.shareBtn.mas_left).with.offset(-10);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@20);
        make.bottom.mas_equalTo(@-10);
    }];
}

#pragma mark
#pragma mark - lazy init
-(UIImageView *)userImg
{
    if (!_userImg) {
        _userImg = [[UIImageView alloc] init];
        _userImg.contentMode = UIViewContentModeScaleAspectFit;
        _userImg.image = [UIImage imageNamed:@"share_user"];
        _userImg.layer.cornerRadius = 30;
        _userImg.layer.masksToBounds = YES;
    }
    return _userImg;
}
-(UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.text = @"秋分落叶";
        _nameLab.font = [UIFont systemFontOfSize:13];
        _nameLab.textColor = [UIColor blackColor];
    }
    return _nameLab;
}
-(UILabel *)signLab
{
    if (!_signLab) {
        _signLab = [[UILabel alloc] init];
        _signLab.text = @"今天天气好晴朗";
        _signLab.font = [UIFont systemFontOfSize:13];
        _signLab.textColor = [UIColor grayColor];
    }
    return _signLab;
}
-(UIButton *)attenBtn
{
    if (!_attenBtn) {
        _attenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_attenBtn setTitle:@"+关注" forState:UIControlStateNormal];
        _attenBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _attenBtn.backgroundColor = [UIColor redColor];
        _attenBtn.layer.cornerRadius = 10;
        _attenBtn.layer.masksToBounds = YES;
    }
    return _attenBtn;
}
-(UIImageView *)shopImg
{
    if (!_shopImg) {
        _shopImg = [[UIImageView alloc] init];
        _shopImg.image = [UIImage imageNamed:@"page2"];
    }
    return _shopImg;
}
-(UILabel *)contentLab
{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] init];
        _contentLab.text = @"这个产品真是嗨，效果特别棒。这个产品真是嗨，效果特别棒。这个产品真是嗨，效果特别棒。这个产品真是嗨，效果特别棒。";
        _contentLab.numberOfLines = 0;
        _contentLab.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLab.font = [UIFont systemFontOfSize:13];
        _contentLab.textColor = [UIColor grayColor];
    }
    return _contentLab;
}
-(UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        _shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
        _shareBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_shareBtn setImage:[UIImage imageNamed:@"share_share"] forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}
-(UIButton *)commonBtn
{
    if (!_commonBtn) {
        _commonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commonBtn setTitle:@"25" forState:UIControlStateNormal];
        [_commonBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        _commonBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//        _commonBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
        _commonBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_commonBtn setImage:[UIImage imageNamed:@"share_common"] forState:UIControlStateNormal];
        _commonBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_commonBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commonBtn;
}

-(void)shareAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(ESShareListCellShare)]) {
        [_delegate ESShareListCellShare];
    }
}
-(void)commentAction
{
    ESCommentController *vc = [[ESCommentController alloc] init];
    [[AppDelegate shared] pushViewController:vc animated:YES];
}

@end
