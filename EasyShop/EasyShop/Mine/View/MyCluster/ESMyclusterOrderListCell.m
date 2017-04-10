//
//  ESTogeListCell.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/19.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESMyclusterOrderListCell.h"
#import "GSTimeTool.h"
@interface ESMyclusterOrderListCell()
@property (nonatomic,strong) UIImageView*goodsImagView;
@property (nonatomic,strong) UIButton*leftButton;
@property (nonatomic,strong) UIButton*rightButton;
@property (nonatomic,strong) UILabel*detailLabel;
@property (nonatomic,strong) UILabel*priceLbel;
@property (nonatomic,strong) UILabel *muchLabel;
@property (nonatomic,strong) UIView*topLineView;
@property (nonatomic,strong) UIView*lineView;
@property (nonatomic,strong) UIView*bgView;
@property (nonatomic,strong) UILabel*tipsLable;
@property (nonatomic,strong) UILabel*timeLabel;
@property (nonatomic,strong) UILabel*goods_numLabel;
@property (nonatomic,strong) UILabel*num_pricLabel;
@property (nonatomic,strong) UILabel*countLabel;
@end
@implementation ESMyclusterOrderListCell
-(void)setRespone:(GetClusterListRespone *)respone{
    self.timeLabel.text = [GSTimeTool formatterNumber:respone.pay_time toType:GSTimeType_YYYYMMdd];
    [self.goodsImagView sd_setImageWithURL:[NSURL URLWithString:respone.goods_image] placeholderImage:[UIImage imageNamed:@"bg100"]];
    self.detailLabel.text=respone.goods_name;
    NSString*str=[NSString stringWithFormat:@"￥%@",respone.cluster_price];
    
//    NSMutableAttributedString*mabStr=[[NSMutableAttributedString alloc]initWithString:str];
//    
//    [mabStr addAttribute:NSForegroundColorAttributeName value:RGB(233, 40, 46) range:NSMakeRange(1, str.length-3)];
//    [mabStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(1, str.length-3)];
//    [mabStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(str.length-2, 2)];
    self.priceLbel.text=str;
    self.muchLabel.text=[NSString stringWithFormat:@"%@人团",respone.cluster_member];
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
    self.tipsLable.text=tipsStr;
    NSString*countStr=[NSString stringWithFormat:@"共%@件商品",respone.goods_num];
//    NSMutableAttributedString*muCounStr=[[NSMutableAttributedString alloc]initWithString:countStr];
//    [muCounStr addAttribute:NSForegroundColorAttributeName value:RGB(233, 40, 46) range:NSMakeRange(1, countStr.length-4)];
    self.goods_numLabel.text=countStr;
    
    NSString*numPric=[NSString stringWithFormat:@"合计:￥%.2f",respone.goods_num.intValue*respone.cluster_price.floatValue];
    NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc]initWithString:numPric];
    [muStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.5],NSForegroundColorAttributeName:RGB(233, 40, 46)} range:NSMakeRange(3, numPric.length-3)];
     [muStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(3, 1)];
    [muStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(numPric.length-2, 2)];
    self.num_pricLabel.attributedText=muStr;

    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(UILabel *)tipsLable{
    if (_tipsLable==nil) {
        _tipsLable=[[UILabel alloc]init];
        _tipsLable.font=[UIFont systemFontOfSize:13.5];
        _tipsLable.textColor=AllButtonBackColor;
        _tipsLable.textAlignment=NSTextAlignmentRight;
    }
    return _tipsLable;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.contentView. backgroundColor=RGB(247, 247, 247);
        [self.contentView addSubview:self.bgView];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(@0);
            make.bottom.equalTo(@(-10));
        }];
        [self.bgView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@12);
            make.top.equalTo(@13);
        }];
        [self.bgView addSubview:self.topLineView];
        [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(@0);
            make.top.equalTo(@40);
            make.height.equalTo(@0.35);
        }];
        [self.bgView addSubview:self.tipsLable];
        [self.tipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.timeLabel.mas_centerY);
            make.right.equalTo(@-10);
        }];
        [self.bgView addSubview:self.goodsImagView];
        [self.goodsImagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topLineView.mas_bottom).offset(10);
            make.left.equalTo(@10);
            make.width.height.equalTo(@60);
        }];
        
        [self.bgView addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsImagView.mas_right).offset(10);
            make.right.equalTo(@(-80));
            make.top.equalTo(self.topLineView.mas_bottom).offset(8);
        }];
        [self.bgView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@1);
            make.top.equalTo(self.goodsImagView.mas_bottom).offset(10);
            
        }];
        [self.bgView addSubview:self.num_pricLabel];
        [self.num_pricLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.bottom.equalTo(@-46);
        }];
        [self.bgView addSubview:self.goods_numLabel];
        [self.goods_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
              make.bottom.equalTo(@-46);
            make.right.equalTo(self.num_pricLabel.mas_left).offset(-10);
            
        }];
        [self.bgView addSubview:self.priceLbel];
        [self.priceLbel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.top.equalTo(self.topLineView.mas_bottom).offset(8);
            
        }];
        [self.bgView addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.priceLbel.mas_bottom).offset(9);
            make.right.equalTo(@-10);
        }];
        [self.bgView addSubview:self.muchLabel];
        [self.muchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.top.equalTo(self.countLabel.mas_bottom).offset(10);
        }];
        [self.bgView addSubview:self.rightButton];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.right.equalTo(@(-10));
            make.width.equalTo(@100);
            make.bottom.equalTo(@-8);
        }];
        [self.bgView addSubview:self.leftButton];
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.width.equalTo(@100);
            make.bottom.equalTo(@-8);
            make.right.equalTo(self.rightButton.mas_left).offset(-10);
        }];
        
        
    }
    return self;
}
-(UILabel *)countLabel{
    if (_countLabel==nil) {
        _countLabel=[[UILabel alloc]init];
        _countLabel.textColor=RGB(90, 90, 90);
        _countLabel.text=@"x1";
        _countLabel.font=[UIFont systemFontOfSize:12];
        
    }
    return _countLabel;
    
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=[UIColor whiteColor];
    }
    return _bgView;
}
-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.font=[UIFont systemFontOfSize:13.5];
        _timeLabel.textColor=RGB(172, 172, 172);
    }
    return _timeLabel;
}
-(UILabel *)goods_numLabel{
    if (_goods_numLabel==nil) {
        _goods_numLabel=[[UILabel alloc]init];
        _goods_numLabel.font=[UIFont systemFontOfSize:13];
        _goods_numLabel.textColor=RGB(172, 172, 172);
    }
    return _goods_numLabel;
}
-(UILabel *)num_pricLabel{
    if (_num_pricLabel==nil) {
        _num_pricLabel=[[UILabel alloc]init];
        _num_pricLabel.font=[UIFont systemFontOfSize:13];
        _num_pricLabel.textColor=RGB(172, 172, 172);
    }
    return _num_pricLabel;
}
-(UIImageView *)goodsImagView{
    if (_goodsImagView==nil) {
        _goodsImagView=[[UIImageView alloc]init];
        _goodsImagView.image=[UIImage imageNamed:@"110.jpg"];
        
    }
    return _goodsImagView;
}
-(UILabel *)detailLabel{
    if (_detailLabel==nil) {
        _detailLabel=[[UILabel alloc]init];
        _detailLabel.text=@"";
        _detailLabel.font=[UIFont systemFontOfSize:14];
        _detailLabel.textColor=AllTextColor;
        _detailLabel.numberOfLines=2;
    }
    return _detailLabel;
}
-(UILabel *)priceLbel{
    if (_priceLbel==nil) {
        _priceLbel=[[UILabel alloc]init];
        _priceLbel.text=@"";
        _priceLbel.textColor=AllTextColor;
        _priceLbel.font=[UIFont systemFontOfSize:14.5];
    }
    return _priceLbel;
}
-(UILabel *)muchLabel{
    if (_muchLabel==nil) {
        _muchLabel=[[UILabel alloc]init];
        _muchLabel.font=[UIFont systemFontOfSize:14];
        _muchLabel.text=@"";
        _muchLabel.textColor=RGB(80, 80, 80);
    }
    return _muchLabel;
}
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=KCommontLineViewBagroudColor;
    }
    return _lineView;
}
-(UIView *)topLineView{
    if (_topLineView==nil) {
        _topLineView=[[UIView alloc]init];
        _topLineView.backgroundColor=KCommontLineViewBagroudColor;
    }
    return _topLineView;
}
-(UIButton *)leftButton{
    if (_leftButton==nil) {
        _leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setTitle:@"查看拼团详情" forState:UIControlStateNormal];
        
        _leftButton.layer.cornerRadius=2;
        _leftButton.layer.masksToBounds=YES;
        _leftButton.titleLabel.font=[UIFont systemFontOfSize:14];
        _leftButton.layer.borderColor=RGB(150, 150, 150).CGColor;
        _leftButton.layer.borderWidth=1;
        _leftButton.backgroundColor=[UIColor whiteColor];
        [_leftButton setTitleColor:RGB(76, 78, 79) forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _leftButton;
}
-(UIButton *)rightButton{
    if (_rightButton==nil) {
        _rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitle:@"查看订单详情" forState:UIControlStateNormal];
        
        _rightButton.layer.cornerRadius=2;
        _rightButton.layer.masksToBounds=YES;
        _rightButton.titleLabel.font=[UIFont systemFontOfSize:14];
        _rightButton.layer.borderWidth=1;
        _rightButton.layer.borderColor=RGB(150, 150, 150).CGColor;
        _rightButton .backgroundColor=[UIColor whiteColor];
        [_rightButton setTitleColor:RGB(76, 78, 79) forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _rightButton;
}
-(void)leftButtonAction{
    if (self.leftButtonBlock) {
        self.leftButtonBlock(@"2");
    }
    
}
-(void)rightButtonAction{
    if (self.rightButtonBlock) {
        self.rightButtonBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
