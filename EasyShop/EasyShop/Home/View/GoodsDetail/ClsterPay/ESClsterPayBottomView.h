//
//  ESToPayBottomView.h
//  EasyShop
//
//  Created by jiushou on 16/10/11.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESClsterPayBottomView : UIView
@property (nonatomic,copy) void (^sureButtonBlock)();
@property (nonatomic,copy) GetSimpGoodsRespone*simpleGoods;
@end
