//
//  ESRefoundResonModel.m
//  EasyShop
//
//  Created by 就手国际 on 17/1/9.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import "ESRefoundResonModel.h"

@implementation ESRefoundResonModel
+(instancetype)refoundResonModel:(NSString *)tipsStr andresonStr:(NSString *)resonStr{
    ESRefoundResonModel*model=[[ESRefoundResonModel alloc]init];
    model.tipsStr=tipsStr;
    model.resonStr=resonStr;
    return model;
}
@end
