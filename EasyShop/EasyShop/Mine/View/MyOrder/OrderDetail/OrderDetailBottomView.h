//
//  OrderDetailBottomView.h
//  EasyShop
//
//  Created by guojian on 16/5/31.
//  Copyright © 2016年 wcz. All rights reserved.
//  订单详情底部

#import <UIKit/UIKit.h>

static const CGFloat kHeightOrderDetailBottom = 44;

@interface OrderDetailBottomView : UIView

/** 订单详情 */
@property (nonatomic,strong) OrderDetailInfo *orderInfo;

/** 左边block */
@property (nonatomic,copy) ESActionBlock leftBlock;
/** 右边block */
@property (nonatomic,copy) ESActionBlock rightBlock;
/*申请退货的按钮*/
@property (nonatomic,copy) void (^RefoundBlock)();
@end
