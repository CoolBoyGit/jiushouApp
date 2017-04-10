//
//  SearchRequest.h
//  EasyShop
//
//  Created by guojian on 16/6/11.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"


/** 15.1 热门关键字 */
@interface GetSearchHotWordRequest : BaseRequest

/** 返回记录数 */
@property (nonatomic,strong) NSNumber *n;

@end

/** 15.2 自动完成关键字 */
@interface AutoWordListRequest : BaseRequest

/** 关键字拼音字母 */
@property (nonatomic,copy) NSString *word;

@end

/** 15.3 搜索接口 */
@interface SearchRequest : BaseRequest

/** 搜索关键字 */
@property (nonatomic,copy) NSString *key;
/** 分页码（1：开始） */
@property (nonatomic,strong) NSNumber *page;
/** 每页记录数 */
@property (nonatomic,strong) NSNumber *n;

@end