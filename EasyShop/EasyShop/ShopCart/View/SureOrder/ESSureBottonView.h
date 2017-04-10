//
//  ESSureBottonView.h
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/15.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESSureBottonView : UIView

/** 确认订单信息 */
@property (nonatomic,strong) OrderConfirmInfo *confirmInfo;

/** 确认订单 */
@property (nonatomic,copy)  void (^sureBlock)();

@end
