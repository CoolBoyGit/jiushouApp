//
//  ClusterRequest.h
//  EasyShop
//
//  Created by 就手国际 on 16/10/21.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "BaseRequest.h"
typedef NS_ENUM(NSInteger,TogetherType) {
    TogetherType_All = 1,      //  全部
    TogetherType_Waiting,   //拼团中
    TogetherType_Succeed,  //成功
    TogetherType_Failed,  //失败
    
    //    OrderType_Cancel,       //已取消
    
};
//获取商品详情页的拼团列表
@interface ClusterRequest : BaseRequest
//商品ID
@property (nonatomic,copy) NSString*goods_id;
/** 页数 */
@property (nonatomic,strong) NSNumber *page;
/** 记录数 */
@property (nonatomic,strong) NSNumber *n;
@end
//获取商品拼团详细信息
@interface GetClusterDetailRequest :BaseRequest
@property (nonatomic,copy) NSString*cluser_id;
@end
//创团
@interface  CreateClusterRequest:BaseRequest
@property (nonatomic,copy) NSString*goods_id;//商品id;
@property (nonatomic,strong) NSNumber* goods_num;//商品数量;
@property (nonatomic,copy   ) NSString* addr_id;//地址id;
@property (nonatomic,strong) NSNumber*pay_channel;//支付方式：1：支付宝
@property (nonatomic,copy) NSString* coupon_num;//优惠券号
@property (nonatomic,copy)   NSString*$message;//留言

@end

//参团
@interface JoinClusterRequest:BaseRequest

@property (nonatomic,copy )   NSString*cluster_id;//  要加入的团id,
@property (nonatomic,copy) NSString*goods_id;//商品id;
@property (nonatomic,strong) NSNumber* goods_num;//商品数量;
@property (nonatomic,copy) NSString* addr_id;//地址id;
@property (nonatomic,strong) NSNumber*pay_channel;//支付方式：1：支付宝
@property (nonatomic,copy) NSString* coupon_num;//优惠券号
@property (nonatomic,copy)   NSString*$message;//留言
@end
//获取个人中心团列表
@interface GetClusterListRequest:BaseRequest

@property (nonatomic,strong) NSNumber*type;//type  1：获所有拼团；2：拼团中；3：拼团成功；4：拼团失败；
/** 页数 */
@property (nonatomic,strong) NSNumber *page;
/** 记录数 */
@property (nonatomic,strong) NSNumber *n;



@end
@interface GetClusterOrderDetailRequest :BaseRequest
@property (nonatomic,copy) NSString*orderDid;//订单ID
@property (nonatomic,copy) NSString*order_id;

@end
/** 获取商品的信息在拼团支付的界面 */
@interface GetSimpGoodsRequest:BaseRequest
@property (nonatomic,copy) NSString*goods_id;
@end
@interface GetclusterCouponRequest : BaseRequest
@property (nonatomic,strong) NSString*goods_id;
@end
@interface GetClusterGoodsRequest:BaseRequest
@property (nonatomic,copy) NSString *page;
@property (nonatomic,copy) NSString*n;
@property (nonatomic,copy) NSString*orderBy;
@property (nonatomic,copy) NSString*order;

@end

