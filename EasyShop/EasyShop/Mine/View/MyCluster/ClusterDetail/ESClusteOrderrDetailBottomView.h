//
//  ESToghterBottomView.h
//  EasyShop
//
//  Created by 就手国际 on 16/10/21.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESClusteOrderrDetailBottomView : UIView
@property (nonatomic,strong) GetClusterOrderDetailRespone*respone;
@property (nonatomic,copy) void (^seeLogiticsBlock)();
@property (nonatomic,copy) void (^sureButtonBlock)();
@property (nonatomic,copy) void (^commentButtonBlock)();

@end
