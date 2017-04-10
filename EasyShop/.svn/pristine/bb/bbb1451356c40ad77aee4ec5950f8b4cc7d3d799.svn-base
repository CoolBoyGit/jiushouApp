//
//  CartRequest.h
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "BaseRequest.h"

/** 10.1 查询购物车商品（需要登录） */
@interface CartRequest : BaseRequest

/** 勾选状态（0未钩选，1已钩选, 空不带任何参数，全部显示） */
@property (nonatomic,strong) NSNumber *status;

@end

/** 10.2 往购物车添加商品（需要登录 ） */
@interface AddCartGoodsRequest : BaseRequest

/** 商品id */
@property (nonatomic,copy) NSString *goods_id;
/** 添加件数 */
@property (nonatomic,strong) NSNumber *n;

@end

/** 10.3 编辑购物车商品（需要登录） */
@interface EditCartGoodsRequest : BaseRequest

/** 购物车id */
@property (nonatomic,copy) NSString *cid;
/** 添加件数 正数为增加 （n）， 负数为减少(-n) */
@property (nonatomic,strong) NSNumber *n;

@end


/** 10.4 删除购物车中的商品 */
@interface DeleteCartGoodsRequest : BaseRequest

/** 购物车id */
@property (nonatomic,copy) NSString *cid;
/** 商品id */
@property (nonatomic,copy) NSString *goods_id;

@end

/** 10.5 统计购物车中商品件数和总价[不包括运费]（需要登录） */
@interface GetCartInfoRequest : BaseRequest

/** 购物车id 
 *  该id 可为多个,用【,】号分开，如：id=id1,id2,id3 ;如果id为空时，返回钩选中的商品
 */
@property (nonatomic,copy) NSString *cids;

@end

/** 10.6 更新购物车结算状态（需登录） */
@interface EditStatusRequest : BaseRequest

/** 购物车id */
@property (nonatomic,copy) NSString *cid;
/** 状态（0：取消  1：勾选） */
@property (nonatomic,strong) NSNumber *status;


@end


