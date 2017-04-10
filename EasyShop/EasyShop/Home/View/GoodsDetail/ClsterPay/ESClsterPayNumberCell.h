//
//  ESToNumberCell.h
//  EasyShop
//
//  Created by jiushou on 16/10/10.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESClsterPayNumberCell : UITableViewCell
@property (nonatomic,assign) int count;
@property (nonatomic,copy) void(^minuBlock)();
@property (nonatomic,copy) void(^addBlock)();
@end
