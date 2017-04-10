//
//  ShopBottomCell.h
//  MFBank
//
//  Created by YANQI on 15/11/4.
//  Copyright © 2015年 MFBank. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ESShopBottomView : UIView

/** 购物车信息 */
@property (nonatomic,strong) CartInfo *cartInfo;
/** 全选block */
@property (nonatomic,copy) void (^allSelectedBlock)(BOOL isSelected);
/** 确认block */
@property (nonatomic,copy) void (^submitBlock)();


@end
