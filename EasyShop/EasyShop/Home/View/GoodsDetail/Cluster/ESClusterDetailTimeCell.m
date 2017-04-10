//
//  ESJoinListTimeCell.m
//  EasyShop
//
//  Created by jiushou on 16/10/12.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterDetailTimeCell.h"
@interface ESClusterDetailTimeCell()
{
    
    dispatch_source_t _timer;
}
@property (nonatomic,strong)UILabel*tipsLabel;
@property (nonatomic,strong)UILabel*timeLabel;
@property (nonatomic,strong)UILabel*minuteLabel;
@property (nonatomic,strong)UILabel*secondLabel;
@property (nonatomic,strong)UILabel*oneLabel;
@property (nonatomic,strong)UILabel*twoLabel;
@property (nonatomic,strong)UIView *leftLineView;
@property (nonatomic,strong)UIView*rightLineView;
@property (nonatomic,strong)UILabel*surplusLabel;//剩余
@property (nonatomic,strong)UILabel*endLabel;//结束


@property (nonatomic,assign)int allTime;//总时间
@property (nonatomic,assign)int secondTime;//秒钟
@property (nonatomic,assign)int minuteTime;//分钟
@property (nonatomic,assign)int time;//时钟

@end
@implementation ESClusterDetailTimeCell
-(void)setClusterdetaliRespone:(GetClusterDetailRespone *)clusterdetaliRespone{
    if ([clusterdetaliRespone.status isEqualToString:@"3"]||[clusterdetaliRespone.status isEqualToString:@"4"]) {
        [self.contentView removeAllSubviews];
    }else{
        
    }
    self.tipsLabel.text=[NSString stringWithFormat:@"还差%@人成团,等候您的参与",clusterdetaliRespone.gap_num];
    self.allTime=[clusterdetaliRespone.gap_time intValue];
    self.secondTime=self.allTime%60;
    self.secondLabel.text=[NSString stringWithFormat:@"%.2d",(self.allTime%60)];
    self.minuteTime=self.allTime/60%60;
    self.time=self.allTime/60/60;
    self.timeLabel.text=[NSString stringWithFormat:@"%.2d",self.time];
    self.minuteLabel.text=[NSString stringWithFormat:@"%.2d",self.minuteTime];
    
    [self get];
}
-(void)addNOtifiCation{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SecondToZero) name:ClusterSecondToZero object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MinuteReduce) name:ClusterMinuteReduce object:nil];
}
-(void)SecondToZero{
    self.minuteLabel.text=[NSString stringWithFormat:@"%.2d",self.minuteTime];
    
}
-(void)MinuteReduce{
    
}
-(void)dealloc{
    
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
}

-(void)get{
    if (_timer==nil) {
        __block int timeout = self.secondTime;
        if (self.allTime!=0) {
            @weakify(self);
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{//block 执行事件
                @strongify(self);
                
                NSLog(@"self.alltime%d",self.allTime);
                
                
                if(timeout <=0&&self.allTime!=0){
                    if (self.minuteTime==0&&self.time!=0) {
                        self.minuteTime=59;
                    }else if(self.minuteTime!=0){
                        self.minuteTime--;
                    }else if (self.minuteTime==0&&self.time==0){
                        self.minuteTime=0;
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.secondLabel.text=[NSString stringWithFormat:@"%.2d",timeout];
                        
                        
                    });
                    timeout=59;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.secondLabel.text=[NSString stringWithFormat:@"%.2d",timeout];
                        self.minuteLabel.text=[NSString stringWithFormat:@"%.2d",self.minuteTime];
                        
                    });
                    if (self.minuteTime<=0) {
                        if (self.time==0) {
                            
                        }else{
                            self.time--;
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.timeLabel.text=[NSString stringWithFormat:@"%.2d",self.time];
                            
                            self.secondLabel.text=[NSString stringWithFormat:@"%.2d",timeout];
                            
                        });
                    }
                    
                    
                }else if(self.allTime!=0){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //设置界面的按钮显示 根据自己需求设置
                        self.secondLabel.text=[NSString stringWithFormat:@"%.2d",timeout];
                        //
                    });
                    
                    timeout--;
                    self.allTime--;
                    if (self.allTime<=0) {
//                        
//                        dispatch_source_cancel(_timer);
//                        _timer=nil;
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
    
    // NSLog(@"%d,%d,%d",self.time,self.minuteTime,self.secondTime);
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addNOtifiCation];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.contentView. backgroundColor=RGB(247, 247, 247);
        [self.contentView addSubview:self.tipsLabel];
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@32);
            make.height.equalTo(@18);
            make.left.right.equalTo(@0);
        }];
        [self.contentView addSubview:self.minuteLabel];
        [self.minuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width. height.equalTo(@25);
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(17.5);
            make.centerX.equalTo(self.mas_centerX);
        }];
        [self.contentView addSubview:self.oneLabel];
        [self.oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.minuteLabel.mas_left).offset(0);
            make.height.equalTo(@25);
            make.width.equalTo(@10);
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(17.5);
        }];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.oneLabel.mas_left).offset(0);
            make.height.width.equalTo(@25);
            
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(17.5);
        }];
        [self.contentView addSubview:self.surplusLabel];
        [self.surplusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.timeLabel.mas_left).offset(0);
            make.height.equalTo(@25);
            make.width.equalTo(@50);
            
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(17.5);
        }];
        [self.contentView addSubview:self.leftLineView];
        [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.height.equalTo(@1);
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(30);
            make.right.equalTo(self.surplusLabel.mas_left).offset(0);
        }];
        [self.contentView addSubview:self.twoLabel];
        [self.twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.minuteLabel.mas_right).offset(0);
            make.height.equalTo(@25);
            make.width.equalTo(@10);
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(17.5);
        }];
        [self.contentView addSubview:self.secondLabel];
        [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.twoLabel.mas_right).offset(0);
            make.height.width.equalTo(@25);
            
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(17.5);
        }];
        [self.contentView addSubview:self.endLabel];
        [self.endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.secondLabel.mas_right).offset(0);
            make.height.equalTo(@25);
            make.width.equalTo(@50);
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(17.5);
        }];
        [self.contentView addSubview:self.rightLineView];
        [self.rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.height.equalTo(@1);
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(30);
            make.left.equalTo(self.endLabel.mas_right).offset(0);
        }];
    }
    return self;
}
-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.text=@"23";
        _timeLabel.textAlignment=NSTextAlignmentCenter;
        _timeLabel.layer.cornerRadius=2;
        _timeLabel.layer.masksToBounds=YES;
        _timeLabel.backgroundColor=RGB(64, 64, 64);
        _timeLabel.textColor=[UIColor whiteColor];
    }
    return _timeLabel;
}
-(UILabel *)minuteLabel{
    if (_minuteLabel==nil) {
        _minuteLabel=[[UILabel alloc]init];
        _minuteLabel.textColor=[UIColor whiteColor];
        _minuteLabel.text=@"54";
        _minuteLabel.textAlignment=NSTextAlignmentCenter;
        _minuteLabel.layer.cornerRadius=2;
        _minuteLabel.layer.masksToBounds=YES;
        
        _minuteLabel.backgroundColor=RGB(64, 64, 64);
        
    }
    return _minuteLabel;
}
-(UILabel *)secondLabel{
    if (_secondLabel==nil) {
        _secondLabel=[[UILabel alloc]init];
        _secondLabel.text=@"57";
        _secondLabel.textAlignment=NSTextAlignmentCenter;
        _secondLabel.layer.cornerRadius=2;
        _secondLabel.layer.masksToBounds=YES;
        
        _secondLabel.textColor=[UIColor whiteColor];
        _secondLabel.backgroundColor=RGB(64, 64, 64);
    }
    return _secondLabel;
}
-(UILabel *)oneLabel{
    if (_oneLabel==nil) {
        _oneLabel=[[UILabel alloc]init];
        _oneLabel.text=@":";
        _oneLabel.textAlignment=NSTextAlignmentCenter;
        _oneLabel.backgroundColor=RGB(242, 242, 244);
    }
    return _oneLabel;
}
-(UILabel *)twoLabel{
    if (_twoLabel==nil) {
        _twoLabel=[[UILabel alloc]init];
        _twoLabel.text=@":";
        _twoLabel.textAlignment=NSTextAlignmentCenter;
        _twoLabel.backgroundColor=RGB(242, 242, 244);
    }
    return _twoLabel;
}
-(UILabel *)surplusLabel{
    if (_surplusLabel==nil) {
        _surplusLabel=[[UILabel alloc]init];
        _surplusLabel.textAlignment=NSTextAlignmentCenter;
        _surplusLabel.backgroundColor=RGB(242, 242, 244);
        _surplusLabel.text=@"剩余";
        _surplusLabel.textColor=AllTextColor;
        _surplusLabel.font=[UIFont systemFontOfSize:14];
    }
    return _surplusLabel;
}
-(UILabel *)endLabel{
    if (_endLabel==nil) {
        _endLabel=[[UILabel alloc]init];
        _endLabel.text=@"结束";
        _endLabel.textColor=AllTextColor;
        _endLabel.font=[UIFont systemFontOfSize:14];
        _endLabel.textAlignment=NSTextAlignmentCenter;
        _endLabel.backgroundColor=RGB(242, 242, 244);
    }
    return _endLabel;
}
-(UIView *)leftLineView{
    if (_leftLineView==nil) {
        _leftLineView=[[UIView alloc]init];
        _leftLineView.backgroundColor=RGB(212, 212, 212);
    }
    return _leftLineView;
}
-(UIView *)rightLineView{
    if (_rightLineView==nil) {
        _rightLineView=[[UIView alloc]init];
        _rightLineView.backgroundColor=RGB(212, 212, 212);
    }
    return _rightLineView;
}
-(UILabel *)tipsLabel{
    if (_tipsLabel==nil) {
        _tipsLabel=[[UILabel alloc]init];
        _tipsLabel.textColor=AllTextColor;
        _tipsLabel.font=[UIFont systemFontOfSize:14];
        _tipsLabel.textAlignment=NSTextAlignmentCenter;
        _tipsLabel.text=@"还差1人,等你等到花儿都谢了";
    }
    return _tipsLabel;
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
