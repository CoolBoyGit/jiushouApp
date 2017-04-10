//
//  NewAddressCell.h
//  EasyShop
//
//  Created by guojian on 16/5/17.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewAddressItem.h"

static NSString *const kIdNewAddressCell = @"kIDNewAddressCell";
static const CGFloat kHeightNewAddressCell = 44;

@interface NewAddressCell : UITableViewCell

/** item */
@property (nonatomic,assign) NSInteger flag;
@property (nonatomic,strong) NewAddressItem *item;
@property (nonatomic,strong)AddressInfo *info;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,assign) BOOL isChangAddress;
@property (nonatomic,copy)  void (^tapBlock)();
@end
