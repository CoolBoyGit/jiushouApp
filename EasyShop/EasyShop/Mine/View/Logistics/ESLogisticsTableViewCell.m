//
//  ESLogisticsTableViewCell.m
//  EasyShop
//
//  Created by jiushou on 16/7/1.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESLogisticsTableViewCell.h"
@interface ESLogisticsTableViewCell()
@property (nonatomic,strong) UILabel*acceptTimeLabel;
@property (nonatomic,strong) UILabel*acceptStationLabel;
/*长线*/
@property (nonatomic,strong) UIView*longLineView;
/*cell头部的横线*/
@property (nonatomic,strong) UIView*topLineView;
/*cell的底部的线*/
@property (nonatomic,strong) UIView*bottomLineView;
/*红色的园*/
@property (nonatomic,strong) UIView*redView;
/*灰色的圆*/
@property (nonatomic,strong) UIView*gralineView;
/*短线*/
@property (nonatomic,strong) UIView*shortLineView;
@end
@implementation ESLogisticsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setInfo:(TraceInfo *)info{
    CGRect rect=[info.AcceptStation boundingRectWithSize:CGSizeMake(ScreenWidth-60, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    CGFloat h=rect.size.height+60;
    
        self.acceptStationLabel.text=info.AcceptStation;
        self.acceptTimeLabel.text=info.AcceptTime;

    
    
    if (self.isFirstcell==YES) {
        self.topLineView.frame=CGRectMake(0, 0, ScreenWidth, 0.5);
        self.redView.hidden=NO;
        self.gralineView.hidden=YES;
        self.shortLineView.frame=CGRectMake(24.75, 0, 0.5, 17);
        self.longLineView.frame=CGRectMake(24.75, 37, 0.5, h-30);
        self.acceptStationLabel.textColor=RGB(233, 40, 46);
        self.acceptTimeLabel.textColor=RGB(233, 40, 46);
        self.shortLineView.hidden=YES;
    }else{
        self.topLineView.frame=CGRectMake(40, 0, ScreenWidth-40, 0.5);
        self.shortLineView.frame=CGRectMake(24.75, 0, 0.5, 17);
        self.longLineView.frame=CGRectMake(24.75, 27, 0.5, h-27);
        self.acceptStationLabel.textColor=[UIColor grayColor];
        self.acceptTimeLabel.textColor=[UIColor grayColor];
        self.gralineView.hidden=NO;
        self.redView.hidden=YES;
        self.shortLineView.hidden=NO;
    }
    if (self.isLastcell==YES) {
        
        self.bottomLineView.hidden=NO;
    }else{
        self.bottomLineView.hidden=YES;
    }
   }

-(UIView *)bottomLineView{
    if (_bottomLineView==nil) {
        _bottomLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth   , 0.5)];
        _bottomLineView.hidden=YES;
        _bottomLineView.backgroundColor=RGB(228, 228, 228);
    }
    return _bottomLineView;
}
-(UIView*)shortLineView{
    if (_shortLineView==nil) {
        _shortLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 5, 0.5, 10)];
        _shortLineView.backgroundColor=RGB(228, 228, 228);
    }
    return _shortLineView;
}
-(UIView *)longLineView{
    if (_longLineView==nil) {
        _longLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 15, 0.5, 30)];
        _longLineView.backgroundColor=RGB(228, 228, 228);
        
        
    }
    return _longLineView;
}
-(UIView *)topLineView{
    if (!_topLineView) {
        _topLineView=[[UIView alloc]initWithFrame:CGRectMake(40, 10, ScreenWidth, 0.5)];
        _topLineView.backgroundColor=RGB(228, 228, 228);
        
    }
    return _topLineView;
}
-(UIView *)redView{
    if (_redView==nil) {
        _redView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        _redView.backgroundColor=RGB(233, 40, 46);
        _redView.layer.cornerRadius=10;
        _redView.layer.masksToBounds=YES;
        
    }
    return _redView;
    
}
-(UIView *)gralineView{
    if (_gralineView==nil) {
        _gralineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        _gralineView.backgroundColor=RGB(228, 228, 228);
        _gralineView.layer.cornerRadius=5;
        _gralineView.layer.masksToBounds=YES;
    }
    return _gralineView;
}
-(UILabel *)acceptTimeLabel{
    if (_acceptTimeLabel==nil) {
        _acceptTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        _acceptTimeLabel.text=@"";
        _acceptTimeLabel.textAlignment=NSTextAlignmentLeft;
        _acceptTimeLabel.font=[UIFont systemFontOfSize:15];
    }
    return _acceptTimeLabel;
}
-(UILabel *)acceptStationLabel{
    if (_acceptStationLabel==nil) {
        _acceptStationLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        _acceptTimeLabel.text=@"";
        _acceptStationLabel.textAlignment=NSTextAlignmentLeft;
        _acceptStationLabel.numberOfLines=0;
        _acceptStationLabel.font=[UIFont systemFontOfSize:15];
        
    }
    return _acceptStationLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.topLineView];
//        [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@0);
//            make.left.equalTo(@40);
//            make.right.equalTo(@0);
//            make.height.equalTo(@0.5);
//        }];
        [self.contentView addSubview:self.shortLineView];
//        [self.shortLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@0);
//            make.width.equalTo(@0.5);
//            make.height.equalTo(@7);
//            make.left.equalTo(@20);
//        }];
        
        [self.contentView addSubview:self.longLineView];
//        [self.longLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@17);
//            make.width.equalTo(@0.5);
//            make.height.equalTo(@20);
//            make.left.equalTo(@20);
//        }];
        [self.contentView addSubview:self.redView];
       [self.contentView addSubview:self.bottomLineView];
        [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
            make.left.right.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
        [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@17);
            make.left.equalTo(@15);
            make.width.height.equalTo(@20);
        }];
        [self.contentView addSubview:self.gralineView];
        [self.gralineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@17);
            make.height.equalTo(@10);
            make.width.equalTo(@10);
            make.left.equalTo(@20);
        }];
        [self.contentView addSubview:self.acceptStationLabel];
        [self.acceptStationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.left.equalTo(@40);
            make.right.equalTo(@(-20));
            
        }];
        [self.contentView addSubview:self.acceptTimeLabel];
        [self.acceptTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.acceptStationLabel.mas_bottom).offset(10);
            make.left.equalTo(@40);
            make.right.equalTo(@(-20));
        }];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
