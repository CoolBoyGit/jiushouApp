//
//  CouponRequest.h
//  EasyShop
//
//  Created by guojian on 16/6/11.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"

/** 16.1 查询用户个人中心优惠券 */
@interface CouponRequest : BaseRequest

/** 分页数 */
@property (nonatomic,strong) NSNumber *page;
/** 记录数 */
@property (nonatomic,strong) NSNumber *n;
/** 类型（1：未使用、2：已使用、3：已过期） */
@property (nonatomic,strong) NSNumber *type;

@end

/** 16.2 查询用户可以领取的优惠券 */
@interface QueryCouponRequest : BaseRequest

@end

/** 16.3 获取优惠券 */
@interface GetCouponRequest : BaseRequest

/** cid */
@property (nonatomic,copy) NSString *cid;

@end

/** 16.4 获取优惠券 */
@interface SelectCouponRequest : BaseRequest

/** 订单id */
@property (nonatomic,copy) NSString *order_id;

@end