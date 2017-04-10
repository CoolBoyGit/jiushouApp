//
//  ESLoginHeaderView.h
//  EasyShop
//
//  Created by 就手国际 on 17/1/17.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESLoginHeaderView : UIView
@property (nonatomic,copy) void (^mobileBlock)(BOOL isHidden);

@end
