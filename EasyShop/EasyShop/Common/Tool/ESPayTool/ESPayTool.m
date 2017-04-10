//
//  ESPayTool.m
//  EasyShop
//
//  Created by guojian on 16/5/28.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESPayTool.h"
#import "GetAlipaySDKResult.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation ESPayTool

+ (instancetype)payTool
{
    static ESPayTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    return tool;
}

- (void)handleWexinPayWithInfo:(WeixinPayInfo *)info
{
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = info.partnerid;
    req.prepayId            = info.prepayid;
    req.nonceStr            = info.noncestr;
    req.timeStamp           = info.timestamp.intValue;
    req.package             = info.package;
    req.sign                = info.sign;
    [WXApi sendReq:req];
}
/**支付宝快捷支付*/
- (void)handleAliPayWithOrder:(NSString *)order
{
    [[AlipaySDK defaultService] payOrder:order fromScheme:kAliPay_Scheme callback:^(NSDictionary *resultDic) {
        DZLog(@"reslut = %@",resultDic);
        NSDictionary*dic= [GetAlipaySDKResult VEComponentsStringToDic:[resultDic objectForKey:@"result"] withSeparateString:@"&" AndSeparateString:@"="];
        //用来传递参数
        NSString*str=[dic objectForKey:@"out_trade_no"];
        NSDictionary*newDic=[NSDictionary dictionaryWithObject:str forKey:@"order_id"];
        [[NSNotificationCenter defaultCenter]postNotificationName:kDidPaySuccessNotification object:nil userInfo:newDic];
        //用来刷新界面
[[NSNotificationCenter defaultCenter] postNotificationName:KClusterDidPaySuccessNotification object:nil];
        [UIAlertView bk_alertViewWithTitle:@"提示信息" message:resultDic.description];
        
    }];
}

@end
