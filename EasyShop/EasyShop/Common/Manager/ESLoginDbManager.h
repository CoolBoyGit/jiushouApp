//
//  LDZDetailDbManager.h
//  1513-LDZ
//
//  Created by qf1 on 16/1/4.
//  Copyright (c) 2016年 李达志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "ESLoginModel.h"
typedef void(^GetAllObjectsBlock)(NSMutableArray *array);
@interface ESLoginDbManager : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(ESLoginDbManager);
//向数据库中，插入model
-(void)insertInto:(ESLoginModel *)model;

//获得所有的object
-(void)getAllObjects:(GetAllObjectsBlock )block;

//创建一个表用来存放关于主题的信息

-(void)creatThemeTable;

//插入关于them的信息
-(void)insterInfo:(OtherThemeInfo*)info;
//获取所有的主题info

-(void)getAllThemeinfo:(GetAllObjectsBlock)block;


@end
