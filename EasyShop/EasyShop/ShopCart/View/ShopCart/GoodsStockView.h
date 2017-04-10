//
//  GoodsStockView.h
//  EasyShop
//
//  Created by guojian on 16/7/20.
//  Copyright © 2016年 wcz. All rights reserved.
//  商品库存不足 pop 页面

#import <UIKit/UIKit.h>

@interface GoodsStockView : UIView

/**
 *  显示库存不足商品信息
 */
+(void)showWithStockInfo:(NSMutableArray*)info;
- (void)showView;
- (void)hideView;
@end
