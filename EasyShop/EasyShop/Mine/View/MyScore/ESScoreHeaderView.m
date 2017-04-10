//
//  ESScoreHeaderView.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/21.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESScoreHeaderView.h"

@interface ESScoreHeaderView()

@property (nonatomic, strong) UIImageView *userImageView;//用户头像
@property (nonatomic, strong) UILabel     *userNameLab;//用户名称
@property (nonatomic, strong) UILabel     *userScoreLab;//拥有积分
@property (nonatomic, strong) UILabel     *userScoreNum;//积分数目
@property (nonatomic, strong) UIView*bottomView;
@property (nonatomic,strong) UIImageView*camImageView;

@end

@implementation ESScoreHeaderView
-(UIImageView *)camImageView{
    if (_camImageView==nil) {
        _camImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"camera"]];
        _camImageView.userInteractionEnabled=YES;
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [_camImageView addGestureRecognizer:tap];
    }
    return _camImageView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}
-(UIView *)bottomView{
    if (_bottomView==nil) {
        _bottomView=[[UIView alloc]init];
        _bottomView.backgroundColor=RGB(247, 247, 247);
//        _bottomView.backgroundColor=[UIColor yellowColor];
    }
    return _bottomView;
}
-(void)setImageStr:(NSString *)imageStr{
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil];
}
-(void)setupViews
{
    [self addSubview:self.userImageView];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(@0);
        make.top.mas_equalTo(@30);
        make.width.height.mas_equalTo(@50);
    }];
//    [self addSubview:self.camImageView];
//    [self.camImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.equalTo(@20);
//        make.centerX.equalTo(self.userImageView.mas_centerX).offset(20);
//        make.centerY.equalTo(self.userImageView.mas_centerY).offset(15);
//    }];
    [self addSubview:self.userNameLab];
    [self.userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(@0);
        make.top.mas_equalTo(self.userImageView.mas_bottom).offset(25);
        
    }];
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];

}

-(UIImageView *)userImageView
{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.layer.cornerRadius=25;
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [_userImageView addGestureRecognizer:tap];
        _userImageView.layer.masksToBounds=YES;
        _userImageView.userInteractionEnabled=YES;
        _userImageView.image = [UIImage imageNamed:@"icon_home_cate"];
    }
    return _userImageView;
}
-(void)tapAction{
    if (self.tapBlock) {
        self.tapBlock();
    }
}
-(UILabel *)userNameLab
{
    if (!_userNameLab) {
        _userNameLab = [[UILabel alloc] init];
        _userNameLab.textAlignment = NSTextAlignmentCenter;
        _userNameLab.textColor=AllTextColor;
        _userNameLab.text=[kUserManager .userInfo.mobile stringByReplacingCharactersInRange:NSMakeRange(4,3)withString:@"***"];
        
    }
    return _userNameLab;
}
-(UILabel *)userScoreLab
{
    if (!_userScoreLab) {
        _userScoreLab = [[UILabel alloc] init];
        _userScoreLab.textAlignment = NSTextAlignmentCenter;
        _userScoreLab.text = @"拥有积分:";
    }
    return _userScoreLab;
}
-(UILabel *)userScoreNum
{
    if (!_userScoreNum) {
        _userScoreNum = [[UILabel alloc] init];
        _userScoreNum.textColor = [UIColor redColor];
        _userScoreNum.textAlignment = NSTextAlignmentCenter;
        _userScoreNum.text = @"92";
        _userScoreNum.font = [UIFont boldSystemFontOfSize:40];
    }
    return _userScoreNum;
}
-(UILabel *)scoreRecordLab
{
    if (!_scoreRecordLab) {
        _scoreRecordLab = [[UILabel alloc] init];
        _scoreRecordLab.textAlignment = NSTextAlignmentCenter;
        _scoreRecordLab.text = @"积分纪录";
    }
    return _scoreRecordLab;
}

@end
