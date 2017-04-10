//
//  ESOrderPriceCell.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/12.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESOrderPriceCell.h"
@interface ESOrderPriceCell()
@property (nonatomic, strong)UIView*lineView;

@end
@implementation ESOrderPriceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setupViews
{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.width.equalTo(@70);
        make.centerY.equalTo(@0);
    }];
    
    [self.contentView addSubview:self.priceNumLab];
    [self.priceNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab.mas_right).with.offset(10);

        make.centerY.equalTo(@0);
    }];
}

-(UILabel *)priceNumLab
{
    if (!_priceNumLab) {
        _priceNumLab = [[UILabel alloc] init];
        _priceNumLab.textColor = [UIColor grayColor];
        _priceNumLab.font = [UIFont systemFontOfSize:15];
        _priceNumLab.textAlignment = NSTextAlignmentRight;
    }
    return _priceNumLab;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = [UIColor grayColor];
        _titleLab.textAlignment=NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:15];
    }
    return _titleLab;
}

@end
