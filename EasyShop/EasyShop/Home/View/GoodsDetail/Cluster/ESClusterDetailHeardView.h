//
//  ESJoinListHeardView.h
//  EasyShop
//
//  Created by jiushou on 16/10/12.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESClusterDetailHeardView : UIView
@property (nonatomic,strong) GetClusterDetailRespone*detailInfo;
@property (nonatomic,copy) void(^tapBlock)();
@end
