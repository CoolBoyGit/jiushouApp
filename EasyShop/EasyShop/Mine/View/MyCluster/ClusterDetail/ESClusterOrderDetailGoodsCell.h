//
//  ESTogeDetailGoodsCell.h
//  EasyShop
//
//  Created by 就手国际 on 16/10/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESClusterOrderDetailGoodsCell : UITableViewCell
@property (nonatomic,strong) GetClusterOrderDetailRespone*clusterOrederRespone;
@property (nonatomic,copy) void(^tapBlock)();
@property (nonatomic,copy) void(^seeButtonBlock)();
@end
