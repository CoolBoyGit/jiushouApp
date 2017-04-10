//
//  CommonRequest.h
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "BaseRequest.h"

/** 5.1 获取验证码 */
@interface GetVerifyRequest : BaseRequest

@end

/** 5.2 获取短信验证码 */
@interface GetSmsVerifyRequest : BaseRequest

/** 手机号码 */
@property (nonatomic,copy) NSString *mobile;

@end

typedef NS_ENUM(NSInteger,DistrictType) {
    DistrictType_Province,  //省
    DistrictType_City,      //市
    DistrictType_Area,      //区
};

/** 5.3 获取地区和地区代号 */
@interface GetDistrictRequest : BaseRequest

/** id */
@property (nonatomic,copy) NSString *did;
/** 类型 ( "1或2"    1：跟据id查询；2 :跟据pid查询；默认为2 ) */
@property (nonatomic,copy) NSNumber *type;

@end

/** 5.4 获取公告 */
@interface GetAnnouncementRequest : BaseRequest

@end


/** 5.5 获取店铺信息 */
@interface GetShopInfoRequest : BaseRequest

/** 店铺id */
@property (nonatomic,copy) NSString *shop_id;

@end

/** 5.6 图片上传（'jpg', 'gif', 'png', 'jpeg'） 
 *
 *  以表单方式post 图片数据
 */
@interface FileUploadRequest : BaseRequest

/** 图片数组( item : UIImage ) */
@property (nonatomic,strong) NSArray *imageItems;

@end

/** 5.8 获取物流信息追踪 */
@interface GetOrderTracesRequest : BaseRequest

/** 搜索关键字 */
@property (nonatomic,copy) NSString *order_id;

@end

/** 5.9 获取快递公司信息 */
@interface GetExpressRequest : BaseRequest

@end









