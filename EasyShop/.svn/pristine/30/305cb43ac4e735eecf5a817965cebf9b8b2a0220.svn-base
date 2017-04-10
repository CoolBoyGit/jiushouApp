


//
//  ESCouponViewCell.m
//  iCarePregnant
//
//  Created by wcz on 16/6/22.
//  Copyright © 2016年 oenius. All rights reserved.
//

#import "ESCouponViewCell.h"
#import "GSTimeTool.h"

@interface ESCouponViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;//优惠卷的名字
@property (nonatomic, strong) UILabel *priceLabel;//优惠卷的价格
@property (nonatomic, strong) UILabel *conditionLabel;//使用场景
@property (nonatomic, strong) UILabel *titleLabel;//优惠卷的卷号码
@property (nonatomic, strong) UILabel *timeLabel;//到期具体时间
@property (nonatomic,strong) UILabel *dateLabel;//到期事件 文字
@end

@implementation ESCouponViewCell
-(void)setGetInfo:(GetCouponInfo *)getInfo{
    _getInfo=getInfo;
    self.nameLabel.text = getInfo.name;//@"SWISSE 专享40元";
   
    self.conditionLabel.text =getInfo. use_comments;//@"满198使用";
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.left.equalTo(@30);
        make.centerY.equalTo(self.mas_centerY);
    }];
    self.timeLabel.text=[NSString stringWithFormat:@"%@内使用有效",getInfo.expdate];
    //self.timeLabel.text = [GSTimeTool formatterNumber:[NSNumber numberWithInt:[getInfo.expdate intValue]]toType:GSTimeType_YYYYMMdd];//@"2017.3.3已过期";
    self.priceLabel.width=80;
    if ([getInfo.value containsString:@"-"]) {
         self.priceLabel.text = @"随机金额";//@"40";
        self.titleLabel.text =[NSString stringWithFormat:@"优惠金额从¥%@RMB中生成随机金额",getInfo.value];
    }else{
         self.priceLabel.text = getInfo.value;//@"40";
    }
   ;//@"haoma ";
}
- (void)setCouponInfo:(CouponInfo *)couponInfo
{
    _couponInfo = couponInfo;
    
    self.nameLabel.text = _couponInfo.c_name;//@"SWISSE 专享40元";
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@50);
        make.left.equalTo(@30);
        make.centerY.equalTo(self.mas_centerY);
    }];
    //self.priceLabel.width=50;
    self.priceLabel.text = _couponInfo.c_value;//@"40";
    self.conditionLabel.text = _couponInfo.use_comments;//@"满198使用";
    self.timeLabel.text = [GSTimeTool formatterNumber:[NSNumber numberWithInt:[_couponInfo.expdate intValue]]toType:GSTimeType_YYYYMMdd];//@"2017.3.3已过期";
    self.titleLabel.text =[NSString stringWithFormat:@"卷码:%@", _couponInfo.c_num];//@"haoma ";
}
-(UILabel*)dateLabel{
    if (_dateLabel==nil) {
        _dateLabel=[[UILabel alloc]init];
         _dateLabel.text=@"过期时间";
         _dateLabel.font=[UIFont systemFontOfSize:12];
       
        _dateLabel.textAlignment=NSTextAlignmentLeft;
        
       
        
    }
    return _dateLabel;
}
- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines=0;
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textAlignment=NSTextAlignmentLeft;
        _timeLabel.textColor = [UIColor blackColor];
    }
    return _timeLabel;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont boldSystemFontOfSize:20];
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _priceLabel;
}

- (UILabel *)conditionLabel
{
    if (_conditionLabel == nil) {
        _conditionLabel = [[UILabel alloc] init];
        _conditionLabel.font = [UIFont systemFontOfSize:12];
        _conditionLabel.numberOfLines=0;
        _conditionLabel.textColor = [UIColor blackColor];
        _conditionLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _conditionLabel;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines=0;
        _titleLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.contentView.backgroundColor = RGB(240 , 240, 240);
        self.contentView.layer.cornerRadius=6;
        self.contentView.layer.masksToBounds=YES;
//        self.contentView.alpha = 0.2;
        [self initalizedView];
    }
    return  self;
}

- (void)initalizedView
{

    
    
    UILabel *unitLabel = [[UILabel alloc] init];
    unitLabel.text = @"¥";
    unitLabel.font = [UIFont systemFontOfSize:20];
    unitLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:unitLabel];
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.equalTo(@20);
    }];
    
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.left.equalTo(unitLabel.mas_right).offset(0);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(10);
        make.top.equalTo(@10);
        
    }];
    //使用场景
    [self.contentView addSubview:self.conditionLabel];
    [self.conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(10);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
    }];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.conditionLabel.mas_bottom).offset(5);
        make.left.equalTo(self.priceLabel.mas_right).offset(10);
        //make.width.equalTo(@(ScreenWidth-20))
        make.right.equalTo(@(-10));
    }];
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.width.equalTo(@80);
        make.right.equalTo(@(0));
        
    }];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.width.equalTo(@80);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(0);
    }];
    
    

    
//    [self setModel:nil];
}

- (void)setModel:(id)model
{
    self.nameLabel.text = @"SWISSE 专享40元";
    self.priceLabel.text = @"40";
    self.conditionLabel.text = @"满198使用";
    self.timeLabel.text = @"2017.3.3已过期";
    self.titleLabel.text = @"指定商品使用";
}



@end
