//
//  ESOrderDetailController.h
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/11.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESOrderDetailController : ESMyViewController

/** 订单id */
@property (nonatomic,copy) NSString *order_id;
@property (nonatomic,copy) NSString*totalMoney;//总价;
//@property (nonatomic, assign) BOOL is


@end
