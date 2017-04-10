//
//  ESRefundListCell.m
//  EasyShop
//
//  Created by jiushou on 16/7/5.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESRefundListCell.h"
@interface ESRefundListCell()

@property (nonatomic,strong)UIImageView*GoodsImageView;
@property (nonatomic,strong)UILabel*titleLabel;
@property (nonatomic,strong)UILabel*priceLabel;
@property (nonatomic,strong)UILabel*countLbel;
@property (nonatomic,strong)UIView*bgView;
@end

@implementation ESRefundListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
