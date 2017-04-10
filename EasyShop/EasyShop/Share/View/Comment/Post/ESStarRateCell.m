//
//  ESStarRateCell.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/12.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESStarRateCell.h"
#import "TggStarEvaluationView.h"
@interface ESStarRateCell()<CanStarRatingViewDelegate>

@property (nonatomic, strong) UILabel  *titleLab1;
@property (nonatomic, strong) UILabel  *titleLab2;
@property (nonatomic, strong) UILabel  *titleLab3;
@property (nonatomic, strong) UILabel  *titleLab4;
//描述相符
@property (nonatomic ,strong) TggStarEvaluationView*evaluationView1;
//发货速度
@property (nonatomic,strong) TggStarEvaluationView*evaluationView2;
//服务态度
@property (nonatomic,strong) TggStarEvaluationView*evaluationView3;
@end

@implementation ESStarRateCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpViews];
    }
    return self;
}

-(void)setUpViews
{
    self.titleLab1.alpha = 1.0f;
    self.titleLab2.alpha = 1.0f;
    self.titleLab3.alpha = 1.0f;
    self.titleLab4.alpha = 1.0f;
    self.evaluationView1.alpha=1.0;
    self.evaluationView2.alpha=1.0;
    self.evaluationView3.alpha=1.0;

}

-(TggStarEvaluationView *)evaluationView1{
    if (!_evaluationView1) {
        _evaluationView1=[TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
            
            self.evaluationRequest.desccredit = [NSNumber numberWithInt:(int)count];
        }];
        [self.contentView addSubview:_evaluationView1];
        [_evaluationView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-20);
            make.centerY.equalTo(self.titleLab2.mas_centerY).with.offset(0);
            make.height.equalTo(@40);
            make.width.equalTo(@180);
        }];

        _evaluationView1.starCount=5;
        _evaluationView1.spacing=0.3;
    }
    return _evaluationView1;
}
-(TggStarEvaluationView *)evaluationView2{
    if (!_evaluationView2) {
        _evaluationView2=[TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
            self.evaluationRequest.deliverycredit = [NSNumber numberWithInt:(int)count];
        }];
        [self.contentView addSubview:_evaluationView2];
        [_evaluationView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-20);
            make.centerY.equalTo(self.titleLab3.mas_centerY).with.offset(0);
            make.height.equalTo(@40);
            make.width.equalTo(@180);
        }];
        
        _evaluationView2.starCount=5;
        _evaluationView2.spacing=0.3;
    }
    return _evaluationView1;
}
-(TggStarEvaluationView *)evaluationView3{
    if (!_evaluationView3) {
        _evaluationView3=[TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
            self.evaluationRequest.servicecredit  = [NSNumber numberWithInt:(int)count];
        }];
        [self.contentView addSubview:_evaluationView3];
        [_evaluationView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-20);
            make.centerY.equalTo(self.titleLab4.mas_centerY).with.offset(0);
            make.height.equalTo(@40);
            make.width.equalTo(@180);
        }];
        
        _evaluationView3.starCount=5;
        _evaluationView3.spacing=0.3;
    }
    return _evaluationView3;
}

- (UILabel *)titleLab1 {
    
    if (!_titleLab1) {
        _titleLab1 = [[UILabel alloc] init];
        _titleLab1.textAlignment = NSTextAlignmentLeft;
        _titleLab1.text = @"店铺评分";
        _titleLab1.font = ADeanFONT15;
        [self.contentView addSubview:_titleLab1];
        [_titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(20);
            make.top.equalTo(self.mas_top).with.offset(10);
            make.height.equalTo(@25);
            make.width.equalTo(@100);
        }];
    }
    return _titleLab1;
}
- (UILabel *)titleLab2 {
    
    if (!_titleLab2) {
        _titleLab2 = [[UILabel alloc] init];
        _titleLab2.textAlignment = NSTextAlignmentLeft;
        _titleLab2.text = @"描述相符";
        _titleLab2.font = ADeanFONT15;
        [self.contentView addSubview:_titleLab2];
        [_titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(20);
            make.top.equalTo(self.titleLab1.mas_bottom).with.offset(15);
            make.height.equalTo(@25);
            make.width.equalTo(@100);
        }];
    }
    return _titleLab2;
}
- (UILabel *)titleLab3 {
    
    if (!_titleLab3) {
        _titleLab3 = [[UILabel alloc] init];
        _titleLab3.textAlignment = NSTextAlignmentLeft;
        _titleLab3.text = @"发货速度";
        _titleLab3.font = ADeanFONT15;
        [self.contentView addSubview:_titleLab3];
        [_titleLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(20);
            make.top.equalTo(self.titleLab2.mas_bottom).with.offset(15);
            make.height.equalTo(@25);
            make.width.equalTo(@100);
        }];
    }
    return _titleLab3;
}
- (UILabel *)titleLab4 {
    
    if (!_titleLab4) {
        _titleLab4 = [[UILabel alloc] init];
        _titleLab4.textAlignment = NSTextAlignmentLeft;
        _titleLab4.text = @"服务态度";
        _titleLab4.font = ADeanFONT15;
        
        [self.contentView addSubview:_titleLab4];
        [_titleLab4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(20);
            make.top.equalTo(self.titleLab3.mas_bottom).with.offset(15);
            make.height.equalTo(@25);
            make.width.equalTo(@100);
        }];
    }
    return _titleLab4;
}
@end
