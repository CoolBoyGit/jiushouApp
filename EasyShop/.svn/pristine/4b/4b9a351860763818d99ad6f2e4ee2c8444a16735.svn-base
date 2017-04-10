//
//  GoodsRequest.h
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "BaseRequest.h"

/** 7.1 获取商品列表 */
@interface GoodsRequest : BaseRequest

/** 第几页 */
@property (nonatomic,strong) NSNumber *page;
/** 每页记录数量 */
@property (nonatomic,strong) NSNumber *n;
/** 排序方式（可选）
 *  1:按发布顺序;2：按销量；3：按销售价格；（可选，默认参数为1）
 */
@property (nonatomic,strong) NSNumber *orderBy;
/** 升降序(可选)
 *  asc:升序；desc:降序（可选，默认asc）
 */
@property (nonatomic,copy) NSString *order;
/** 分类筛选（可选） */
@property (nonatomic,copy) NSString *cat_id;
/** 店铺筛选 (可选) */
@property (nonatomic,copy) NSString *shop_id;

@end

/** 7.2 获取商品导航分类列表  */
@interface GetNavListRequest : BaseRequest

/** 可选(导航id) */
@property (nonatomic,copy) NSString *nid;

@end

/** 7.3 获取分类下的每个活动专场 */
@interface GetActivityListRequest : BaseRequest

/** 分类id（nav id） */
@property (nonatomic,copy) NSString *nav_id;

@end

/** 7.4 获取活动专场 下的商品列表 */
@interface GetActivityGoodsListRequest : BaseRequest

/** 专场id */
@property (nonatomic,strong) NSString *aid;
/** 分页数（默认 1） */
@property (nonatomic,strong) NSNumber *page;
/** 数量（默认 10） */
@property (nonatomic,strong) NSNumber *n;

@end

/** 7.5 获取商品详情 */
@interface GetGoodsDetailRequest : BaseRequest

/** 商品id */
@property (nonatomic,copy) NSString *goods_id;

@end

/** 7.6 获取推荐商品列表 */
@interface GetRelatedGoodsRequest : BaseRequest

/** 商品id */
@property (nonatomic,copy) NSString *goods_id;
/** 最多返回记录数量 */
@property (nonatomic,strong) NSNumber *n;

@end

/** 7.7 获取商品分类信息 */
@interface GetGoodsCategoryRequest : BaseRequest

/** 父类id ，不填写即获取一级分类 */
@property (nonatomic,copy) NSString *pid;

@end

/** 7.8 获取商品评论 */
@interface GetGoodsEvaluationRequest : BaseRequest

/** 商品id */
@property (nonatomic,copy) NSString *goods_id;
/** 分页数 默认 1 */
@property (nonatomic,strong) NSNumber *page;
/** 记录数 默认 10 */
@property (nonatomic,strong) NSNumber *n;

@end

/** 7.9 获取商品评论信息统计 */
@interface GetEvaluationInfoRequest : BaseRequest

/** 商品id */
@property (nonatomic,copy) NSString *goods_id;

@end

/** 7.10 获取导航商品列表 */
@interface SubGoodsListRequest : BaseRequest

/** 分页数 默认 1 */
@property (nonatomic,strong) NSNumber *page;
/** 记录数 默认 10 */
@property (nonatomic,strong) NSNumber *n;
/** type （1：今日新上 2：抢购） */
@property (nonatomic,strong) NSNumber *type;

@end
















