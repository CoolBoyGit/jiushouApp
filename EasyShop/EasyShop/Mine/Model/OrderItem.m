//
//  OrderItem.m
//  EasyShop
//
//  Created by guojian on 16/5/18.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "OrderItem.h"

@implementation OrderItem

+ (instancetype)itemWithTitle:(NSString *)title type:(OrderType)type
{
    OrderItem *item = [[OrderItem alloc] init];
    item.title  = title;
    item.orderType  = type;
    
    return item;
}

@end
