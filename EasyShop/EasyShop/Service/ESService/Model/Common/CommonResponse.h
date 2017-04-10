//
//  CommonResponse.h
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  地区信息
 */
@interface DistrictInfo : NSObject

/** 地区id */
@property (nonatomic,copy) NSString *did;
/** 地区名称 */
@property (nonatomic,copy) NSString *name;
/** pid */
@property (nonatomic,copy) NSString *pid;
/** 标记 */
@property (nonatomic,copy) NSString *flag;


@end

/**
 *  公告信息
 */
@interface AnnouncementInfo : NSObject

/** 公告id */
@property (nonatomic,copy) NSString *aid;
/** title */
@property (nonatomic,copy) NSString *title;
/** 内容 */
@property (nonatomic,copy) NSString *content;
/** url */
@property (nonatomic,copy) NSString *url;
/** 创建时间（long） */
@property (nonatomic,strong) NSNumber *create_time;
/** displayorder */
@property (nonatomic,strong) NSNumber *displayorder;

@end

/**
 *  店铺信息
 */
@interface ShopInfo : NSObject

/** 店铺id */
@property (nonatomic,copy) NSString *sid;
/** 店铺名字 */
@property (nonatomic,copy) NSString *shop_name;
/** praise_rate */
@property (nonatomic,strong) NSNumber *praise;
/** 描述相符分数 */
@property (nonatomic,strong) NSNumber *desccredit;
/** 服务评分 */
@property (nonatomic,strong) NSNumber *serviceredit;
/** 发货评分 */
@property (nonatomic,strong) NSNumber *deliverycredit;
/** 收藏次数 */
@property (nonatomic,strong) NSNumber *collect;
/** 公司名称 */
@property (nonatomic,copy) NSString *company_name;
/** 公司地址 */
@property (nonatomic,copy) NSString *company_location;

@end

/** 订单物流信息 */
@interface OrderTracesInfo : NSObject
/*物流公司*/
@property (nonatomic,strong)NSString*ShipperName;
/** 订单id */
@property (nonatomic,copy) NSString *EBusinessID;
/** 代码 */
@property (nonatomic,copy) NSString *ShipperCode;
/** 结果 */

@property (nonatomic,copy) NSString *Success;
/** Logistic code */
@property (nonatomic,copy) NSString *LogisticCode;
/** 状态 */
@property (nonatomic,copy) NSString *State;
/** 物流信息（item ：TraceInfo ） */
@property (nonatomic,strong) NSArray *Traces;

@end

/** 物流信息 */
@interface TraceInfo : NSObject

/** 接收时间 */
@property (nonatomic,copy) NSString *AcceptTime;
/** 状态 */
@property (nonatomic,copy) NSString *AcceptStation;

@end

/** 物流公司信息 */
@interface ExpressInfo : NSObject

/** eid */
@property (nonatomic,copy) NSString *eid;
/** 物流公司名字 */
@property (nonatomic,copy) NSString *name;

@end




