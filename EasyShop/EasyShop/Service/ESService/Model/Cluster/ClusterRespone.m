
//
//  ClusterRespone.m
//  
//
//  Created by 就手国际 on 16/10/21.
//
//

#import "ClusterRespone.h"

@implementation ClusterRespone
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"cid":@"id"};
}

@end
@implementation GetClusterDetailRespone

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"member" : [ClusterDetailMemberRespone class]};
}

@end

@implementation ClusterDetailMemberRespone

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"gid":@"id"};
}


@end

@implementation  GreateClusterRespone

@end
@implementation JoinClusterRespone



@end
@implementation GetClusterListRespone
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"cid":@"id"};
}



@end
@implementation GetClusterOrderDetailRespone



@end
@implementation GetClusterOrderDetailRespone(Extension)
-(ClusterOrderStatus)clusterOrderStatus{
    if ([self.order_status isEqualToString:@"ORDER_WAIT_PAY"]) {//等待支付
        return ClusterOrderStatus_WaitPay;
    }else if ([self.order_status isEqualToString:@"ORDER_PAYED"]){//待发货
        return ClusterOrderStatus_WaitSend;
    }else if ([self.order_status isEqualToString:@"ORDER_FINISH"]){//待评价
        return ClusterOrderStatus_WaitReply;
    }else if ([self.order_status isEqualToString:@"ORDER_WAIT_CONFIRM_GOODS"]){//待收货
        return ClusterOrderStatus_WaitSure;
    }
    return ClusterOrderStatus_Cancel;

}


@end
@implementation GetSimpGoodsRespone
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"gid":@"id"};
}


@end



@implementation getclusterCouponRespone



@end
