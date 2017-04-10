//
//  AddressResponse.m
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "AddressResponse.h"

@implementation AddressInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"aid":@"id",
             @"ddefault":@"default"};
}

@end
