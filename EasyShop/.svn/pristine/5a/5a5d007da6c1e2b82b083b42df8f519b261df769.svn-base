//
//  MyOrderFooterView.h
//  EasyShop
//
//  Created by guojian on 16/5/22.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kIDMyOrderFooter = @"kIDMyOrderFooter";
static const CGFloat kHeightMyOrderFooter = 80;

@interface MyOrderFooterView : UITableViewHeaderFooterView

/** 订单信息 */
@property (nonatomic,strong) OrderInfo *orderInfo;
/*申请退款*/
@property (nonatomic ,strong) void(^applyMoney)();
/** 取消订单 */
@property (nonatomic,copy)  void (^cancleBlock)();
/** 右边按钮block { 立即支付、 } */
@property (nonatomic,copy)  void (^rightBlock)();
/*左边的按钮是申请退货*/
@property  (nonatomic,copy) void (^refoundBlock)();
@end
