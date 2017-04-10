//
//  CommonResponse.m
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "CommonResponse.h"

@implementation DistrictInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"did":@"id"};
}

@end

@implementation AnnouncementInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"aid":@"id"};
}

@end

@implementation ShopInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"sid":@"id"};
}

@end

@implementation OrderTracesInfo
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"Traces":[TraceInfo class]};
}
@end

@implementation TraceInfo

@end

@implementation ExpressInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"eid":@"id"};
}

@end
