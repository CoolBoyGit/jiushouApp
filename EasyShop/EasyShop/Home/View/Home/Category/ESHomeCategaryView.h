//
//  ESHomeCategaryView.h
//  EasyShop
//
//  Created by wcz on 16/3/26.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ProductCategary)
{
    ProductCategaryGlobal,
    ProductCategaryLimit,
    ProductCategaryNew,
    ProductCategaryLimitGabalnara
};

@interface ESHomeCategaryView : UIView

@property (nonatomic, copy) void (^glassButtonClickBlock)(ProductCategary);


@end
