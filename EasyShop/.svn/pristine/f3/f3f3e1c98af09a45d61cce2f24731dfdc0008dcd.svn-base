//
//  CartResponse.h
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CartSumInfo;
/**
 *  购物车信息
 */
@interface CartInfo : NSObject

/** 购物车商店数组 （item ：CartShopInfo ） */
@property (nonatomic,strong) NSArray *shopsItems;
/** 购物车统计信息 */
@property (nonatomic,strong) CartSumInfo *cartInfo;

/** 商品id */
@property (nonatomic,copy,readonly) NSString *goodids;

@end
/**
 *  购物车统计信息
 */
@interface CartSumInfo : NSObject

/** 商品数量 */
@property (nonatomic,strong) NSNumber *goods_sum;
/** 总价格 */
@property (nonatomic,strong) NSNumber *price_sum;

@end

/** 购物车商店信息 */
@interface CartShopInfo : NSObject

/** 商店id */
@property (nonatomic,copy) NSString *shop_id;
/** 在商店购买的商品数组( item : CartGoodsInfo )  */
@property (nonatomic,strong) NSArray *goodsItems;
/** 是否选中 */
@property (nonatomic,assign,readonly) BOOL isSelected;
/** 购物车ids */
@property (nonatomic,assign,readonly) NSString *cids;

@end

/** 购物车商品信息 */
@interface CartGoodsInfo : NSObject

/** 购物车id */
@property (nonatomic,copy) NSString *cid;
/** 商店id */
@property (nonatomic,copy) NSString *shop_id;
/** 商店名称 */
@property (nonatomic,copy) NSString *shop_name;
/** 商品id */
@property (nonatomic,copy) NSString *goods_id;
/** 商品名称 */
@property (nonatomic,copy) NSString *goods_name;
/** 商品价格 */
@property (nonatomic,strong) NSNumber *goods_price;
/** 商品数量 */
@property (nonatomic,strong) NSNumber *goods_num;
/** 商品图片 */
@property (nonatomic,copy) NSString *goods_image;
/** 结算状态（0：不选中 | 1：选中） */
@property (nonatomic,strong) NSNumber *status;
/** stock */
@property (nonatomic,strong) NSNumber *stock;
/** 用户id */
@property (nonatomic,copy) NSString *uid;
/** 销售状态（）0下架，1正常，10违规（禁售），只有sale_status 为1时才正常购买 */
@property (nonatomic,strong) NSNumber *sale_status;

@end
@interface CartGoodsInfo (Extension)

/** 是否可卖 */
@property (nonatomic,assign,readonly) BOOL enableSale;

@end

/** 购物车价格信息 */
@interface CartPriceInfo : NSObject

/** 商品数量 */
@property (nonatomic,strong) NSNumber *goods_sum;
/** 价格总数 */
@property (nonatomic,strong) NSNumber *price_sum;

@end

