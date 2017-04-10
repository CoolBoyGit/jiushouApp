//
//  ESHomeProductCell.h
//  EasyShop
//
//  Created by wcz on 16/3/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kIDESHomeProductCell = @"kIDESHomeProductCell";

@interface ESHomeProductCell : UITableViewCell

/** 目标控制器 */
/** 专场信息 */
@property (nonatomic,strong) ActivityInfo *activityInfo;

@end
