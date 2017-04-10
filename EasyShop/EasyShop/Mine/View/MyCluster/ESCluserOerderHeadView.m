//
//  ESCluserOerderHeadView.m
//  EasyShop
//
//  Created by 就手国际 on 16/12/17.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESCluserOerderHeadView.h"
@interface ESCluserOerderHeadView()
@property (nonatomic,strong) UILabel*timeLabel;
@property (nonatomic,strong) UILabel*statusLabel;
@end
@implementation ESCluserOerderHeadView
-(void)setRespone:(GetClusterListRespone *)respone{
    self.timeLabel.text=[GSTimeTool formatterNumber:respone.pay_time toType:GSTimeType_YYYYMMdd];
    NSString*tipsStr=[[NSString alloc]init];
    switch ([respone.status intValue]) {
        case 2:
            tipsStr=@"拼团中";
            break;
        case 3:
            tipsStr=@"拼团成功";
            break;
        case 4:
            tipsStr=@"拼团失败";
            break;
        default:
            break;
    }
    self.statusLabel.text=tipsStr;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@12);
            make.centerY.equalTo(self.mas_centerY);
        }];
        [self addSubview:self.statusLabel];
        [self .statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-12));
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}
-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.textColor=AllTextColor;
        _timeLabel.font=[UIFont systemFontOfSize:14];
    }
    return _timeLabel;
}
-(UILabel *)statusLabel{
    if (_statusLabel==nil) {
        _statusLabel=[[UILabel alloc]init];
        _statusLabel.textColor=AllTextColor;
        _statusLabel.font=[UIFont systemFontOfSize:14];
    }
    return _statusLabel;
}
@end
