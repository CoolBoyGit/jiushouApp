//
//  ESTogeListCell.h
//  EasyShop
//
//  Created by 就手国际 on 16/10/19.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESMyclusterOrderListCell : UITableViewCell
@property (nonatomic,copy) void (^leftButtonBlock)(NSString*flag);
@property (nonatomic,copy) void (^rightButtonBlock)();
@property (nonatomic,strong) GetClusterListRespone*respone;
@end
