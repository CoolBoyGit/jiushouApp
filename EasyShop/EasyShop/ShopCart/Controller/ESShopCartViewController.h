//
//  ShopCartViewController.h
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/8.
//  Copyright © 2016年 wcz. All rights reserved.
//  购物车

#import <UIKit/UIKit.h>

@interface ESShopCartViewController : ESMyViewController
@property (nonatomic,copy) void (^tapToDetailVc)();
/** 是否是Home页面 */
@property (nonatomic,assign) BOOL isHome;

@end
