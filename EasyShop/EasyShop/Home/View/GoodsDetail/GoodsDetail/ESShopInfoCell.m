//
//  ESShopInfoCell.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/3/27.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShopInfoCell.h"

@interface ESShopInfoCell()

@property (nonatomic, strong) UILabel *shopTitle;//商品标题
@property (nonatomic, strong) UILabel *shopExplanation;//商品说明
@property (nonatomic, strong) UIView *lineView;//中间线
@property (nonatomic, strong) UILabel *explanation;//说明
@property (nonatomic,strong) UIView*bttomLineView;


@end


@implementation ESShopInfoCell

- (void)setGoodsInfo:(GoodsDetailInfo *)goodsInfo
{
    _goodsInfo = goodsInfo;
    
    self.shopTitle.text = _goodsInfo.name;
    
    self.shopExplanation.text = _goodsInfo.sevice;
    self.explanation.text = _goodsInfo.prompt;
}

- (UILabel *)shopTitle {
    if (!_shopTitle) {
        _shopTitle = [[UILabel alloc] init];
        _shopTitle.font = ADeanFONT14;
        _shopTitle.numberOfLines=0;
        _shopTitle.textAlignment = NSTextAlignmentLeft;
        _shopTitle.textColor = AllTextColor;
    }
    return _shopTitle;
}
- (UILabel *)shopExplanation {
    if (!_shopExplanation) {
        _shopExplanation = [[UILabel alloc] init];
        _shopExplanation.font = ADeanFONT12;
        _shopExplanation.numberOfLines = 0;
        _shopExplanation.textAlignment = NSTextAlignmentLeft;
        _shopExplanation.textColor = ADeanHEXCOLOR(0x999999);
    }
    return _shopExplanation;
}
- (UILabel *)explanation {
    if (!_explanation) {
        _explanation = [[UILabel alloc] init];
        _explanation.font = ADeanFONT12;
        _explanation.text = @"说明：";
        _explanation.textAlignment=NSTextAlignmentLeft;
        _explanation.textColor = ADeanHEXCOLOR(0x999999);
    }
    return _explanation;
}
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=KCommontLineViewBagroudColor;
    }
    return _lineView;
}
-(UIView *)bttomLineView{
    if (_bttomLineView==nil) {
        _bttomLineView=[[UIView alloc]init];
        _bttomLineView.backgroundColor=KCommontLineViewBagroudColor;
    }
    return _bttomLineView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self intalizedView];
    }
    return self;
}


-(void)intalizedView
{
    [self.contentView addSubview:self.shopTitle];

    [self.shopTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(10));
        make.right.equalTo(@(-10));
        make.top.equalTo(@(5));
    }];

    [self.contentView addSubview:self.shopExplanation];
    [self.shopExplanation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(10));
        make.top.equalTo(self.shopTitle.mas_bottom).offset(5);
        make.right.equalTo(@(-10));
    }];

  
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(self.shopExplanation.mas_bottom).with.offset(5);
        make.height.equalTo(@0.5);
    }];
    
    [self.contentView addSubview:self.explanation];
    [self.explanation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(10));
        make.top.equalTo(self.lineView.mas_bottom).offset(5);
    }];
    [self.contentView addSubview:self.bttomLineView];
    
    [self.bttomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right. bottom.equalTo(@0);
        make.height.equalTo(@(0.5));
        
    }];
    
}

@end
