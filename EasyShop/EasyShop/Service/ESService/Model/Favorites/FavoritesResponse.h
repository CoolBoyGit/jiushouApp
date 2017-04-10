//
//  FavoritesResponse.h
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  关注商品信息
 */
@interface FavoritesGoodsInfo : NSObject

/** 关注id */
@property (nonatomic,copy) NSString *fid;
/** 商品id */
@property (nonatomic,copy) NSString *goods_id;
/** 商品名称 */
@property (nonatomic,copy) NSString *goods_name;
/** 商品图片 */
@property (nonatomic,copy) NSString *goods_image;
/** 商品分类id */
@property (nonatomic,copy) NSString *goods_class_id;
/** 商品价格 */
@property (nonatomic,strong) NSNumber *goods_price;
/** 创建时间 */
@property (nonatomic,strong) NSNumber *create_time;

@end

/**
 *  收藏的店铺信息
 */
@interface FavoritesShopInfo : NSObject

/** 关注id */
@property (nonatomic,copy) NSString *fid;
/** 商店id */
@property (nonatomic,copy) NSString *shop_id;
/** 店名 */
@property (nonatomic,copy) NSString *shop_name;
/** 店标 */
@property (nonatomic,copy) NSString *shop_logo;
/** 创建时间 */
@property (nonatomic,strong) NSNumber *create_time;

@end


/**
 *  足迹信息
 */
@interface FootprintInfo : NSObject
/**足迹**/
@property (nonatomic,copy) NSString *fid;
/** 商品id */
@property (nonatomic,copy) NSString *goods_id;
/** 商品名称 */
@property (nonatomic,copy) NSString *goods_name;
/** 商品图片 */
@property (nonatomic,copy) NSString *goods_image;
/** 价格 */
@property (nonatomic,strong) NSNumber *goods_price;
/** stock */
@property (nonatomic,strong) NSNumber *goods_stock;


@end

