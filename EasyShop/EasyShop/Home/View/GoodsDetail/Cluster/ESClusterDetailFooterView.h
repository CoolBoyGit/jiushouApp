//
//  ESJionFooterView.h
//  EasyShop
//
//  Created by 就手国际 on 16/10/18.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESClusterDetailFooterView : UIView
@property (nonatomic,copy) void(^seeButtonBlock)();
@property (nonatomic,strong) GetClusterDetailRespone*detailInfo;
@property (nonatomic,copy) void(^leftTapBlock)();
@property (nonatomic,copy) void(^rightTapBlock)();
@property (nonatomic,strong) NSArray*relationArray;
@end
