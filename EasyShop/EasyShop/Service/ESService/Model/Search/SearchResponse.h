//
//  SearchResponse.h
//  EasyShop
//
//  Created by guojian on 16/6/11.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 关键字 */
@interface KeyWord : NSObject

/** kid */
@property (nonatomic,copy) NSString *kid;
/** keyword */
@property (nonatomic,copy) NSString *keyword;

@end

/** 查询商品信息 */
@interface SearchGoodsInfo : NSObject

/** gid */
@property (nonatomic,copy) NSString *gid;
/** common_id */
@property (nonatomic,copy) NSString *common_id;
/** 商品名字 */
@property (nonatomic,copy) NSString *name;
/** 商店id */
@property (nonatomic,copy) NSString *shop_id;
/** 商店 name */
@property (nonatomic,copy) NSString *shop_name;
/** 价格 */
@property (nonatomic,strong) NSNumber *price;
/** 市价 */
@property (nonatomic,strong) NSNumber *market_price;
/** is_free_shipping */
@property (nonatomic,copy) NSString *is_free_shipping;
/** salenum */
@property (nonatomic,strong) NSNumber *salenum;
/** stock */
@property (nonatomic,strong) NSNumber *stock;


@end
