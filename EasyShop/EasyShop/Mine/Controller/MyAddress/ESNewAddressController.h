//
//  ESNewAddressController.h
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/11.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESNewAddressController : ESMyViewController

/** 成功block */
@property (nonatomic,copy)  void (^successBlock)();
@property (nonatomic,strong) AddressInfo *info;
@property (nonatomic,assign) BOOL isChangeAddress;
/** 选择修改之后的block信息 */
@property (nonatomic,copy) void (^addressBlock)(AddressInfo *info);

@end
