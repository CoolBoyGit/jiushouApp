//
//  ESSingleTableViewCell.h
//  EasyShop
//
//  Created by wcz on 16/3/25.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESSingleTableViewCell : UITableViewCell

@property (nonatomic, strong) GoodsInfo *goodsInfo;
@property (nonatomic, assign) BOOL isHidden;
@end
