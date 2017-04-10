//
//  ESAddressListController.h
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESAddressListController : ESMyViewController

/** 是否是订单进入，选择地址 */
@property (nonatomic,assign) BOOL isOrder;

/** 选择的地址信息 */
@property (nonatomic,copy) void (^addressBlock)(AddressInfo *info);

@end