//
//  ShopCartCell.h
//  MFBank
//
//  Created by YANQI on 15/11/4.
//  Copyright © 2015年 MFBank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CartGoodsInfo;
@interface ESShopCartCell : UITableViewCell

@property (nonatomic, strong) UIButton                  *selectBtn;//打勾

/** 购物车商品信息 */
@property (nonatomic,strong) CartGoodsInfo *goodsInfo;
@property (nonatomic,assign) BOOL isHidden;
@property (nonatomic,copy) void (^tapToDetail)();
/** 选中block */
@property (nonatomic,copy) void (^selectedBlock)();
/** 加减block */
@property (nonatomic,copy) void (^operateBlock)(BOOL isAdd);

@end
