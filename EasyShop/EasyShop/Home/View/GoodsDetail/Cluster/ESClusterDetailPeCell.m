//
//  ESPeopleListCell.m
//  EasyShop
//
//  Created by jiushou on 16/10/13.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterDetailPeCell.h"
#import "GSTimeTool.h"
@interface ESClusterDetailPeCell()
@property (nonatomic,strong)UIImageView*bagImageView;
@property (nonatomic,strong)UIImageView*userImageView;
@property (nonatomic,strong)UILabel*userNameLabel;
@property (nonatomic,strong)UILabel*timeLabel;


@end
@implementation ESClusterDetailPeCell
-(void)setMemberDetailInfo:(ClusterDetailMemberRespone *)memberDetailInfo{
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:memberDetailInfo.logo] placeholderImage:[UIImage imageNamed:@"110.jpg"]];
    self.userNameLabel.text=memberDetailInfo.name;
    self.timeLabel.text=[NSString stringWithFormat:@"%@",[GSTimeTool formatterNumber:memberDetailInfo.create_time toType:GSTimeType_YYYYMMddHHmm]];
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.bagImageView];
        [self.bagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
            make.top.equalTo(@0);
        }];
        
        [self.bagImageView addSubview:self.userImageView];
        self.contentView.backgroundColor=RGB(248, 248, 248);
        [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.height.width.equalTo(@30);
            make.left.equalTo(@15);
        }];
        [self.bagImageView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-20));
            make.centerY.equalTo(self.userImageView.mas_centerY).offset(0);
            make.width.equalTo(@200);
            
        }];
        [self.bagImageView addSubview:self.userNameLabel];
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userImageView.mas_right).offset(10);
            make.centerY.equalTo(self.userImageView.mas_centerY).offset(0);
            make.right.equalTo(self.timeLabel.mas_left).offset(0);
        }];
//
        
    }
    return self;
}
-(UIImageView *)bagImageView{
    if (_bagImageView==nil) {
        _bagImageView=[[UIImageView alloc]init];
        _bagImageView.image=[UIImage imageNamed:@"140"];
       // _bagImageView.backgroundColor=[UIColor yellowColor];
       
    }
    return _bagImageView;
}
-(UILabel *)userNameLabel{
    if (_userNameLabel==nil) {
        _userNameLabel=[[UILabel alloc]init];
        _userNameLabel.textColor=[UIColor whiteColor];
        _userNameLabel.text=@"团长 志哥";
    }
    return _userNameLabel;
}
-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.textColor=[UIColor whiteColor];
        _timeLabel.text=@"2016-10-13 11:31:99 开团";
    }
    return _timeLabel;
}
-(UIImageView *)userImageView{
    if (_userImageView==nil) {
        
        _userImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"110.jpg"]];
        _userImageView.layer.cornerRadius=15;
        _userImageView.layer.masksToBounds=YES;
        
    }
    return _userImageView;
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
