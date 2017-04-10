//
//  TogetherJoinItem.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/19.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "TogetherJoinItem.h"

@implementation TogetherJoinItem
+(instancetype)itemWithTitle:(NSString *)title type:(TogetherType)TogetherType{
    TogetherJoinItem*item=[[TogetherJoinItem alloc]init];
    item.title=title;
    item.TogetherType=TogetherType;
    return item;
}
@end
