//
//  GetAlipaySDKResult.m
//  EasyShop
//
//  Created by 就手国际 on 16/11/4.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "GetAlipaySDKResult.h"

@implementation GetAlipaySDKResult
+(NSMutableDictionary *)VEComponentsStringToDic:(NSString*)AllString withSeparateString:(NSString *)FirstSeparateString AndSeparateString:(NSString *)SecondSeparateString{
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    
    NSArray *FirstArr=[AllString componentsSeparatedByString:FirstSeparateString];
    
    for (int i=0; i<FirstArr.count; i++) {
        NSString *Firststr=FirstArr[i];
        NSArray *SecondArr=[Firststr componentsSeparatedByString:SecondSeparateString];
        [dic setObject:SecondArr[1] forKey:SecondArr[0]];
        
    }
    
    return dic;
}
@end
