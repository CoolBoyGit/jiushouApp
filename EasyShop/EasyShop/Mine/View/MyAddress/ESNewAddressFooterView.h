//
//  ESNewAddressFooterView.h
//  EasyShop
//
//  Created by 就手国际 on 16/12/27.
//  Copyright © 2016年 ldz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonImageModel.h"
@interface ESNewAddressFooterView : UIView
@property (nonatomic,copy) void (^frontBlock)(PersonImageModel*frontModel);
@property (nonatomic,copy) void (^backBlock)(PersonImageModel*backModel);
@property (nonatomic,strong) PersonImageModel*frontModel;
@property (nonatomic,strong) PersonImageModel*backModel;
@end
