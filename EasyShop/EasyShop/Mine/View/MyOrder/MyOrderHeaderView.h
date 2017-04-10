//
//  MyOrderHeaderView.h
//  EasyShop
//
//  Created by guojian on 16/5/22.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kIDMyOrderHeader = @"kIDMyOrderHeader";
static const CGFloat kHeightMyOrderHeader = 40;

@interface MyOrderHeaderView : UITableViewHeaderFooterView

/** 订单类型 */
@property (nonatomic,assign) OrderType orderType;
/** 订单信息 */
@property (nonatomic,strong) OrderInfo *orderInfo;

@end
