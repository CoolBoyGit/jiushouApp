//
//  TogetherDetailController.h
//  EasyShop
//
//  Created by 就手国际 on 16/10/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClusterOrderDetailCon : ESMyViewController
@property (nonatomic,strong) GetClusterListRespone*clusterListRespone;
@property (nonatomic,copy) NSString*orderId;//拼团支付成功push的页面
@property (nonatomic,assign) BOOL isComeFromOrderList;//判断是来自拼团还是来自正常订单.

@end
