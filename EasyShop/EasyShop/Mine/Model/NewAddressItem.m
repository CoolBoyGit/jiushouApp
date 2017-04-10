//
//  NewAddressItem.m
//  EasyShop
//
//  Created by guojian on 16/5/17.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "NewAddressItem.h"

@implementation NewAddressItem
+ (instancetype)itemWithPlaceholder:(NSString *)placeholder andText:(NSString*)text{
    NewAddressItem *item = [[NewAddressItem alloc] init];
    item.placeholer = placeholder;
    item.text=text;
    return item;

    
}
@end
