//
//  ESTypeResponse.h
//  EasyShop
//
//  Created by guojian on 16/5/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESTypeResponse : NSObject

/** type */
@property (nonatomic,copy) NSString *type;


/** content */
@property (nonatomic,strong) id content;

@end
