//
//  EvaluateRequest.m
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "EvaluateRequest.h"
#import <MJExtension.h>

@implementation EvaluateRequest

@end


@implementation AddEvaluationRequest

- (NSDictionary *)params
{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    //商品
    for (EvaluationGoodsInfo *info in self.evaluationItems) {
        [mDic setValue:[info params] forKey:info.goods_id];
    }
    //order
    NSMutableDictionary *orderDic = [NSMutableDictionary dictionary];
    [orderDic setValue:self.order_id forKey:@"order_id"];
    [orderDic setValue:self.desccredit forKey:@"desccredit"];
    [orderDic setValue:self.deliverycredit forKey:@"deliverycredit"];
    [orderDic setValue:self.servicecredit forKey:@"servicecredit"];
    [mDic setValue:[orderDic copy] forKey:@"order"];
    
    return @{@"jsonData" : mDic.mj_JSONString};
}

- (BOOL)didUpload
{
    for (EvaluationGoodsInfo *info in self.evaluationItems) {
        if (info.imageItems.count != info.image.count) {//数量不相等，表示没有上传成功
            return NO;
        }
    }
    return YES;
}

@end

@implementation EvaluationGoodsInfo

- (NSMutableArray *)imageItems
{
    if (!_imageItems) {
        _imageItems = [NSMutableArray array];
    }
    return _imageItems;
}

- (NSDictionary *)params
{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    [mDic setValue:self.scores forKey:@"scores"];
    [mDic setValue:self.result forKey:@"result"];
    [mDic setValue:self.content forKey:@"content"];
    [mDic setValue:self.is_anonymous forKey:@"isanonymous"];
    [mDic setValue:self.image forKey:@"image"];
    
    return [mDic copy];
}

@end