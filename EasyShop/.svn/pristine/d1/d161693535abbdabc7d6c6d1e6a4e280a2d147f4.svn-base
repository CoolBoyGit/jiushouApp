//
//  PayRequest.h
//  EasyShop
//
//  Created by guojian on 16/5/15.
//  Copyright © 2016年 wcz. All rights reserved.
//  支付

#import <Foundation/Foundation.h>
#import "BaseRequest.h"

/** 13.1 获取支付信息 */
@interface GetPayMsgRequest : BaseRequest

/** 支付类型（ 1：支付宝 2：微信 3：通联支付 ） */
@property (nonatomic,strong) NSNumber *channel;
/** 订单id */
@property (nonatomic,copy) NSString *order_id;
/** 优惠券号（没有优惠券是可空） */
@property (nonatomic,copy) NSString *coupon_num;

@end

///** 13.2 获取订单优惠券 */
//@interface SelectCouponRequest : BaseRequest
//
///** 订单id */
//@property (nonatomic,copy) NSString *order_id;
//
//@end