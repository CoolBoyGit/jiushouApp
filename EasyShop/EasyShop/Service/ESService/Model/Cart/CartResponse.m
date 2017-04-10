//
//  CartResponse.m
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "CartResponse.h"

@implementation CartInfo

- (NSString *)goodids
{
    NSMutableString *mStr = [NSMutableString string];
    int  i = 0;
    for (CartShopInfo *shop in self.shopsItems) {
        for (CartGoodsInfo *goodsInfo in shop.goodsItems) {
            if (i == 0) {
                [mStr appendString:goodsInfo.goods_id];
            }else{
                [mStr appendString:@","];
                [mStr appendString:goodsInfo.goods_id];
            }
            i++;
        }
    }
    return [mStr copy];
}

@end
@implementation CartSumInfo

@end

@implementation CartShopInfo

- (BOOL)isSelected
{
    for (CartGoodsInfo *info in self.goodsItems) {
        if (info.status.integerValue == 0) {//其中一个不选中，均不选中
            return NO;
        }
    }
    return YES;
}

- (NSString *)cids
{
    NSMutableString *mStr = [[NSMutableString alloc] init];
    for (CartGoodsInfo *goodsInfo in self.goodsItems) {
        if ([mStr isEqualToString:@""]) {//空
            [mStr appendString:goodsInfo.cid];
        }else{
            [mStr appendString:[NSString stringWithFormat:@",%@",goodsInfo.cid]];
        }
    }
    return [mStr copy];
}

@end

@implementation CartGoodsInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"cid":@"id"};
}

@end
@implementation CartGoodsInfo (Extension)

- (BOOL)enableSale
{
    if (self.sale_status.intValue == 1 && self.stock.intValue > 0) {
        return YES;
    }
    return NO;
}

@end

@implementation CartPriceInfo

@end
