//
//  ESMyFootListCell.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESMyFootListCell.h"

@interface ESMyFootListCell()

@property (nonatomic, strong) UIImageView     *shopImg;//商品图像
@property (nonatomic, strong) UILabel         *shopNameLab;//商品名字
@property (nonatomic, strong) UILabel         *shopPriceLab;//商品价格
@property (nonatomic, strong) UIButton        *seeButton;//登陆按钮
@property (nonatomic, strong) UILabel         *shopPromptLab;//多件多折
@property (nonatomic, strong) UILabel         *shopPreferentialLab;//商品优惠信息
@property (nonatomic,strong) UIView*lineView;          //横线

//蒙层
@property (nonatomic,strong) UIView*clearView;

@end

@implementation ESMyFootListCell

-(UIView *)clearView{
    if (_clearView==nil) {
        _clearView=[[UIView alloc]init];
        _clearView.backgroundColor=[UIColor clearColor];
        _clearView.hidden=YES;
        
    }
    return _clearView;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=KCommontLineViewBagroudColor;
    }
    return _lineView;
}
- (void)setFootInfo:(FootprintInfo *)footInfo
{
    _footInfo = footInfo;
    
    [self.shopImg sd_setImageWithURL:[NSURL URLWithString:_footInfo.goods_image]
                    placeholderImage:[UIImage imageNamed:@"bg100"]];
    
    self.shopNameLab.text = _footInfo.goods_name;
    
   NSString* text = [NSString stringWithFormat:@"¥%.2f",_footInfo.goods_price.floatValue];
    NSMutableAttributedString *muText=[[NSMutableAttributedString alloc]initWithString:text];
    [muText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.5] range:NSMakeRange(1, text.length-1)];
    [muText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(text.length-2, 2)];
    self.shopPriceLab.attributedText=muText;
}
-(void)setFavoritesInfo:(FavoritesGoodsInfo *)favoritesInfo{
    _favoritesInfo=favoritesInfo;
    [self.shopImg sd_setImageWithURL:[NSURL URLWithString:_favoritesInfo.goods_image]
                    placeholderImage:[UIImage imageNamed:@"bg100"]];
    
    self.shopNameLab.text = _favoritesInfo.goods_name;
    NSString* text = [NSString stringWithFormat:@"¥%.2f",favoritesInfo.goods_price.floatValue];
    NSMutableAttributedString *muText=[[NSMutableAttributedString alloc]initWithString:text];
    [muText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.5] range:NSMakeRange(1, text.length-1)];
    [muText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(text.length-2, 2)];
    self.shopPriceLab.attributedText=muText;
}
-(void)setInfo:(GoodsInfo *)info{
      _info=info;
    [self.shopImg sd_setImageWithURL:[NSURL URLWithString:info.image]
                    placeholderImage:[UIImage imageNamed:@"bg100"]];
    self.shopNameLab.text = info.name;
    self.shopPriceLab.text = [NSString stringWithFormat:@"¥%@",info.price];
    
}
-(void)setIsShowButton:(BOOL)isShowButton{
    if (isShowButton) {
        [self .contentView removeAllSubviews];
        [self setupViews];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
       // self.ediButton.selected=NO;
        self.ediButton.hidden=NO;
        [self.ediButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@15);
//            make.centerY.equalTo(self.mas_centerY);
//            make.width.height.equalTo(@25);
            make.edges.equalTo(@0);
        }];
        [self.shopImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@45);
            make.top.equalTo(@2);
            make.height.width.equalTo(@96);
        }];
        [self.shopNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.right.equalTo(@(-10));
            make.left.equalTo(self.shopImg.mas_right).with.offset(15);
        }];
        
        [self.shopPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
            make.bottom.equalTo(@(-10));
            make.left.equalTo(self.shopImg.mas_right).with.offset(15);
        }];
        
        
    }else{
        [self .contentView removeAllSubviews];
        [self setupViews];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
        self.ediButton.hidden=YES;
        self.ediButton.selected=NO;
        [self.ediButton mas_makeConstraints:^(MASConstraintMaker *make) {              make.edges.equalTo(@0);
            
        }];
        [self.shopImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.top.equalTo(@2);
            make.height.width.equalTo(@96);
        }];
        [self.shopNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@5);
            make.right.equalTo(@(-10));
            make.left.equalTo(self.shopImg.mas_right).with.offset(15);
        }];
        
        [self.shopPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
            make.bottom.equalTo(@(-10));
            make.left.equalTo(self.shopImg.mas_right).with.offset(15);
        }];
        
        
        
    }
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(UIButton *)ediButton{
    if (_ediButton==nil) {
        _ediButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [_ediButton setImage:[UIImage imageNamed:@"shopcart_unselect_icon"] forState:UIControlStateNormal];
        [_ediButton setImage:[UIImage imageNamed:@"shopcart_selected_icon"] forState:UIControlStateSelected];
        _ediButton.selected=NO;
        [_ediButton setImageEdgeInsets:UIEdgeInsetsMake(0, -(ScreenWidth-50), 0, 0)];
        [_ediButton addTarget:self action:@selector(ediButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ediButton;
}
-(void)ediButtonAction{
    
    self.ediButton.selected=!self.ediButton.selected;
    if (self.selectBlock) {
        if (self.flag==0) {
            self.selectBlock(self.ediButton.selected,self.index);
        }else{
            self.selectBlock(self.ediButton.selected,self.index);
        }
        
    }
}
- (void)setupViews
{
    [self.contentView addSubview:self.lineView];
    
    [self.contentView addSubview:self.shopImg];
    [self.contentView addSubview:self.ediButton];
    
    [self.contentView addSubview:self.shopNameLab];
    
    [self.contentView addSubview:self.shopPriceLab];
    [self.contentView addSubview:self.clearView];
}

- (UIImageView *)shopImg
{
    if (!_shopImg) {
        _shopImg =[[UIImageView alloc] init];
        _shopImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _shopImg;
}
- (UILabel *)shopNameLab
{
    if (!_shopNameLab) {
        _shopNameLab = [[UILabel alloc] init];
        _shopNameLab.textAlignment = NSTextAlignmentLeft;
        _shopNameLab.font = ADeanFONT13;
        _shopNameLab.numberOfLines=2;
        _shopNameLab.textColor = AllTextColor;
    }
    
    return _shopNameLab;
}
- (UILabel *)shopPriceLab
{
    if (!_shopPriceLab) {
        _shopPriceLab = [[UILabel alloc] init];
        _shopPriceLab.textAlignment = NSTextAlignmentLeft;
        _shopPriceLab.text=@"123";
        _shopPriceLab.font = ADeanFONT12;
        _shopPriceLab.textColor = RGB(233, 40, 46);
    }
    return _shopPriceLab;
}
- (UILabel *)shopPromptLab
{
    if (!_shopPromptLab) {
        _shopPromptLab = [[UILabel alloc] init];
        _shopPromptLab.textAlignment = NSTextAlignmentCenter;
        _shopPromptLab.backgroundColor = [UIColor redColor];
        _shopPromptLab.font = ADeanFONT15;
        _shopPromptLab.textColor = [UIColor whiteColor];
    }
    return _shopPromptLab;
}
- (UILabel *)shopPreferentialLab
{
    if (!_shopPreferentialLab) {
        _shopPreferentialLab = [[UILabel alloc] init];
        _shopPreferentialLab.textAlignment = NSTextAlignmentLeft;
        _shopPreferentialLab.backgroundColor = [UIColor clearColor];
        _shopPreferentialLab.font = ADeanFONT15;
        _shopPreferentialLab.textColor = [UIColor grayColor];
    }
    return _shopPreferentialLab;
}
- (UIButton *)seeButton
{
    if (!_seeButton) {
        _seeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _seeButton.layer.cornerRadius = 2;
        _seeButton.layer.masksToBounds = YES;
        _seeButton.layer.borderWidth = 1;
        _seeButton.layer.borderColor = [UIColor grayColor].CGColor;
        _seeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_seeButton setTitle:@"查看" forState:UIControlStateNormal];
        [_seeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_seeButton setBackgroundColor:[UIColor whiteColor]];
        //        [_seeButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _seeButton;
}



@end
