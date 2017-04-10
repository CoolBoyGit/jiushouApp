

//
//  ESToCountCell.m
//  EasyShop
//
//  Created by jiushou on 16/10/10.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClsterPayCountCell.h"
@interface ESClsterPayCountCell ()
@property (nonatomic,strong) UILabel *countLabel;
@property (nonatomic,copy) NSString*taxStr;
@end

@implementation ESClsterPayCountCell
-(void)setCount:(float)count{
    _count=count;
}
-(void)setRespone:(GetSimpGoodsRespone *)respone{
    
    if ([respone.is_free_shipping isEqualToString:@"Y"]) {
        self.taxStr=[NSString stringWithFormat:@"店铺合计: ￥%.2f (全场包邮)",self.count];
        
    }else{
        self.taxStr=[NSString stringWithFormat:@"店铺合计: ￥%.2f (邮费:￥%@)",self.count,respone.freight];
        
    }
    NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc]initWithString:self.taxStr];
    NSString*str=[NSString stringWithFormat:@"%.2f",self.count];
    NSDictionary*dic=@{NSFontAttributeName :[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:RGB(233, 40, 46)};
    [muStr addAttributes:dic range:NSMakeRange(6, str.length+1)];
     NSDictionary*dic1=@{NSFontAttributeName :[UIFont systemFontOfSize:14.5],NSForegroundColorAttributeName:RGB(233, 40, 46)};
    [muStr addAttributes:dic1 range:NSMakeRange(6, 1)];
    NSDictionary*dic3=@{NSFontAttributeName :[UIFont systemFontOfSize:14.5],NSForegroundColorAttributeName:RGB(233, 40, 46)};
    [muStr addAttributes:dic3 range:NSMakeRange(7+str.length-2, 2)];
    self.countLabel.attributedText=muStr;
    
}
-(UILabel *)countLabel{
    if (_countLabel==nil) {
        _countLabel=[[UILabel alloc]init];
        _countLabel.font=[UIFont systemFontOfSize:14];
        _countLabel.textAlignment=NSTextAlignmentRight;
        _countLabel.textColor=AllTextColor;
    }
    return _countLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.top.left.bottom.equalTo(@0);
            
        }];
    }
    return self;
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
