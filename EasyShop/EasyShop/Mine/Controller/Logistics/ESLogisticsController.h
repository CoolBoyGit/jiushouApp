//
//  LogisticsController.h
//  EasyShop
//
//  Created by jiushou on 16/7/1.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESLogisticsController : ESMyViewController
@property (nonatomic,strong) OrderDetailInfo *detailInfo;
@property (nonatomic,strong) NSString*orderId;
@property (nonatomic,assign) BOOL isComfromClusterDetail;
@property (nonatomic,copy) NSString*logisticsStr;
@end
