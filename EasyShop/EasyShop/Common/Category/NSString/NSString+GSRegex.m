//
//  NSString+GSRegex.m
//  StockTutor
//
//  Created by guojian on 16/4/15.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "NSString+GSRegex.h"

@implementation NSString (GSRegex)

- (BOOL)isInvalidNickName
{
    NSString *invalidstr = @"，,’'\\/.。\"“”（()）{{}}《<>》[]&@★☆【】〖〗";
    for (int i = 0; i < invalidstr.length; i ++) {
        unichar invaidch = [invalidstr characterAtIndex:i];
        for (int j = 0; j < self.length; j ++) {
            unichar ch = [self characterAtIndex:j];
            if (ch == invaidch) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)isInvalidEmail
{
    //邮箱校验正则
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isInValidWithRegex:emailRegex];
}

- (BOOL)isInvalidPhone
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^\\d{11}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181(增加)
     22         */
//    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    return [self isInValidWithRegex:MOBIL];
    
//    //手机号校验正则
//    if (![self isInValidWithRegex:MOBIL] || ![self isInValidWithRegex:CM] || ![self isInValidWithRegex:CU] || [self isInValidWithRegex:CT]) {
//        return NO;
//    }
//    return YES;
}

- (BOOL)isInvalidIDCard
{
    NSString *IDCardRegex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self isInValidWithRegex:IDCardRegex];
}

- (BOOL)isInvalidBankCard
{
    NSString *bankCardRegex = @"^(\\d{15,30})";
    return [self isInValidWithRegex:bankCardRegex];
    
    {//网上查询验证方法
//        NSString *cardNo = self;
//        int oddsum = 0;     //奇数求和
//        int evensum = 0;    //偶数求和
//        int allsum = 0;
//        int cardNoLength = (int)[cardNo length];
//        int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
//        
//        cardNo = [cardNo substringToIndex:cardNoLength - 1];
//        for (int i = cardNoLength -1 ; i>=1;i--) {
//            NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
//            int tmpVal = [tmpString intValue];
//            if (cardNoLength % 2 ==1 ) {
//                if((i % 2) == 0){
//                    tmpVal *= 2;
//                    if(tmpVal>=10)
//                        tmpVal -= 9;
//                    evensum += tmpVal;
//                }else{
//                    oddsum += tmpVal;
//                }
//            }else{
//                if((i % 2) == 1){
//                    tmpVal *= 2;
//                    if(tmpVal>=10)
//                        tmpVal -= 9;
//                    evensum += tmpVal;
//                }else{
//                    oddsum += tmpVal;
//                }
//            }
//        }
//        
//        allsum = oddsum + evensum;
//        allsum += lastNum;
//        if((allsum % 10) == 0)
//            return YES;
//        else
//            return NO;
    }
}

#pragma mark - Tool

- (BOOL)isInValidWithRegex:(NSString *)regex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return ![predicate evaluateWithObject:self];
}

@end
