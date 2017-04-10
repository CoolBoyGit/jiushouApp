//
//  ESRefundListHeardView.m
//  EasyShop
//
//  Created by jiushou on 16/7/5.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESRefundListHeardView.h"
@interface ESRefundListHeardView()
@property (nonatomic,strong)UILabel*timeLabel;
@property (nonatomic,strong)UILabel *statusLabel;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIImageView*tipsImageView;
@end
@implementation ESRefundListHeardView
-(void)setRefundRespone:(RefundResultRespone *)refundRespone{
    if ([NSString stringWithFormat:@"%@",refundRespone.apply_time].length==0) {
        self.timeLabel.text=[NSString stringWithFormat:@"退款时间:%@",refundRespone.apply_time];
    }else{
        
    }
    if ([refundRespone.refund_status intValue]==5) {
        self.statusLabel.text=@"退款成功";
    }else{
         self.statusLabel.text=@"正在处理...";
    }
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=RGB(247, 247, 247);
        [self addSubview:self.tipsImageView];
        [self.tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(ScreenWidth *(205/617.0)));
            make.left.right.equalTo(@0);
            make.top.equalTo(@0);
        }];
        [self.tipsImageView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
    }
    return self;
}

-(UIImageView *)tipsImageView{
    if (_tipsImageView==nil) {
        _tipsImageView=[[UIImageView alloc]init];
        _tipsImageView.image=[UIImage imageNamed:@"succeedDetail.jpg"];
    }
    return _tipsImageView;
}

-(UIView*)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        
        _lineView.backgroundColor=RGB(240, 240, 240);
        
    }
    return _lineView;
}
-(UILabel*)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _timeLabel.font=[UIFont systemFontOfSize:14];
        _timeLabel.textColor=[UIColor whiteColor ];
        _timeLabel.textAlignment=NSTextAlignmentLeft;
        
    }
    return _timeLabel;
}
-(UILabel*)statusLabel{
    if (_statusLabel==nil) {
        _statusLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _statusLabel.textAlignment=NSTextAlignmentRight;
        _statusLabel.textColor=[UIColor whiteColor];
        _statusLabel.font=[UIFont systemFontOfSize:15];
    }
    return _statusLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
