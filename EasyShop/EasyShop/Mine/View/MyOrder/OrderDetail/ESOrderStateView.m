//
//  ESOrderStateView.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/11.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESOrderStateView.h"

@interface ESOrderStateView()

@property(nonatomic, strong) UILabel *stateLab;
@property(nonatomic, strong) UIImageView *stateImg;
///改写界面
@property (nonatomic,strong)UIImageView*tipsImageView;
@property (nonatomic,strong)UIImageView*addressImageView;
@property (nonatomic,strong)UILabel*nameLabel;
@property (nonatomic,strong)UILabel*phoneLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UIView*bottomLineView;
@property (nonatomic,strong)UIView*bgView;
@property (nonatomic,strong) UILabel*tipsLabel;
@property (nonatomic,strong) UILabel*persionLabel;
@property (nonatomic,strong) UIView*whitheView;


@end

@implementation ESOrderStateView

- (void)setOrderInfo:(OrderDetailInfo *)orderInfo
{
    _orderInfo = orderInfo;
    self.nameLabel.text=[NSString stringWithFormat:@"收件人: %@",orderInfo.receiver_name];
    self.phoneLabel.text=[NSString stringWithFormat:@"%@",[orderInfo.receiver_mobile stringByReplacingCharactersInRange:NSMakeRange(4, 3) withString:@"***"]];
    NSString*str=[NSString stringWithFormat:@"%@%@",self.orderInfo.receiver_area,orderInfo.receiver_address];
    self.addressLabel.attributedText=[str ParaStyleheightOfLineSpacing:5 andFont:[UIFont systemFontOfSize:14]];
    switch (_orderInfo.orderStatus) {
        case OrderStatus_WaitPay://等待支付
        {
            self.stateImg.image = [UIImage imageNamed:@"user_dispatchgoods"];
            self.tipsLabel.text = @"等待买家付款";
        }
            break;
        case OrderStatus_WaitSend://等待发货 可以是申请退货
        {    NSString*title=nil;
            switch (_orderInfo.refund_status.intValue) {
                case 0:
                    title=@"待发货";
                    break;
                case 2:{
                    NSString*titles=[NSString stringWithFormat:@"就手正在审核是否退款\n请注意查看退款状态"];
                    title=titles;
                }
                    break;
                case 3:
                    title=@"通过审核";
                    break;
                case 4:
                    title=@"拒绝退款";
                    break;
                case 5:
                    title=@"退款完成";
                    break;
                case 6:
                    title=@"退款中";
                    break;
                default:
                    break;
            }

        

            self.stateImg.image = [UIImage imageNamed:@"user_dispatchgoods"];
            
            self.tipsLabel.text=title;
        }
            break;
        case OrderStatus_WaitReply://等待评价
        {
            self.stateImg.image = [UIImage imageNamed:@"user_dispatchgoods"];
            
            self.tipsLabel.text=@"待评价";
        }
            break;
        case OrderStatus_WaitSure://待收货
        {
            self.stateImg.image = [UIImage imageNamed:@"user_dispatchgoods"];
            
            self.tipsLabel.text=@"卖家已发货";
        }
            break;
            case OrderStatus_Cancel:
        {
            self.tipsLabel.text=@"订单已取消";
        }
        default:
            break;
            
    }
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.tipsImageView];
        [self.tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(ScreenWidth *(205/617.0)));
            make.left.right.equalTo(@0);
            make.top.equalTo(@0);
            
        }];
        [self addSubview:self.whitheView];
        [self.whitheView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipsImageView.mas_bottom).offset(0);
            make.left.right.equalTo(@0);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        [self.tipsImageView addSubview:self.tipsLabel];
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.tipsImageView.mas_centerY).offset(0);
            make.left.equalTo(@30);
            make.right.equalTo(@(-80));
        }];
        [self.whitheView addSubview: self.addressImageView];
        [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.width.height.equalTo(@25);
            make.top.equalTo(self.tipsImageView.mas_bottom).offset(25);
            
        }];
        [self.whitheView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.left.equalTo(@43);
            make.width.equalTo(@150);
            make.top.equalTo(self.tipsImageView.mas_bottom).offset(15);
        }];
        [self.whitheView addSubview: self.phoneLabel];
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).offset(30);
            make.centerY.equalTo(self.nameLabel.mas_centerY).offset(0);
            make.right.equalTo(@0);
        }];
        [self.whitheView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_left).offset(0);
            make.right.equalTo(@(-40));
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        }];
        [self.whitheView addSubview:self.persionLabel];
        [self.persionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.addressLabel.mas_bottom).offset(10);
            make.left.equalTo(self.nameLabel.mas_left).offset(0);
            
        }];
        [self.whitheView addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.left.right.equalTo(@0);
            make.top.equalTo(self.persionLabel.mas_bottom).offset(10);
        }];
        [self addSubview:self.bottomLineView];
        [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.left.right.equalTo(@0);
            make.bottom.equalTo(self.bgView.mas_top).offset(0);
            
            
        }];

        
    }
    return self;
}
-(UIView *)whitheView{
    if (_whitheView==nil) {
        _whitheView=[[UIView alloc]init];
        _whitheView.backgroundColor=[UIColor whiteColor];
        
    }
    return _whitheView;
}
-(UILabel *)persionLabel{
    if (_persionLabel==nil) {
        _persionLabel=[[UILabel alloc]init];
        _persionLabel.textColor=AllTextColor;
        
        _persionLabel.font=[UIFont systemFontOfSize:14];
    }
    return _persionLabel;
}
-(UILabel *)tipsLabel{
    if (_tipsLabel==nil) {
        _tipsLabel=[[UILabel alloc]init];
        _tipsLabel.textColor=[UIColor whiteColor];
        _tipsLabel.numberOfLines=0;
        _tipsLabel.font=[UIFont systemFontOfSize:15];
    }
    return _tipsLabel;
}
-(UIImageView *)tipsImageView{
    if (_tipsImageView==nil) {
        _tipsImageView=[[UIImageView alloc]init];
        _tipsImageView.image=[UIImage imageNamed:@"clusterDetailheadView"];
    }
    return _tipsImageView;
}
-(UIImageView *)addressImageView{
    if (_addressImageView==nil) {
        _addressImageView=[[UIImageView alloc]init];
        _addressImageView.image=[UIImage imageNamed:@"share_location"];
    }
    return _addressImageView;
}
-(UILabel *)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.textColor=RGB(100, 100, 100);
        _nameLabel.font=[UIFont systemFontOfSize:14];
        _nameLabel.text=@"";
        
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel{
    if (_phoneLabel==nil) {
        _phoneLabel=[[UILabel alloc]init];
        _phoneLabel.text=@"15088228288";
        _phoneLabel.textColor=RGB(100, 100, 100);
        _phoneLabel.font=[UIFont systemFontOfSize:14];
        _phoneLabel.textAlignment=NSTextAlignmentLeft;
        
    }
    return _phoneLabel;
}
-(UILabel *)addressLabel{
    if (_addressLabel==nil) {
        _addressLabel=[[UILabel alloc]init];
        _addressLabel.text=@"";
        _addressLabel.textColor=RGB(100, 100, 100);
        
        _addressLabel.numberOfLines=0;
    }
    return _addressLabel;
}
-(UIView *)bottomLineView{
    if (_bottomLineView==nil) {
        _bottomLineView=[[UIView alloc]init];
        _bottomLineView.backgroundColor=RGB(247, 247, 247);
    }
    return _bottomLineView;
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=RGB(247, 247, 247);
    }
    return _bgView;
}

-(void)setUpViews
{
    [self addSubview:self.stateImg];
    [self.stateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@40);
        make.left.equalTo(@20);
        make.centerY.equalTo(@0);
    }];
    
    [self addSubview:self.stateLab];
    [self.stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.height.equalTo(@30);
        make.left.equalTo(self.stateImg.mas_right).with.offset(10);
        make.centerY.equalTo(@0);
    }];
}

-(UIImageView *)stateImg
{
    if (!_stateImg) {
        _stateImg = [[UIImageView alloc] init];
//        _stateImg.image = [UIImage imageNamed:@"user_dispatchgoods"];
    }
    return _stateImg;
}
-(UILabel *)stateLab
{
    if (!_stateLab) {
        _stateLab = [[UILabel alloc] init];
        _stateLab.textColor = [UIColor grayColor];
        _stateLab.font = [UIFont systemFontOfSize:15];
        _stateLab.text = @"";
    }
    return _stateLab;
}

@end
