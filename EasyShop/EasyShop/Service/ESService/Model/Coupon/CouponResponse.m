//
//  CouponResponse.m
//  EasyShop
//
//  Created by guojian on 16/6/11.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "CouponResponse.h"
@implementation GetCouponInfo
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"cid":@"id"};
}


@end
@implementation CouponInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"qid":@"id"};
}

@end