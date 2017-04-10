//
//  ESJoinListViewController.h
//  EasyShop
//
//  Created by jiushou on 16/10/12.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESClusterDetailController : ESMyViewController
@property (nonatomic,assign) int flag;//1 是来自详情页的拼团  2是点击我的页面的查看拼团
@property (nonatomic,copy) NSString*clusterId;//这个是来自我的拼团点击的页面
@property (nonatomic,strong) ClusterRespone*clusterRespone;//这个是详情页的参团info
@property (nonatomic,assign) BOOL isComeClusterOrder;
@end
