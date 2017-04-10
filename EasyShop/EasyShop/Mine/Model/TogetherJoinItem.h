//
//  TogetherJoinItem.h
//  EasyShop
//
//  Created by 就手国际 on 16/10/19.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TogetherJoinItem : NSObject
@property (nonatomic,copy  ) NSString*title;
@property (nonatomic,assign) TogetherType  TogetherType;
+ (instancetype)itemWithTitle:(NSString *)title type:(TogetherType)TogetherType;
@end
