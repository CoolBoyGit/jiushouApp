//
//  CouponResponse.h
//  EasyShop
//
//  Created by guojian on 16/6/11.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface GetCouponInfo :NSObject
@property (nonatomic,copy) NSString*cid;
@property (nonatomic,copy) NSString*name;
@property (nonatomic,copy) NSString*value;
@property (nonatomic,copy) NSString*limit_num;
@property (nonatomic,copy) NSString *use_comments;
@property (nonatomic,copy) NSString *sum;
@property (nonatomic,copy) NSString *used;
@property  (nonatomic,copy) NSString*expdate;
@property (nonatomic,copy) NSString *cover;
@property (nonatomic,copy) NSString*end_time; 
@end
/**首页领取优惠卷信息**/
//"id":"41",
//"name":"朋友圈转发2",
//"value":"1-5",
//"limit_num":"8",
//"use_comments":"全场通用现金劵",
//"sum":"-1",
//"used":"43",
//"expdate":"7",
//"cover":"http://www.jiushouguoji.hk/uploadfile/all/2016/04/13/1460537706.jpg",
//"end_time":"1469956362"


/**
 *  订单优惠券信息
 */
@interface CouponInfo : NSObject

/** id 券id */
@property (nonatomic,copy) NSString *qid;
/** 券类cid */
@property (nonatomic,copy) NSString *cid;

/** 优惠券值 */
@property (nonatomic,copy) NSString *c_value;
/** 优惠券码 */
@property (nonatomic,copy) NSString *c_num;
/** 使用说明 */
@property (nonatomic,copy) NSString *use_comments;
/** cover 图片*/
@property (nonatomic,copy) NSString *cover;
/**优惠卷名字**/
@property (nonatomic,copy) NSString *c_name;
/**过期时间**/
@property (nonatomic,copy) NSString *expdate;
@end
