//
//  AddressRequest.m
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "AddressRequest.h"

@implementation AddressRequest

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"aid":@"id"};
}

@end

@implementation GetAddressListRequest

@end

@implementation DeleteAddressRequest

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"aid":@"id"};
}

@end

@implementation SetDefaultRequest

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"aid":@"id"};
}

@end

@implementation AddAddressRequest

@end

@implementation EditAddressRequest
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"aid":@"id"};
}

@end
