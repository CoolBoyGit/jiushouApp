//
//  ESTogetherPayShopNameCell.m
//  EasyShop
//
//  Created by jiushou on 16/10/10.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClsterPayShopNameCell.h"
@interface ESClsterPayShopNameCell()
@property (nonatomic,strong) UIImageView*shopImageView;
@property (nonatomic,strong) UILabel*shopNameLabel;
@end
@implementation ESClsterPayShopNameCell
-(void)setSimpleGoodsRespone:(GetSimpGoodsRespone *)simpleGoodsRespone{
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:simpleGoodsRespone.image] placeholderImage:[UIImage imageNamed:@"110.jpg"]];
    self.shopNameLabel.text=simpleGoodsRespone.shop_name;
}
-(UILabel *)shopNameLabel{
    if (_shopNameLabel==nil) {
        _shopNameLabel=[[UILabel alloc]init];
        _shopNameLabel.text=@"就手国际旗航店";
        _shopNameLabel.textColor=AllTextColor;
        _shopNameLabel.font=[UIFont systemFontOfSize:14];
        
    }
    return _shopNameLabel;
}
-(UIImageView *)shopImageView{
    if (_shopImageView==nil) {
        _shopImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"110.jpg"]];
        
    }
    return _shopImageView;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.shopImageView];
        self.selectionStyle=UITableViewCellSelectionStyleNone;

        [self.shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.left.equalTo(@10);
            make.bottom.equalTo(@(-10));
            make.width.equalTo(@20);
        }];
        [self.contentView addSubview: self.shopNameLabel];
        [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@40);
            make.right.equalTo(@0);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
    }
    return self;
}
@end
