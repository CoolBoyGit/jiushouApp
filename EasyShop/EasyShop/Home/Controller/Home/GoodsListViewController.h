//
//  GoodsListViewController.h
//  EasyShop
//
//  Created by guojian on 16/5/30.
//  Copyright © 2016年 wcz. All rights reserved.
//  商品列表页面

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GoodsListType) {
    GoodsListType_Cart,         //购物车 -> 去逛逛
    GoodsListType_Activity,     //活动专场
    GoodsListType_Today,        //今日特卖
};

@interface GoodsListViewController : ESMyViewController

/** 商品列表类型 */
@property (nonatomic,assign) GoodsListType listType;

/** 专场名称 */
@property (nonatomic,copy) NSString *activity_name;
/** 专场id */
@property (nonatomic,copy) NSString *activity_id;
@property (nonatomic,copy) NSString *heardImageStr;



@end
