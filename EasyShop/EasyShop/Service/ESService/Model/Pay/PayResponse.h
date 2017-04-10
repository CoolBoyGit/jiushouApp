//
//  PayResponse.h
//  EasyShop
//
//  Created by guojian on 16/5/15.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  微信支付信息
 */
@interface WeixinPayInfo : NSObject

/** appid */
@property (nonatomic,copy) NSString *appid;
/** partnerid */
@property (nonatomic,copy) NSString *partnerid;
/** noncestr */
@property (nonatomic,copy) NSString *noncestr;
/** prepay_id */
@property (nonatomic,copy) NSString *prepayid;
/** timestamp */
@property (nonatomic,strong) NSNumber *timestamp;
/** sign */
@property (nonatomic,copy) NSString *sign;
/** 固定："Sign=WXPay" */
@property (nonatomic,copy) NSString *package;

@end

@interface WeixinPayAllInfo : NSObject
@property (nonatomic,strong) NSString*order_id;
@property (nonatomic,strong) WeixinPayInfo*result;
@end
