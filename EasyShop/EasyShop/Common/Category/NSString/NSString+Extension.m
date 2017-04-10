//
//  NSString+Extension.m
//  ScanHouse
//
//  Created by guojian on 16/2/16.
//  Copyright © 2016年 Boole. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (BOOL)isEmptyString:(NSString *)string
{
    if (string==nil||[string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isNullString:(NSString *)string
{
    if ([self isEmptyString:string]||[string isEqualToString:@"null"]) {
        return YES;
    }
    return NO;
}

+ (instancetype)handleString:(NSString *)string
{
    return [self handleString:string placeholder:@""];
}
+ (instancetype)handleZeroString:(NSString *)string
{
    if (string && string.floatValue > 0) {
        return string;
    }
    return @"";
}

+ (instancetype)handleString:(NSString *)string placeholder:(NSString *)placeholder
{
    return string ? string : (placeholder ? placeholder : @"");
}

+ (instancetype)handleString:(NSString *)string unit:(NSString *)unit
{
    return [[self handleString:string] stringByAppendingString:unit];
}

+ (instancetype)handleNullString:(NSString *)string
{
    return [self handleNullString:string placeholder:@""];
}

+ (instancetype)handleNullString:(NSString *)string placeholder:(NSString *)placeholder
{
    if (!string||[string isEqualToString:@""]||[string isEqualToString:@"null"]) {
        return placeholder;
    }
    return string;
}

+ (instancetype)handleNumber:(NSNumber *)number
{
    return number ? [NSString stringWithFormat:@"%@",number] : @"";
}

- (BOOL)isContainsEmoji
{
    __block BOOL isEomji = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        
        if (0xd800 <= hs && hs <= 0xdbff) {// surrogate pair
            if (substring.length > 1) {
                const unichar ls    = [substring characterAtIndex:1];
                const int uc        = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji         = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls        = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                isEomji = YES;
            }
        } else {// non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
        }
    }];
    
    return isEomji;
}
- (CGFloat)widthOfFont:(UIFont *)font
{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{ NSFontAttributeName : font }
                                     context:nil];
    return rect.size.width;
}
//计算高度
-(CGFloat)heightOfFont:(UIFont*)font andWidth:(CGFloat) width{
   CGRect rect= [self boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.height;
    
}
//计算自定义字符串的文字高度
-(CGSize)strParaStyleheightOfLineSpacing:(CGFloat)lineSpacing andFont:(UIFont *)font andHeight:(CGFloat)height andwidth:(CGFloat)width{
    NSMutableParagraphStyle*paraStyle=[[NSMutableParagraphStyle alloc]init];
    paraStyle.lineSpacing=lineSpacing;
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}
-(NSAttributedString *)ParaStyleheightOfLineSpacing:(CGFloat)lineSpacing andFont:(UIFont *)font{
    NSMutableParagraphStyle*paraStyle=[[NSMutableParagraphStyle alloc]init];
    paraStyle.lineSpacing=lineSpacing;
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    NSAttributedString*attributeStr=[[NSAttributedString alloc]initWithString:self attributes:dic];
    return attributeStr;

}
- (UIColor *)colorWithHexlpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end
