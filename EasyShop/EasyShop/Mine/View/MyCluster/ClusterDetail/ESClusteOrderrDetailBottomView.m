//
//  ESToghterBottomView.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/21.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusteOrderrDetailBottomView.h"
@interface ESClusteOrderrDetailBottomView()
@property (nonatomic,strong) UIButton*logisticsButton;
@property (nonatomic,strong) UIButton*sureButton;
@property (nonatomic,strong) UIView*bgView;
@property (nonatomic,strong) UIButton*commentButton;


@end
@implementation ESClusteOrderrDetailBottomView
-(void)setRespone:(GetClusterOrderDetailRespone *)respone{
    if (respone.clusterOrderStatus==ClusterOrderStatus_WaitReply) {
        self.commentButton.hidden=NO;
        
    }else if (respone.clusterOrderStatus==ClusterOrderStatus_WaitSure){
        self.sureButton.hidden=NO;
    }
}
-(UIButton *)logisticsButton{
    if (_logisticsButton==nil) {
        _logisticsButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_logisticsButton setTitle:@"查看物流" forState:UIControlStateNormal];
        [_logisticsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _logisticsButton.hidden=YES;
        _logisticsButton.layer.cornerRadius=4;
        _logisticsButton.layer.masksToBounds=YES;
        [_logisticsButton setBackgroundColor:RGB(233, 40, 46)];
        [_logisticsButton addTarget:self action:@selector(logisticsButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logisticsButton;
}
-(void)logisticsButtonAction{
    if (self.seeLogiticsBlock) {
        self.seeLogiticsBlock();
    }
}
-(UIButton *)sureButton{
    if (_sureButton==nil) {
        _sureButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"确认收货" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureButton.hidden=YES;
        _sureButton.layer.cornerRadius=4;
        _sureButton.layer.masksToBounds=YES;
        _sureButton.backgroundColor=RGB(233, 40, 46);
        [_sureButton addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}
-(void)sureButtonAction{
    if (self.sureButtonBlock) {
        self.sureButtonBlock();
    }
}
-(UIButton *)commentButton{
    if (_commentButton==nil) {
        _commentButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_commentButton setTitle:@"评价" forState:UIControlStateNormal];
        [_commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commentButton.hidden=YES;
        _commentButton.layer.cornerRadius=4;
        _commentButton.layer.masksToBounds=YES;
        _commentButton.backgroundColor=RGB(233, 40, 46);
        [_commentButton addTarget:self action:@selector(commentButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentButton;
}
-(void)commentButtonAction{
    if (self.commentButtonBlock) {
        self.commentButtonBlock();
    }
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=[UIColor lightGrayColor];
    }
    return _bgView;
}
-(instancetype)init{
    if (self=[super init]) {
        self.backgroundColor=RGB(247, 247, 247);
        [self addSubview:self.logisticsButton  ];
        [self.logisticsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.right.equalTo(@(-10));
            make.bottom.equalTo(@(-10));
            make.width.equalTo(@80);
        }];
        [self addSubview:self.sureButton];
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.right.equalTo(@(-10));
            make.bottom.equalTo(@(-10));
            make.width.equalTo(@80);
        }];
        [self addSubview:self.commentButton];
        [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.right.equalTo(@(-90));
            make.bottom.equalTo(@(-10));
            make.width.equalTo(@80);
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
