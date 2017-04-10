//
//  ESToDetailPeopleCell.m
//  EasyShop
//
//  Created by jiushou on 16/10/11.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESToDetailPeopleCell.h"
#import "GSTimeTool.h"
@interface ESToDetailPeopleCell()
{
    
    dispatch_source_t _timer;
}

@property (nonatomic,strong)UIView*lineView;
@property (nonatomic,strong) UIImageView*userImageView;
@property (nonatomic,strong)UILabel*nameLabel;
@property (nonatomic,strong)UILabel*tipsLabel;
@property (nonatomic,strong) UILabel*areaLabel;
@property (nonatomic,strong) UIView*topLineView;
@property (nonatomic,strong) UIView*bottomLineView;
@property (nonatomic,strong) UIView*rectangularView;//矩形的view;
@property (nonatomic,strong) UIView*ellipseView;//椭圆的view;
@property (nonatomic,strong) UILabel*joinLabel;
@property (nonatomic,strong) UIImageView* arrowImageView;//箭头的imageview
@property (nonatomic,strong) UILabel*timeLabel;//小时的label;
@property (nonatomic,strong) UILabel*secondLabel;//秒钟钟的label;
@property (nonatomic,strong) UILabel*minuteLabel;//分钟的label;
@property (nonatomic,strong) UILabel*leftLabel;//左边的冒号label;
@property (nonatomic,strong) UILabel*rightLabel;//右边的冒号label;
@property (nonatomic,strong) UILabel*remainLabel;//剩下
@property (nonatomic,strong) UILabel*endLabel;//结束


@property (nonatomic,assign)int allTime;//总时间
@property (nonatomic,assign)int secondTime;//秒钟
@property (nonatomic,assign)int minuteTime;//分钟
@property (nonatomic,assign)int time;//时钟

@end
@implementation ESToDetailPeopleCell
-(void)setRespone:(ClusterRespone *)respone{
    _respone=respone;
    self.nameLabel.text=respone.name;
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:respone.logo] placeholderImage:[UIImage imageNamed:@"bg100"]];
    self.tipsLabel.text=[NSString stringWithFormat:@"还差%@人成团",respone.gap_num];
    self.areaLabel.text=respone.city;
    self.allTime=[respone.gap_time intValue];
    self.secondTime=self.allTime%60;//秒钟
    self.secondLabel.text=[NSString stringWithFormat:@"%.2d",(self.allTime%60)];
    self.minuteTime=self.allTime/60%60;//分
    self.time=self.allTime/60/60;//时
    self.timeLabel.text=[NSString stringWithFormat:@"%.2d",self.time];
    self.minuteLabel.text=[NSString stringWithFormat:@"%.2d",self.minuteTime];
    
    [self get];
    
}

-(void)get{
    
    //    NSTimeInterval period = 1.0; //设置时间间隔
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    //    dispatch_source_set_event_handler(_timer, ^{
    //        //在这里执行事件
    //        NSLog(@"每秒执行test");
    //    });
    //
    //    dispatch_resume(_timer);
    
    
    __block int timeout = self.secondTime;
    __block int alltime = self.allTime;
    if (self.allTime!=0) {
        @weakify(self);
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{//block 执行事件
            @strongify(self);
            
            NSLog(@"alltime%d",self.allTime);
            
            if(timeout <=0&&self.allTime!=0){
                if (self.minuteTime==0&&self.time!=0) {
                    self.minuteTime=59;
                }else if(self.minuteTime!=0){
                    self.minuteTime--;
                }else if (self.minuteTime==0&&self.time==0){
                    self.minuteTime=0;
                }
                @weakify(self);
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self);
                    self.secondLabel.text=[NSString stringWithFormat:@"%.2d",timeout];
                    
                    
                });
                timeout=59;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self);
                    self.secondLabel.text=[NSString stringWithFormat:@"%.2d",timeout];
                    self.minuteLabel.text=[NSString stringWithFormat:@"%.2d",self.minuteTime];
                    
                });
                if (self.minuteTime<=0) {
                    if (self.time==0) {
                        
                    }else{
                        self.time--;
                    }
                    @weakify(self);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @strongify(self);
                        self.timeLabel.text=[NSString stringWithFormat:@"%.2d",self.time];
                        
                        self.secondLabel.text=[NSString stringWithFormat:@"%.2d",timeout];
                        
                    });
                }
                
                
            }else if(self.allTime!=0){
                @weakify(self);
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self);
                    //设置界面的按钮显示 根据自己需求设置
                    self.secondLabel.text=[NSString stringWithFormat:@"%.2d",timeout];
                    //
                });
                
                timeout--;
                self.allTime--;
                if (self.allTime<=0) {
                    
                    //dispatch_source_cancel(_timer);
                    //                    _timer=nil;
                    //
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        @strongify(self);
                        self.timeLabel.text=@"00";
                        self.minuteLabel.text=@"00";
                        self.secondLabel.text=@"00";
                        
                        
                    });
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [[NSNotificationCenter defaultCenter]postNotificationName:ESClusterTimeZero object:nil];
                    });
                    return ;
                }
                
                
            }
        });
        dispatch_resume(_timer);//作用是恢复
    }
}
-(void)dealloc{
    
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    
    
}
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=RGBA(235 ,235, 235, 1);
    }
    return _lineView;
}
-(UIImageView *)userImageView{
    if (_userImageView==nil) {
        _userImageView=[[UIImageView alloc]init];
        _userImageView.image=[UIImage imageNamed:@"110.jpg"];
        _userImageView.layer.cornerRadius=26;
        _userImageView.layer.masksToBounds=YES;
    }
    return _userImageView;
}
-(UILabel *)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.font=[UIFont systemFontOfSize:13];
        _nameLabel.text=@"就手国际";
        _nameLabel.textColor=AllTextColor;
    }
    return _nameLabel;
}
-(UILabel *)tipsLabel{
    if (_tipsLabel==nil) {
        _tipsLabel=[[UILabel alloc]init];
        _tipsLabel.font=[UIFont systemFontOfSize:11];
        _tipsLabel.textColor=RGB(233, 40, 46);
        _tipsLabel.textAlignment=NSTextAlignmentRight;
        _tipsLabel.text=@"还差一个人成团";
    }
    return _tipsLabel;
}
-(UILabel *)areaLabel{
    if (_areaLabel==nil) {
        _areaLabel=[[UILabel alloc]init];
        _areaLabel.text=@"中国";
        _areaLabel.textColor=AllTextColor;
        _areaLabel.font=[UIFont systemFontOfSize:11];
        
    }
    return _areaLabel;
}
-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.font=[UIFont systemFontOfSize:11];
        _timeLabel.textAlignment=NSTextAlignmentRight;
        _timeLabel.text=@"24";
        _timeLabel.textColor=AllTextColor;
    }
    return _timeLabel;
}
-(UILabel *)minuteLabel{
    if (_minuteLabel==nil) {
        _minuteLabel=[[UILabel alloc]init];
        _minuteLabel.font=[UIFont systemFontOfSize:11];
        _minuteLabel.textAlignment=NSTextAlignmentCenter;
        _minuteLabel.textColor=AllTextColor;
        _minuteLabel.text=@"58";
    }
    return _minuteLabel;
}
-(UILabel *)secondLabel{
    if (_secondLabel==nil) {
        _secondLabel=[[UILabel alloc]init];
        _secondLabel.font=[UIFont systemFontOfSize:11];
        _secondLabel.textAlignment=NSTextAlignmentCenter;
        _secondLabel.textColor=AllTextColor;
        _secondLabel.text=@"59";
        
    }
    return _secondLabel;
}
-(UILabel *)leftLabel{
    if (_leftLabel==nil) {
        _leftLabel=[[UILabel alloc]init];
        _leftLabel.font=[UIFont systemFontOfSize:12];
        
        
        _leftLabel.textAlignment=NSTextAlignmentCenter;
        _leftLabel.text=@":";
    }
    return _leftLabel;
}
-(UILabel *)rightLabel{
    if (_rightLabel==nil) {
        _rightLabel=[[UILabel alloc]init];
        _rightLabel.font=[UIFont systemFontOfSize:12];
        _rightLabel.textAlignment=NSTextAlignmentCenter;
        _rightLabel.text=@":";
        
    }return _rightLabel;
}
-(UILabel *)remainLabel{
    if (_remainLabel==nil) {
        _remainLabel=[[UILabel alloc]init];
        _remainLabel.font=[UIFont systemFontOfSize:11];
        _remainLabel.textAlignment=NSTextAlignmentCenter;
        _remainLabel.text=@"剩余";
        _remainLabel.textColor=AllTextColor;
    }
    return _remainLabel;
}
-(UILabel *)endLabel{
    if (_endLabel==nil) {
        _endLabel=[[UILabel label]init];
        _endLabel.font=[UIFont systemFontOfSize:11];
        _endLabel.text=@"结束";
        _endLabel.textColor=AllTextColor;
        _endLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _endLabel;
}
-(UIView *)topLineView{
    if (_topLineView==nil) {
        _topLineView=[[UIView alloc]init];
        _topLineView.backgroundColor=RGB(233, 40, 46);
    }
    return _topLineView;
}
-(UIView *)bottomLineView{
    if (_bottomLineView==nil) {
        _bottomLineView=[[UIView alloc]init];
        _bottomLineView.backgroundColor=RGB(233, 40, 46);
        
    }
    return _bottomLineView;
}
-(UIView *)rectangularView{
    if (_rectangularView==nil) {
        _rectangularView=[[UIView alloc]init];
        _rectangularView.backgroundColor=RGB(233, 40, 46);
        
    }
    return _rectangularView;
}
-(UIView *)ellipseView{
    if (_ellipseView==nil) {
        _ellipseView=[[UIView alloc]init];
        _ellipseView.backgroundColor=RGB(233, 40, 46);
        _ellipseView.layer.cornerRadius=21;
        _ellipseView.layer.masksToBounds=YES;
        
    }
    return _ellipseView;
}
-(UILabel *)joinLabel{
    if (_joinLabel==nil) {
        _joinLabel=[[UILabel alloc]init];
        _joinLabel.font=[UIFont systemFontOfSize:12];
        _joinLabel.textAlignment=NSTextAlignmentCenter;
        _joinLabel.textColor=[UIColor whiteColor];
        _joinLabel.text=@"去参团";
    }
    return _joinLabel;
}
-(UIImageView *)arrowImageView{
    if (_arrowImageView==nil) {
        _arrowImageView=[[UIImageView alloc]init];
        _arrowImageView.image=[UIImage imageNamed:@""];
    }
    return _arrowImageView;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.allTime=0;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.userImageView];
        [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@7);
            make.bottom.equalTo(@(-5));
            make.left.equalTo(@10);
            make.width.equalTo(@52);
        }];
        [self.contentView addSubview:self.topLineView];
        [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@12);
            make.left.equalTo(self.userImageView.mas_right).offset(-3);
            make.height.equalTo(@1);
            make.right.equalTo(@(-76));
        }];
        [self.contentView addSubview:self.bottomLineView];
        [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-10));
            make.height.equalTo(@1);
            make.left.equalTo(self.userImageView.mas_right).offset(-3);
            make.right.equalTo(@(-76));
        }];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topLineView.mas_bottom).offset(0);
            make.left.equalTo(self.userImageView.mas_right).offset(15);
            make.width.equalTo(@70);
            make.height.equalTo(@17);
            
        }];
        [self.contentView addSubview:self.areaLabel];
        [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bottomLineView.mas_top).offset(-3);
            make.height.equalTo(@14);
            make.left.equalTo(self.userImageView.mas_right).offset(15);
            make.width.equalTo(@70);
        }];
        [self.contentView addSubview:self.ellipseView];
        [self.ellipseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.height.equalTo(@42);
            make.width.equalTo(@42);
            make.top.equalTo(@12);
            
        }];
        [self.contentView addSubview:self.rectangularView];
        [self.rectangularView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@42);
            make.left.equalTo(self.topLineView.mas_right).offset(0);
            make.right.equalTo(@(-31));
            make.top.equalTo(@12);
        }];
        [self.contentView addSubview:self.joinLabel];
        [self.joinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topLineView.mas_bottom).offset(0);
            make.bottom.equalTo(self.bottomLineView.mas_top).offset(0);
            make.width.equalTo(@39);
            make.right.equalTo(@(-25));
        }];
        [self.contentView addSubview:self.arrowImageView];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
        [self.contentView addSubview:self.tipsLabel];
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topLineView.mas_bottom).offset(0);
            make.left.equalTo(self.nameLabel.mas_right).offset(0);
            make.height.equalTo(@17);
            make.right.equalTo(self.rectangularView.mas_left).offset(-3);
        }];
        [self.contentView addSubview:self.endLabel];
        [self.endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rectangularView.mas_left).offset(-3);;
            make.bottom.equalTo(self.bottomLineView.mas_top).offset(-3);
        }];
        [self.contentView addSubview:self.secondLabel];
        [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@15);
            make.right.equalTo(self.endLabel.mas_left).offset(-2);
            make.centerY.equalTo(self.endLabel.mas_centerY).offset(0);
        }];
        [self.contentView addSubview:self.rightLabel];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.secondLabel.mas_left).offset(-2);
            make.centerY.equalTo(self.endLabel.mas_centerY).offset(0);
        }];
        [self.contentView addSubview:self.minuteLabel];
        [self.minuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@15);
            make.right.equalTo(self.rightLabel.mas_left).offset(-2);
            make.centerY.equalTo(self.endLabel.mas_centerY).offset(0);
        }];
        [self.contentView addSubview:self.leftLabel];
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.minuteLabel.mas_left).offset(-2);
            make.centerY.equalTo(self.endLabel.mas_centerY).offset(0);
        }];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@30);
            make.right.equalTo(self.leftLabel.mas_left).offset(-2);
            make.centerY.equalTo(self.endLabel.mas_centerY).offset(0);
        }];
        [self.contentView addSubview:self.remainLabel];
        [self.remainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.timeLabel.mas_left).offset(-2);
            make.centerY.equalTo(self.endLabel.mas_centerY).offset(0);
        }];
        //        [self.contentView addSubview:self.timeLabel];
        //        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        //            make.left.equalTo(self.nameLabel.mas_right).offset(0);
        //            make.height.equalTo(@17);
        //
        //        }];
        [self.contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
            make.right.equalTo(@(-10));
            make.left.equalTo(@10);
            make.height.equalTo(@1);
        }];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
