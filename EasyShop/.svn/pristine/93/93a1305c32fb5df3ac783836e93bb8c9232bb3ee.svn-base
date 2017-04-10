//
//  ESPopController.h
//  EasyShop
//
//  Created by jiushou on 16/8/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESHomeShopDetailController.h"
#import "ICShareInfoView.h"
@interface ESPopController : UIViewController
@property (nonatomic,copy)  NSString *goods_id;;
/**
 *  弹出的view
 */
@property(nonatomic,strong) ICShareInfoView * popView;

/**
 *  rootview
 */
@property(nonatomic,strong) UIView * rootview;

/**
 *  rootVC
 */
@property(nonatomic,strong) ESHomeShopDetailController * rootVC;

/**
 *  maskView
 */
@property(nonatomic,strong) UIView * maskView;

/**
 *  初始化 rootVC:根VC， popView:弹出的view
 */
- (void)createPopVCWithRootVC:(ESHomeShopDetailController *)rootVC andPopView:(ICShareInfoView *)popView andGoods_id:(NSString*)goods_id;

@end
