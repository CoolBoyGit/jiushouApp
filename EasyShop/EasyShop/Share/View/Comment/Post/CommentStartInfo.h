//
//  CommentStartInfo.h
//  EasyShop
//
//  Created by guojian on 16/7/7.
//  Copyright © 2016年 wcz. All rights reserved.
//  评论星星信息

#import <Foundation/Foundation.h>

@interface CommentStartInfo : NSObject

/** 评分（1~5 整数） */
@property (nonatomic,strong) NSNumber *scores;
/** 发货速度 */
@property (nonatomic,strong) NSNumber *delivery_scores;
/** 物流 */
@property (nonatomic,strong) NSNumber *logistics_scores;

@end
