//
//  ESLogisticsTableViewCell.h
//  EasyShop
//
//  Created by jiushou on 16/7/1.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESLogisticsTableViewCell : UITableViewCell
@property(nonatomic,strong)TraceInfo*info;
@property (nonatomic,assign)CGFloat lineH;
@property (nonatomic,assign) BOOL isFirstcell;
@property (nonatomic,assign) BOOL isLastcell;
@end