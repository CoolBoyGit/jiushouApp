//
//  ESHomeShopDetailController.h
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/3/27.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESMyViewController.h"
@interface ESHomeShopDetailController :ESMyViewController

/** 商品id */
@property (nonatomic,copy)  NSString *goods_id;
@property (nonatomic,strong) UIScrollView *scrollView;
@end