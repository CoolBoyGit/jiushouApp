//
//  ESRefoundCell.h
//  EasyShop
//
//  Created by 就手国际 on 17/1/9.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESRefoundResonModel.h"
@interface ESRefoundCell : UITableViewCell
@property (nonatomic,strong) ESRefoundResonModel*model;
@property (nonatomic,assign) BOOL isHidden;
@end
