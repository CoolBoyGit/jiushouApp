//
//  ESPayTool.h
//  EasyShop
//
//  Created by guojian on 16/5/28.
//  Copyright © 2016年 wcz. All rights reserved.
//  支付工具

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ESPayType) {
    ESPayType_Weixin,   //微信支付
    ESPayType_Ali,      //支付宝支付
    ESPayType_AllIn,    //通联支付
};

@interface ESPayTool : NSObject

+ (instancetype)payTool;

/** 微信支付 */
- (void)handleWexinPayWithInfo:(WeixinPayInfo *)info;
/** 支付宝支付 */
- (void)handleAliPayWithOrder:(NSString *)order;

@end
