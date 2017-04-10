//
//  ESPayListController.h
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/4.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESPayListController : ESMyViewController

/** 订单id */
@property (nonatomic,copy) NSString *order_id;
/** 订单总金额 */
@property (nonatomic,strong) NSNumber *total_fee;
@property (nonatomic,assign) BOOL isComFromOrderDetail;
@end
