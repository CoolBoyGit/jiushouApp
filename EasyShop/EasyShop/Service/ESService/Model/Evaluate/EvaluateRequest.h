//
//  EvaluateRequest.h
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "BaseRequest.h"

/** 9.1 获取个人待评价商品 */
@interface EvaluateRequest : BaseRequest

/** 订单id
 *  可选，若	order_id为空,即获取后有订单的待评论商品，反之则为指定订单的待评论商品
 */
@property (nonatomic,copy) NSString *order_id;

@end

/** 9.2 增加商品评论 */
@interface AddEvaluationRequest : BaseRequest

/** 评价商品 (item ： EvaluationGoodsInfo ) */
@property (nonatomic,strong) NSArray *evaluationItems;

/** 订单id */
@property (nonatomic,copy) NSString *order_id;
/** 描述相符 */
@property (nonatomic,strong) NSNumber *desccredit;
/** 发货速度 */
@property (nonatomic,strong) NSNumber *deliverycredit;
/** 服务态度 */
@property (nonatomic,strong) NSNumber *servicecredit;

/** 是否图片都上传完成 */
@property (nonatomic,assign,readonly) BOOL didUpload;

@end

/**
 *  评论商品信息
 */
@interface EvaluationGoodsInfo : BaseRequest

/** 商品的图片 */
@property (nonatomic,copy) NSString *imageURL;

/** 商品id */
@property (nonatomic,copy) NSString *goods_id;
/** 评分（1~5 整数） */
@property (nonatomic,strong) NSNumber *scores;
/** 评分（1~3 ，1：好，2：一般，3：差） */
@property (nonatomic,strong) NSNumber *result;
/** 评论内容 */
@property (nonatomic,copy) NSString *content;
/** 是否匿名（0、1，1：匿名） */
@property (nonatomic,strong) NSNumber *is_anonymous;

/** 上传的图片 (item : UIImage ) */
@property (nonatomic,strong) NSMutableArray *imageItems;
/** 评论晒图（ image[]=url1, image[]=url2  (可空)） */
@property (nonatomic,strong) NSArray *image;

@end