//
//  ESShipAddressListController.h
//  EasyShop
//
//  Created by wcz on 16/5/29.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESShipAddressListController : ESMyViewController

/** 选择的地址信息 */
@property (nonatomic,copy) void (^addressBlock)(AddressInfo *info);

@end
