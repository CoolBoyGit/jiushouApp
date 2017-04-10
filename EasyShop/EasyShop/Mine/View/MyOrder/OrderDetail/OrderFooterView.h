//
//  OrderFooterView.h
//  EasyShop
//
//  Created by guojian on 16/5/31.
//  Copyright © 2016年 wcz. All rights reserved.
//  订单详情页面，底部信息

#import <UIKit/UIKit.h>

static const CGFloat kHeightOrderFooter = 60;

@interface OrderFooterView : UIView

/** 订单详情 */
@property (nonatomic,strong) OrderDetailInfo *orderInfo;
@property (nonatomic,copy) void (^pasteButtonBlock)();
@property (nonatomic,strong) NSArray*relateArray;
@end
