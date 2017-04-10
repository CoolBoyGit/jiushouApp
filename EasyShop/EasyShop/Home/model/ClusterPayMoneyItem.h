//
//  ClusterPayMoneyItem.h
//  EasyShop
//
//  Created by 就手国际 on 16/11/3.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClusterPayMoneyItem : NSObject
@property (nonatomic,assign) int count;//数量
@property (nonatomic,copy) NSString*coupnonValue;//优惠卷金额
@property (nonatomic,strong) NSNumber*price;//单价
@end
