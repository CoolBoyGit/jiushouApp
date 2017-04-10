//
//  ESTogetherController.h
//  EasyShop
//
//  Created by jiushou on 16/10/9.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ClusterPayStausFromWhere) {
    ClusterPayStaus_FromHome,     //开团
    ClusterPayStaus_FromHomeJionCLuster,//商品详情页->参团
    ClusterPayStaus_FromOrderJionCLuster, //拼团订单详情->参团
    
};

@interface ESclusterPayController : ESMyViewController
@property (nonatomic,assign) ClusterPayStausFromWhere typeStaus;
@property (nonatomic,strong) ClusterRespone*clusterRespone;//这个是来自详情页的
@property (nonatomic,strong) GetClusterDetailRespone*clusterDetail;//获取商品拼团的细信息
@property (nonatomic,copy) NSString*goods_id;
@property (nonatomic,copy) NSString*clusterId;//来自订单列表获取的拼团ID
@property (nonatomic,assign) BOOL isComfromJoinListVc;
@end
