//
//  ESRefoundResonModel.h
//  EasyShop
//
//  Created by 就手国际 on 17/1/9.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESRefoundResonModel : NSObject
@property (nonatomic,copy) NSString*tipsStr;
@property (nonatomic,copy) NSString*resonStr;

+(instancetype)refoundResonModel:(NSString*)tipsStr andresonStr:(NSString*)resonStr;

@property (nonatomic,copy) void (^tapBlaock)();

@end
