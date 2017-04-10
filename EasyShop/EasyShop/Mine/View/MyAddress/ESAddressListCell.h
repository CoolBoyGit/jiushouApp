//
//  ESAddressListCell.h
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ESAddressListCell : UITableViewCell
@property (nonatomic ,assign) CGFloat  H;
/** 地址信息 */
@property (nonatomic,strong) AddressInfo *addressInfo;

/** 默认地址 */
@property (nonatomic,copy) void (^defaultBlock)();
/** 删除地址 */
@property (nonatomic,copy) void (^deleteBlock)();

@property (nonatomic,copy) void (^editBlock)();

@end
