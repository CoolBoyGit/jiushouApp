//
//  ShareRequest.m
//  EasyShop
//
//  Created by guojian on 16/5/10.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ShareRequest.h"

@implementation ShareFeedRequest

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
   return @{@"sid":@"id"};
}

@end

@implementation SharePushRequest

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"feed_class":@"class"};
}

@end

@implementation ShareMyFollowRequest

@end

@implementation ShareFollowRequest

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"uid":@"id"};
}

@end

@implementation ShareDigRequest

@end

@implementation ShareDedigRequest

@end

@implementation ShareUserInfoRequest

@end