//
//  AllInPayData.m
//  EasyShop
//
//  Created by guojian on 16/6/23.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "AllInPayData.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation AllInPayData

- (instancetype)init
{
    if (self = [super init]) {
        _inputCharset       = @"1";
        _receiveUrl          = kAllInPay_ReceiveUrl;
        _version            = @"v1.0";
        
        _signType           = @"1";
        _merchantId         = kAllInPay_MerchantId;
        
        
        _orderCurrency      = @"0";
        
        _payType            = @"27";//27-移动(跨境)支付 v2.x版本的支付控件
        
    }
    return self;
}


- (NSString *)orderDatetime
{
    //商户订单生成日期
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *workDate                = [NSDate dateWithTimeIntervalSinceReferenceDate:[NSDate timeIntervalSinceReferenceDate]];
    NSString *timeStr               = [dateFormatter stringFromDate:workDate];
    return timeStr;
}

- (NSString *)signMsg
{
    NSMutableString *mStr = [NSMutableString string];
    
    [mStr appendFormat:@"inputCharset=%@&",self.inputCharset];
    [mStr appendFormat:@"receiveUrl=%@&",self.receiveUrl];
    [mStr appendFormat:@"version=%@&",self.version];
    [mStr appendFormat:@"signType=%@&",self.signType];
    [mStr appendFormat:@"merchantId=%@&",self.merchantId];
    [mStr appendFormat:@"orderNo=%@&",self.orderNo];
    [mStr appendFormat:@"orderAmount=%@&",self.orderAmount];
    [mStr appendFormat:@"orderCurrency=%@&",self.orderCurrency];
    [mStr appendFormat:@"orderDatetime=%@&",self.orderDatetime];
    [mStr appendFormat:@"productName=%@&",self.productName];
//    [mStr appendFormat:@"ext1=%@&",self.ext1];   //暂时不传
    [mStr appendFormat:@"payType=%@&",self.payType];
    [mStr appendFormat:@"key=%@",kAllInPay_Key];
    
    return [self md5:mStr].uppercaseString;
}

//计算字符串对应的md5值
- (NSString *)md5:(NSString *)string {
    
    if (string == nil) { return nil; }
    
    const char *str = [string cStringUsingEncoding:NSUTF8StringEncoding];
    CC_LONG strLen = (CC_LONG)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    unsigned char *result = calloc(CC_MD5_DIGEST_LENGTH, sizeof(unsigned char));
    CC_MD5(str, strLen, result);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [hash appendFormat:@"%02x", result[i]];
    }
    
    free(result);
    
    return hash;
}

- (NSString *)payData
{
    return [self mj_JSONString];
}

@end
