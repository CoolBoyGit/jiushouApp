//
//  OrderItem.h
//  EasyShop
//
//  Created by guojian on 16/5/18.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderItem : NSObject

/** title */
@property (nonatomic,copy) NSString *title;
/** 订单类型 */
@property (nonatomic,assign) OrderType orderType;

+ (instancetype)itemWithTitle:(NSString *)title type:(OrderType)type;

@end
