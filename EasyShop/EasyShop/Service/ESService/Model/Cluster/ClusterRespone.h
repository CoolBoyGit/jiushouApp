//
//

//  
//
//  Created by 就手国际 on 16/10/21.
//
//

#import <Foundation/Foundation.h>
//获取商品页拼团列表
typedef NS_ENUM(NSUInteger, ClusterOrderStatus) {
    ClusterOrderStatus_Cancel,     //已取消
   ClusterOrderStatus_WaitPay,    //待支付
    ClusterOrderStatus_WaitSend,   //待发货
    ClusterOrderStatus_WaitReply,  //待评价
    ClusterOrderStatus_WaitSure,   //待收货
};

@interface ClusterRespone : NSObject
@property (nonatomic,copy) NSString*cid;//
@property (nonatomic,copy) NSString*goods_id;
@property (nonatomic,strong) NSNumber*uid;
@property (nonatomic,copy) NSString*s_num;
@property (nonatomic,copy) NSString*city;
@property (nonatomic,copy) NSString*gap_num;
@property (nonatomic,strong) NSNumber*gap_time;
@property (nonatomic,copy) NSString*user;
@property (nonatomic,copy) NSString*name;
@property (nonatomic,copy)NSString*logo;

@end
//获取商品拼团详细信息
@interface GetClusterDetailRespone:NSObject 
@property (nonatomic,copy) NSString*is_success;
@property (nonatomic,strong) NSNumber*gap_time;
@property (nonatomic,copy) NSString*goods_id;
@property (nonatomic,copy) NSString*goods_name;
@property (nonatomic,copy) NSString*gap_num;
@property (nonatomic,copy) NSString*s_num;
@property (nonatomic,copy) NSString*status;////2是拼团中  3是拼团成功  4是拼团失败
@property (nonatomic,copy) NSString*goods_image;
@property (nonatomic,copy) NSString*goods_price;
@property (nonatomic,strong) NSArray*member;


@end


//商品拼团团购人信息

@interface ClusterDetailMemberRespone:NSObject
@property (nonatomic,strong) NSNumber*gid;
@property (nonatomic,copy) NSString*city;
@property (nonatomic,strong) NSNumber*create_time;
@property (nonatomic,strong) NSNumber*goods_id;
@property (nonatomic,copy) NSString*user;
@property (nonatomic,copy) NSString*name;
@property (nonatomic,copy) NSString*logo;

@end
//创团
@interface GreateClusterRespone:NSObject



@end
//参团

@interface JoinClusterRespone:NSObject



@end

//获取个人中心团列表
@interface GetClusterListRespone:NSObject
@property (nonatomic,copy) NSString*goods_id;
@property (nonatomic,copy) NSString*cid;
@property (nonatomic,copy) NSString*pay_status;//
@property (nonatomic,strong) NSNumber*pay_time;
@property (nonatomic,copy) NSString*order_id;
@property (nonatomic,strong) NSString*cluster_id;
@property (nonatomic,strong) NSNumber*status;
@property (nonatomic,copy) NSString*goods_name;
@property (nonatomic,copy) NSString*goods_image;
@property (nonatomic,copy)NSString*cluster_price;
@property (nonatomic,copy) NSString*cluster_member;
@property (nonatomic,copy) NSString*goods_num;
@end
///获取个人中心拼团订单详细信息
@interface GetClusterOrderDetailRespone:NSObject

@property (nonatomic,copy) NSString*goods_id;
@property (nonatomic,copy) NSString*order_id;
@property (nonatomic,copy) NSString*goods_name;
@property (nonatomic,copy) NSString*goods_image;
@property (nonatomic,copy) NSString*shop_name;
@property (nonatomic,strong) NSNumber*cluster_price;
@property (nonatomic,strong) NSNumber*goods_num;
@property (nonatomic,copy)  NSString*pay_name;
@property (nonatomic,strong) NSNumber*pay_time;
@property (nonatomic,copy ) NSString*pay_status;//1:未支付  ;2:支付成功 3退款中 4 退款成功 5退款失败 
@property (nonatomic,strong) NSNumber*weight;
@property (nonatomic,copy) NSString*freight;
@property (nonatomic,copy) NSString*tax;
@property (nonatomic,copy) NSString*status;//2是拼团中  3是拼团成功  4是拼团失败
@property (nonatomic,copy) NSString*name;
@property (nonatomic,copy) NSString*address;
@property (nonatomic,copy) NSString*mobile;
@property (nonatomic,copy) NSString*personid;
@property (nonatomic,copy) NSString*order_status;//发货状态
@property (nonatomic,strong) NSNumber*order_create_time;//订单创建时间//成团才有订单创建时间
@property (nonatomic,copy) NSString*shipping_time;//发货时间
@property (nonatomic,copy) NSString*shipping_code;//物流公司
@end
@interface GetClusterOrderDetailRespone (Extension)
@property (nonatomic,readonly,assign) ClusterOrderStatus clusterOrderStatus;
@end
/** 获取参团页面的支付信息的商品信息 */
@interface GetSimpGoodsRespone : NSObject
@property (nonatomic,copy) NSString*gid;
@property (nonatomic,copy) NSString*common_id;
@property (nonatomic,copy) NSString*name;
@property (nonatomic,copy) NSString*shop_id;
@property (nonatomic,copy) NSString*price;
@property (nonatomic,copy) NSString*market_price;
@property (nonatomic,copy) NSString*shop_name;
@property (nonatomic,copy) NSString*is_free_shipping;
@property (nonatomic,copy) NSString*salenum;
@property (nonatomic,copy) NSString*stock;
@property (nonatomic,copy) NSString*collect;
@property (nonatomic,copy) NSString*wish;
@property (nonatomic,copy) NSString*arrival;
@property (nonatomic,copy) NSString*image;
@property (nonatomic,copy) NSString*item_pcs;
@property (nonatomic,copy) NSString*sell_time;
@property (nonatomic,copy) NSString*sh_market_price;
@property (nonatomic,copy) NSString*cluster;
@property (nonatomic,strong) NSNumber*cluster_price;
@property (nonatomic,copy) NSString*cluster_member;
@property (nonatomic,copy) NSString*cubage;
@property (nonatomic,copy) NSString*is_free_tax;
@property (nonatomic,copy) NSString*tax;
@property (nonatomic,copy) NSString*customs_clearance;
@property (nonatomic,copy) NSString*warehouse_code;
@property (nonatomic,copy) NSString*goods_border;
@property (nonatomic,copy) NSString*tips;
@property (nonatomic,copy) NSString*cat_id;
@property (nonatomic,copy) NSString*freight;
@end
@interface getclusterCouponRespone : NSObject

@end
