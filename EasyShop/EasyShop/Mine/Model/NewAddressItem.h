//
//  NewAddressItem.h
//  EasyShop
//
//  Created by guojian on 16/5/17.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewAddressItem : NSObject

/** placeholder */
@property (nonatomic,copy) NSString *placeholer;
/** text */
@property (nonatomic,copy) NSString *text;

+ (instancetype)itemWithPlaceholder:(NSString *)placeholder andText:(NSString*)text; ;

/** 点击block */
@property (nonatomic,copy)  void (^tapBlock)();

@end
