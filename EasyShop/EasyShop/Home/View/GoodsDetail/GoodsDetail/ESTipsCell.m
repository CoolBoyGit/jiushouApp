//
//  ESTipsCell.m
//  EasyShop
//
//  Created by jiushou on 16/10/9.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESTipsCell.h"
@interface ESTipsCell()
@property (nonatomic,strong) UILabel*tipsLabel;
@property (nonatomic,strong) UIImageView*tipsImageView;
@end
@implementation ESTipsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setGoodsDetail:(GoodsDetailInfo *)goodsDetail{
    [self.contentView addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.height.equalTo(@20);
        make.left.equalTo(@10);
    }
     ];

    self.tipsLabel.text=[NSString stringWithFormat:@"支付开团并且邀请%d人开团,人数不足自动退款",[goodsDetail.cluster_member intValue]-1];
    
}
-(void)setIsOneRow:(BOOL)isOneRow{
    if (isOneRow) {
        [self.contentView addSubview:self.tipsImageView];
        [self.tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }else{
        
    }
}
-(void)setTipStr:(NSString *)tipStr{
    [self.contentView addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.height.equalTo(@20);
        make.left.equalTo(@10);
    }
     ];
    self.tipsLabel.text=tipStr;
}
-(void)setBgCorlor:(UIColor *)bgCorlor{
    self.contentView.backgroundColor=bgCorlor;
}
-(UIImageView *)tipsImageView{
    if (_tipsImageView==nil) {
        _tipsImageView=[[UIImageView alloc]init];
        _tipsImageView.image=[UIImage imageNamed:@"homeDetailClusterTips"];
    }
    return _tipsImageView;
}
-(UILabel *)tipsLabel{
    if (_tipsLabel==nil) {
        _tipsLabel=[[UILabel alloc]init];
        _tipsLabel.font=[UIFont systemFontOfSize:13];
        _tipsLabel.backgroundColor=[UIColor clearColor];
        _tipsLabel.textColor=ADeanHEXCOLOR(0x999999);
        
    }
    return _tipsLabel;
}
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
