//
//  ESClusterDetailBottomView.h
//  EasyShop
//
//  Created by 就手国际 on 16/10/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESClusterDetailBottomView : UIView
@property (nonatomic,copy) void(^moreButtonBlock) ();
@property (nonatomic,copy) void(^joinButtonActionBlock)();
@property (nonatomic,copy) void(^createClusterBlock)();
@property (nonatomic,strong) GetClusterDetailRespone*clusterDetailRespone;
@end
