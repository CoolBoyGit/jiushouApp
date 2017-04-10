//
//  AddressResponse.h
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  地址信息
 */
@interface AddressInfo : NSObject

/** 地址id */
@property (nonatomic,copy) NSString *aid;
/** 收件人 */
@property (nonatomic,copy) NSString *name;
/** 省份代号 */
@property (nonatomic,strong) NSNumber *provinceid;
/** 城市代号 */
@property (nonatomic,strong) NSNumber *cityid;
/** 区代号 */
@property (nonatomic,strong) NSNumber *areaid;
/** 地区 */
@property (nonatomic,copy) NSString *area;
/** 地址 */
@property (nonatomic,copy) NSString *address;
/** 身份证号 */
@property (nonatomic,copy) NSString *personid;
/** 省份邮编 */
@property (nonatomic,strong) NSNumber *receiver_zip;
/** 用户id */
@property (nonatomic,strong) NSNumber *uid;
/** 手机号 */
@property (nonatomic,copy) NSString *mobile;
/** 是否是默认 */
@property (nonatomic,strong) NSNumber *ddefault;

@end






