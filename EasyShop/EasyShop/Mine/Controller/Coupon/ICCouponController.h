//
//  ICCouponController.h
//  iCarePregnant
//
//  Created by wcz on 16/6/22.
//  Copyright © 2016年 oenius. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CouponType) {
    CouponType_Center,  //个人中心优惠券
    CouponType_Select,  //支付页面优惠券
    CouponType_Get ,     //可领取优惠券
    CouponType_selectCluster //获取拼团支付的页面的优惠卷
};

@interface ICCouponController : ESMyViewController

/** 优惠券类型 */
@property (nonatomic,assign) CouponType couponType;

/** 类型（1：未使用、2：已使用、3：已过期） -> 个人中心使用 */
@property (nonatomic,copy) NSNumber *type;

@property (nonatomic,assign) BOOL isComfromJoinList;
/** 订单id   -> 支付页面使用 */
@property (nonatomic,copy) NSString *order_id;
/** 支付订单页面，选择后返回 */
@property (nonatomic,assign) BOOL isComeFromUserCenter;
@property (nonatomic,copy) void (^couponBlock)(CouponInfo *info);

@property (nonatomic,copy) NSString*goodsId;
@end
