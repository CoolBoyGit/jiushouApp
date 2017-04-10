//
//  GetAlipaySDKResult.h
//  EasyShop
//
//  Created by 就手国际 on 16/11/4.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetAlipaySDKResult : NSObject
+(NSDictionary *)VEComponentsStringToDic:(NSString*)AllString withSeparateString:(NSString *)FirstSeparateString AndSeparateString:(NSString *)SecondSeparateString;
@end
