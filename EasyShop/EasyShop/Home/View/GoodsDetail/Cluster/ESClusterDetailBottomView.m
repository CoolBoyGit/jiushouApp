//
//  ESClusterDetailBottomView.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterDetailBottomView.h"
@interface ESClusterDetailBottomView()
@property (nonatomic,strong) UIButton*moreButton;
@property (nonatomic,strong) UIButton*joinButton;
@property (nonatomic,strong) UIButton*createClusterButton;

@end
@implementation ESClusterDetailBottomView
-(void)setClusterDetailRespone:(GetClusterDetailRespone *)clusterDetailRespone{
    if ([clusterDetailRespone.status isEqualToString:@"2"]) {
        if ([clusterDetailRespone.gap_time intValue]<=0) {
            
            self.joinButton.hidden=YES;
            self.createClusterButton.hidden=NO;
        }else{
            self.joinButton.hidden=NO;
            [self.joinButton setTitle:[NSString stringWithFormat:@"还差%@人拼团成功",clusterDetailRespone.gap_num] forState:UIControlStateNormal];
        }
        
        
    }else{
        self.joinButton.hidden=YES;
        self.createClusterButton.hidden=NO;
    }
}
-(instancetype)init{
    if (self=[super init]) {
        self.backgroundColor=RGBA(220, 220, 220, 0.6);
        [self addSubview:self.moreButton];
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(@15 );
            make.bottom.equalTo(@(-15));
            make.width.equalTo(@100);
        }];
        [self addSubview:self.joinButton];
        [self.joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.moreButton.mas_right).offset(15);
            make.right.equalTo(@(-15));
            make.bottom.equalTo(@(-15));
            make.top.equalTo(@15);
        }];
        [self addSubview:self.createClusterButton];
        [self.createClusterButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.moreButton.mas_right).offset(15);
            make.right.equalTo(@(-15));
            make.bottom.equalTo(@(-15));
            make.top.equalTo(@15);

        }];
    }
    return self;
}
-(UIButton *)createClusterButton{
    if (_createClusterButton==nil) {
        _createClusterButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_createClusterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _createClusterButton.layer.cornerRadius=4;
        _createClusterButton.layer.masksToBounds=YES;
        [_createClusterButton setBackgroundColor:RGB(233, 40, 46)];
        [_createClusterButton setTitle:@"我也开个团" forState:UIControlStateNormal];
        _createClusterButton.hidden=YES;
        [_createClusterButton addTarget:self action:@selector(createClusterButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _createClusterButton;
}
-(void)createClusterButtonAction{
    if (self.createClusterBlock) {
        self.createClusterBlock();
    }
}
-(UIButton *)moreButton{
    if (_moreButton==nil) {
        _moreButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitle:@"更多拼团" forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _moreButton.layer.cornerRadius=4;
        _moreButton.layer.masksToBounds=YES;
        [_moreButton addTarget:self action:@selector(moreButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_moreButton setBackgroundColor:RGBA(206, 206, 206, 1)];
        _moreButton.titleLabel.textAlignment=NSTextAlignmentCenter;
        
    
        
    }
    return _moreButton;
}
-(void)moreButtonAction{
    if (self.moreButtonBlock) {
        self.moreButtonBlock();
    }
}

-(UIButton *)joinButton{
    if (_joinButton==nil) {
        _joinButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_joinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _joinButton.layer.cornerRadius=4;
        _joinButton.layer.masksToBounds=YES;
        [_joinButton setBackgroundColor:RGB(233, 40, 46)];
        _joinButton.hidden=YES;
        [_joinButton setTitle:@"邀请好友参团" forState:UIControlStateNormal];
        [_joinButton addTarget:self action:@selector(joinButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _joinButton;
}
-(void)joinButtonAction{
    if (self.joinButtonActionBlock ) {
        self.joinButtonActionBlock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
