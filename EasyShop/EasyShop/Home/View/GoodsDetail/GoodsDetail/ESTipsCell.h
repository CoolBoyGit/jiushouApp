//
//  ESTipsCell.h
//  EasyShop
//
//  Created by jiushou on 16/10/9.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESTipsCell : UITableViewCell
@property (nonatomic,strong) UIColor*bgCorlor;//设置背景颜色.
@property (nonatomic,copy) NSString*tipStr;
@property (nonatomic,strong) GoodsDetailInfo*goodsDetail;
@property (nonatomic,assign) BOOL isOneRow;
@end
