//
//  ESPayListCell.h
//  EasyShop
//
//  Created by 就手国际 on 17/1/17.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESPayListCell : UITableViewCell
@property (nonatomic,copy) NSString*countStr;
@property (nonatomic,strong) CouponInfo*couponInfo;
@end
