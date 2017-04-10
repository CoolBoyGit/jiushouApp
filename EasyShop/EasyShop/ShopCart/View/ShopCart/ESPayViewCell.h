//
//  ESPayViewCell.h
//  EasyShop
//
//  Created by jiushou on 16/6/17.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESPayViewCell : UITableViewCell
@property (nonatomic ,assign) BOOL select;
@property (nonatomic,strong) NSString*titleStr;
@property (nonatomic,strong) NSString *imageStr;
@property (nonatomic,assign) NSUInteger defaultselect;
/** 选中block */
@property (nonatomic,copy) void (^selectedBlock)();
@end
