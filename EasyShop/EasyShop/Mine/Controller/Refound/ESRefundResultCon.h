//
//  ESRefundResultCon.h
//  EasyShop
//
//  Created by jiushou on 16/7/4.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESRefundResultCon : ESMyViewController
@property (nonatomic,copy) NSString*reasonStr;
@property (nonatomic,copy) NSString*order_id;
@property (nonatomic,assign) BOOL isFromRefund;
@property (nonatomic,strong) OrderInfo*orderInfo;
@property (nonatomic,assign) BOOL isFromDetailOrder;
@end
