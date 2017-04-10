//
//  GoodsResponse.m
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "GoodsResponse.h"
#import "GSTimeTool.h"

@implementation NavInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"nid":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"m_banner":[BannerInfo class]};
}

@end
@implementation BannerInfo

@end

@implementation ActivityInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"aid":@"id"};
    return @{@"descriptions":@"description"};
}


//在这里里面ESImageInfo来替代images
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"goods_list":[GoodsInfo class]};
}

@end
@implementation ActivityInfo (Extentsion)
-(BOOL)haveGoods{
    if (self.goods_list.count==0) {
        return YES;
    }
    return NO;
}
- (BOOL)hasGoods
{
    if (self.goods_list && self.goods_list.count >=1) {
        return YES;
    }
    return NO;
}

- (CGFloat)cellHeight
{
    return self.hasGoods ? ScreenWidth*(408/617.0)+240.0: ScreenWidth*(408/617.0)+10;
}

@end


@implementation GoodsInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"gid":@"id"};
}

@end
@implementation GoodsInfo (Extension)

- (GoodsInfoType)goodsInfoType
{
    if ([GSTimeTool isFutureTimeNumber:self.sell_time] && self.stock.integerValue > 0) {//未到销售时间//心愿单
        return GoodsInfoType_Wish;
    }else if (self.stock.integerValue == 0) {//库存不足
        return GoodsInfoType_Remind;
    }
    return GoodsInfoType_Sell;//购物车
}

- (BOOL)isCollect
{
    if (self.subscribe_collect) {
        if ([self.subscribe_collect isEqualToString:@"Y"]) {
            return YES;
        }
    }
    return NO;
}
- (BOOL)isWish
{
    if (self.subscribe_wish) {
        if ([self.subscribe_wish isEqualToString:@"Y"]) {
            return YES;
        }
    }
    return NO;
}
- (BOOL)isArrival
{
    if (self.subscribe_arrival) {
        if ([self.subscribe_arrival isEqualToString:@"Y"]) {
            return YES;
        }
    }
    return NO;
}

@end

@implementation GoodsDetailInfo
//在这里里面ESImageInfo来替代images
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"images":[ESImageInfo class]};
}



@end

@implementation ESImageInfo

@end
@implementation GoodsCartInfo

@end

@implementation GoodsCategoryInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"cid":@"id"};
}

@end

@implementation GoodsEvaluationInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"eid":@"id"};
}

@end

@implementation EvaluationInfo

@end

@implementation PanicInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"pid":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"m_banner":[BannerInfo class],
             @"activeList":[ActivityInfo class]};
}

@end

