//
//  ESShopDetailHeaderTitleView.h
//  EasyShop
//
//  Created by wcz on 16/3/31.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESShopDetailHeaderTitleView : UIView

@property (nonatomic, copy) void (^callBack)();
@property (nonatomic, strong) id model;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) void (^tapBlock)();
@property (nonatomic ,assign) BOOL isShowLine;
@end
