//
//  ESLogisticHeardView.h
//  EasyShop
//
//  Created by jiushou on 16/7/1.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESLogisticHeardView : UITableViewHeaderFooterView
@property (nonatomic,strong) OrderTracesInfo *orderTracs;
@property (nonatomic,copy) void (^ pasteButtonBlock)();
@end