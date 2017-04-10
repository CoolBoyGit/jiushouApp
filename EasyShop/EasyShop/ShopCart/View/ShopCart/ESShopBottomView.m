//
//  ShopBottomCell.m
//  MFBank
//
//  Created by YANQI on 15/11/4.
//  Copyright © 2015年 MFBank. All rights reserved.
//

#import "ESShopBottomView.h"

@interface ESShopBottomView()
{
    
}
@property (nonatomic, strong) UILabel                   *priceLabel;
@property (nonatomic ,strong) UILabel                   *countLabel;
@property (nonatomic, strong) UIButton                  *submitBtn;
@property (nonatomic, strong) UIButton                  *selectBtn;
@property (nonatomic, strong) UIView  *view;
/** 是否是全选 */
@property (nonatomic,assign,readonly) BOOL isAllSelected;
@property (nonatomic, nonnull ,strong) UILabel*alltipLabel;
@end

@implementation ESShopBottomView
-(UILabel *)countLabel{
    if (_countLabel==nil) {
        _countLabel=[[UILabel alloc]init];
        _countLabel.textAlignment=NSTextAlignmentRight;
        _countLabel.textColor=RGB(80, 80, 80);
        _countLabel.font=[UIFont systemFontOfSize:14];
    }
    return _countLabel;
}
- (BOOL)isAllSelected
{
    if (self.cartInfo.shopsItems && self.cartInfo.shopsItems.count > 0) {
        for (CartShopInfo *info in self.cartInfo.shopsItems) {
            for (CartGoodsInfo *goodsInfo in info.goodsItems) {
                if (goodsInfo.status.integerValue == 0) {//未选中
                    return NO;
                }
            }
        }
        return YES;
    }
    return NO;
}

- (void)setCartInfo:(CartInfo *)cartInfo
{
    _cartInfo = cartInfo;
    
    self.selectBtn.selected = self.isAllSelected;
    float price         = _cartInfo.cartInfo.price_sum.floatValue;
    int amount    = _cartInfo.cartInfo.goods_sum.intValue;
    
    
    [self setupViews];
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.height.equalTo(@0.35);
        make.width.equalTo(@(ScreenWidth));
        make.left.equalTo(@0);
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.left.equalTo(@6);
        make.height.equalTo(@20);
        make.width.equalTo(@70);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(@0);
        make.top.equalTo(@.5);
        make.width.equalTo(@100);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(@(-110));
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.countLabel.mas_left).offset(-10);
    }];
    NSString *priceStr = [NSString stringWithFormat:@"合计: ¥%0.2f",price];
    NSString *numTotal = [NSString stringWithFormat:@"共%d件",amount];
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:RGB(80, 80, 80) range:NSMakeRange(0, 4)];
    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(5, 1)];
    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.5] range:NSMakeRange(5, priceStr.length-5)];
    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(priceStr.length-2, 2)];
    self.priceLabel.attributedText = attributedString1;
    NSMutableAttributedString*numStr=[[NSMutableAttributedString alloc]initWithString:numTotal];
    [numStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGB(233, 40, 46)} range:NSMakeRange(1, numTotal.length-2)];
    self.countLabel.attributedText=numStr;
  
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}
-(UIView*)view{
    if (_view==nil) {
        _view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
        _view.backgroundColor=KCommontLineViewBagroudColor;
        
    }
    return _view;
}
- (void)setupViews
{
    [self addSubview:self.view];
    [self addSubview:self.submitBtn];
    [self addSubview:self.countLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.selectBtn];
    [self addSubview:self.alltipLabel];
    
    
    //    if (self.cartInfo.cartInfo.goods_sum.intValue==0) {
    //
    //    }else{
    //        [self addSubview:self.countLabel];
    //    }
    
    
}

#pragma mark view init
-(UILabel *)alltipLabel{
    if (_alltipLabel==nil) {
        _alltipLabel=[[UILabel alloc]init];
        _alltipLabel.text=@"全选";
        
    }
    return _alltipLabel;
}
- (UIButton *)selectBtn
{
    
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setTitle:@"全选" forState:UIControlStateNormal];
        _selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_selectBtn setTitleColor:RGB(80, 80, 80) forState:UIControlStateNormal];
        [_selectBtn setBackgroundColor:[UIColor clearColor]];
        [_selectBtn setImage:[UIImage imageNamed:@"shopcart_unselect_icon"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"shopcart_selected_icon"] forState:UIControlStateSelected];
        
        [_selectBtn addTarget:self action:@selector(selectBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        
    }
    return _selectBtn;
}
- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.textColor = AllButtonBackColor;
        _priceLabel.text = @"";
        _priceLabel.font = [UIFont systemFontOfSize:14.f];
        
    }
    return _priceLabel;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"结算" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:AllButtonBackColor];
        _submitBtn.titleLabel.font = ADeanFONT15;
        [_submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _submitBtn;
}

- (void)selectBtnAction
{
    if (self.allSelectedBlock) {
        self.allSelectedBlock(self.isAllSelected);
    }
}
- (void)submitBtnAction
{
    if (self.submitBlock) {
        self.submitBlock();
    }
}

@end
