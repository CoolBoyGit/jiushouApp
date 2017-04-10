//
//  AddressRequest.h
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "BaseRequest.h"

/** 6.1 获取用户默认地址 或 指定id地址 */
@interface AddressRequest : BaseRequest

/** 可选参数，id 为空时，返回用户默认地址 */
@property (nonatomic,copy) NSString *aid;

@end

/** 6.2 获取用户地址列表 */
@interface GetAddressListRequest : BaseRequest

@end


/** 6.3 删除指定id地址  */
@interface DeleteAddressRequest : BaseRequest

/** 地址id */
@property (nonatomic,copy) NSString *aid;

@end


/** 6.4 设置指定id地址为默认地址  */
@interface SetDefaultRequest : BaseRequest

/** 地址id */
@property (nonatomic,copy) NSString *aid;

@end

/** 6.5 新增用户地址 */
@interface AddAddressRequest : BaseRequest

/** 用户名称 */
@property (nonatomic,copy) NSString *name;
/** 用户手机号 */
@property (nonatomic,copy) NSString *mobile;
/** 身份证号(可选) */
@property (nonatomic,copy) NSString *personid;
/** 街道地址 */
@property (nonatomic,copy) NSString *address;
/** 省代号 */
@property (nonatomic,copy) NSString *provinceid;
/** 市代号 */
@property (nonatomic,copy) NSString *cityid;
/** 区代号 */
@property (nonatomic,copy) NSString *areaid;
/**  身份证正面 */
@property (nonatomic,copy) NSString*personid_front;
/** 身份证反面*/
@property (nonatomic,copy) NSString*personid_back;

@end

/** 6.6 编辑用户收货地址 */
@interface EditAddressRequest : BaseRequest
@property (nonatomic,copy) NSString*aid;
/** 用户名称 */
@property (nonatomic,copy) NSString *name;
/** 用户手机号 */
@property (nonatomic,copy) NSString *mobile;
/** 身份证号(可选) */
@property (nonatomic,copy) NSString *personid;
/** 街道地址 */
@property (nonatomic,copy) NSString *address;
/** 省代号 */
@property (nonatomic,copy) NSString *provinceid;
/** 市代号 */
@property (nonatomic,copy) NSString *cityid;
/** 区代号 */
@property (nonatomic,copy) NSString *areaid;

@end



















