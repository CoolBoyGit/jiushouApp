//
//  ESSingleTableViewCell.m
//  EasyShop
//
//  Created by wcz on 16/3/25.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESSingleTableViewCell.h"

@interface ESSingleTableViewCell ()

@property (nonatomic, strong) UIImageView *photoImageView;//图片
@property (nonatomic, strong) UILabel *productTitleLabel;//标题
@property (nonatomic, strong) UILabel *productAreaLabel;//副标题
@property (nonatomic, strong) UILabel *newPriceLabel;//原价
@property (nonatomic, strong) UILabel *originalPriceLabel;//旧价
@property (nonatomic, strong) UIView *lineView;//底线
@property (nonatomic,strong)  UILabel *contentLabel;
@property (nonatomic,strong) UIImageView*soldoutImage;
@end

@implementation ESSingleTableViewCell
-(void)setIsHidden:(BOOL)isHidden{
    self.soldoutImage.hidden=isHidden;
}
-(UIImageView *)soldoutImage{
    if (_soldoutImage==nil) {
        _soldoutImage=[[UIImageView alloc]init];
        _soldoutImage.image=[UIImage imageNamed:@"soldout"];
        _soldoutImage.alpha=0.8;
        _soldoutImage.hidden=NO;
    }
    return _soldoutImage;
}
- (void)setGoodsInfo:(GoodsInfo *)goodsInfo
{
     _goodsInfo = goodsInfo;
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:_goodsInfo.image]
                           placeholderImage:[UIImage imageNamed:@"bg"]];
    
    self.productTitleLabel.text = _goodsInfo.name;
    NSString*str=[NSString stringWithFormat:@"¥%.2f",_goodsInfo.price.floatValue];
    NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc]initWithString:str];
    [muStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:18]} range:NSMakeRange(1, str.length-1)];
    self.newPriceLabel.attributedText= muStr;
    self.contentLabel.text=[NSString stringWithFormat:@"%@",self.goodsInfo.tips];


}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpViews];
    }
    return self;
}

-(UIImageView *)photoImageView
{
    if (!_photoImageView)
    {
        _photoImageView = [[UIImageView alloc] init];
        _photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _photoImageView;
}
-(UILabel *)productTitleLabel
{
    if (!_productTitleLabel) {
        _productTitleLabel = [[UILabel alloc] init];
        _productTitleLabel.numberOfLines = 2;
        _productTitleLabel.font = [UIFont systemFontOfSize:13];
        _productTitleLabel.textAlignment = NSTextAlignmentLeft;
        _productTitleLabel.textColor=AllTextColor;
    }
    return _productTitleLabel;
}
-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 4;
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel;
}
-(UILabel *)newPriceLabel
{
    if (!_newPriceLabel) {
        _newPriceLabel = [[UILabel alloc] init];
        _newPriceLabel.font = [UIFont systemFontOfSize:14];
        _newPriceLabel.textColor = RGB(233, 40, 46);
        _newPriceLabel.textAlignment = NSTextAlignmentRight;
            }
    return _newPriceLabel;
}
-(UILabel *)originalPriceLabel
{
    if (!_originalPriceLabel) {
        _originalPriceLabel = [[UILabel alloc] init];
        _originalPriceLabel.font = [UIFont systemFontOfSize:11];
        _originalPriceLabel.textColor = [UIColor redColor];
        _originalPriceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _originalPriceLabel;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(240, 240, 240);
           }
    return _lineView;
}

-(void)setUpViews
{
    
    [self.contentView addSubview:self.photoImageView];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.width.equalTo(@150);
        make.left.equalTo(@10);
    }];
    [self.photoImageView addSubview:self.soldoutImage];
    [self.soldoutImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.bottom.equalTo(@-10);
        make.height.width.equalTo(@55);
    }];

    [self.contentView addSubview:self.productTitleLabel];
    [self.productTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.photoImageView.mas_right).offset(10);
        make.right.equalTo(@(-10));
        make.top.equalTo(@20);
    }];
    [self.contentView addSubview:self.newPriceLabel];
    [self.newPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-20));
        make.left.equalTo(self.photoImageView.mas_right).offset(10);
        
    }];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(@0);
    }];
   
   
}



@end
