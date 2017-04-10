//
//  GSTimeTool.m
//  StockSuperior
//
//  Created by guojian on 15/6/5.
//  Copyright (c) 2015年 Gupiaogaoshou. All rights reserved.
//

#import "GSTimeTool.h"


static NSString *const kGSTime_YYYYYnMMyddrHHmm = @"yyyy年MM月dd日 HH:mm";
static NSString *const kGSTime_YYYYMMddHHmm     = @"YYYY-MM-dd HH:mm";
static NSString *const kGSTime_YYYYMMDD         = @"yyyyMMdd";
static NSString *const kGSTime_YYYYMMdd         = @"yyyy-MM-dd";

static NSString *const kGSTime_YYMMddHHmm       = @"yy-MM-dd HH:mm";
static NSString *const kGSTime_YYnMMyddr        = @"yy年MM月dd日";
static NSString *const kGSTime_YYpMMpdd         = @"yy.MM.dd";
static NSString *const kGSTime_YYMMDD           = @"yyMMdd";
static NSString *const kGSTime_YYMMdd           = @"yy-MM-dd";
static NSString *const kGSTime_YYMM             = @"yy-MM";

static NSString *const kGSTime_MMddHHmm         = @"MM-dd HH:mm";
static NSString *const kGSTime_MMyddr           = @"MM月dd日";
static NSString *const kGSTime_MMdd             = @"MM-dd";

static NSString *const kGSTime_HHMMSS           = @"HHmmss";
static NSString *const kGSTime_HHmmss           = @"HH:mm:ss";
static NSString *const kGSTime_HHMM             = @"HHmm";
static NSString *const kGSTime_HHmm             = @"HH:mm";

@implementation GSTimeTool

+ (BOOL)isEnterBackgroundOverTime
{
    BOOL isOver=NO;
    //用户进入后台的时间
    NSDate *loginTime=[[NSUserDefaults standardUserDefaults] valueForKey:kEnterBackgroundTimeKey];
    if (loginTime)
    {
        NSDate *nowTime     = [NSDate date];
        //这里返回的是以秒为单位的
        
        NSTimeInterval time = [nowTime timeIntervalSinceDate:loginTime];
        
        if (time>(30*60))//时间超过30
        {
            isOver  = YES;
        }
    }
    return isOver;
}

+ (BOOL)isManualLoginOverTime
{
    BOOL isOver=NO;
    //获取上次用户手动登录的时间
    NSDate *loginTime=[[NSUserDefaults standardUserDefaults] valueForKey:kUserManualLoginTimeKey];
    if (loginTime)
    {
        NSDate *nowTime     = [NSDate date];
        //这里返回的是以秒为单位的
        
        NSTimeInterval time = [nowTime timeIntervalSinceDate:loginTime];
      
        if (time>60*24*(60*60))//时间超过一个月
        {
            isOver  = YES;
        }
    }
    return isOver;
}

#pragma mark - Time formatter

+ (NSString *)formatterDate:(NSDate *)date toType:(GSTimeType)toType
{
    NSString *dateFormat = nil;
    switch (toType) {
        case GSTimeType_YYYYYnMMyddrHHmm:   dateFormat  = kGSTime_YYYYYnMMyddrHHmm; break;
        case GSTimeType_YYYYMMddHHmm:       dateFormat  = kGSTime_YYYYMMddHHmm;     break;
        case GSTimeType_YYYYMMDD:           dateFormat  = kGSTime_YYYYMMDD;         break;
        case GSTimeType_YYYYMMdd:           dateFormat  = kGSTime_YYYYMMdd;         break;
            
        case GSTimeType_YYMMddHHmm:         dateFormat  = kGSTime_YYMMddHHmm;       break;
        case GSTimeType_YYnMMyddr:          dateFormat  = kGSTime_YYnMMyddr;        break;
        case GSTimeType_YYpMMpdd:           dateFormat  = kGSTime_YYpMMpdd;         break;
        case GSTimeType_YYMMDD:             dateFormat  = kGSTime_YYMMDD;           break;
        case GSTimeType_YYMMdd:             dateFormat  = kGSTime_YYMMdd;           break;
        case GSTimeType_YYMM:               dateFormat  = kGSTime_YYMM;             break;
            
        case GSTimeType_MMddHHmm:           dateFormat  = kGSTime_MMddHHmm;         break;
        case GSTimeType_MMyddr:             dateFormat  = kGSTime_MMyddr;           break;
        case GSTimeType_MMdd:               dateFormat  = kGSTime_MMdd;             break;
            
        case GSTimeType_HHMMSS:             dateFormat  = kGSTime_HHMMSS;           break;
        case GSTimeType_HHmmss:             dateFormat  = kGSTime_HHmmss;           break;
        case GSTimeType_HHMM:               dateFormat  = kGSTime_HHMM;             break;
        case GSTimeType_HHmm:               dateFormat  = kGSTime_HHmm;             break;
        default:                            dateFormat  = kGSTime_MMddHHmm;         break;
    }
    return [self formatterDate:date dateFormat:dateFormat];
}

+ (NSString *)formatterNumber:(NSNumber *)number toType:(GSTimeType)type
{
    
    NSDate *timeDate = [self dateWithNumber:number];//Date时间
    return [self formatterDate:timeDate toType:type];
    
}

+ (NSString *)formatterHMSTime:(NSNumber *)time toType:(GSTimeType)type
{
    if (!time) {
        return @"--:--";
    }
    
    NSString *timeStr=[NSString stringWithFormat:@"%06d",time.intValue];
//    GSLog(@"time: %@",timeStr);
    NSString *hour=@"--",*minute=@"--",*second=@"--";
    if(timeStr.length==6)
    {
        hour=[timeStr substringWithRange:NSMakeRange(0, 2)];
        minute=[timeStr substringWithRange:NSMakeRange(2, 2)];
        second = [timeStr substringWithRange:NSMakeRange(4, 2)];
    }
    
    switch (type)
    {
        case GSTimeType_HHMMSS:
            return [NSString stringWithFormat:@"%@%@%@",hour,minute,second];
            break;
        case GSTimeType_HHmmss:
            return [NSString stringWithFormat:@"%@:%@:%@",hour,minute,second];
            break;
        case GSTimeType_HHMM:
            return [NSString stringWithFormat:@"%@%@",hour,minute];
            break;
        case GSTimeType_HHmm:
            return [NSString stringWithFormat:@"%@:%@",hour,minute];
            break;
        default:
            return [NSString stringWithFormat:@"%@:%@",hour,minute];
            break;
    }
}

+ (NSString *)formatterYMDDate:(NSNumber *)date toType:(GSTimeType)type
{
    NSString *year=@"",*month=@"-",*day=@"";
    if (date)
    {
        NSString *dateStr=date.stringValue;
        if (dateStr.length==6)
        {
            year=[dateStr substringWithRange:NSMakeRange(0, 2)];
            month=[dateStr substringWithRange:NSMakeRange(2, 2)];
            day=[dateStr substringWithRange:NSMakeRange(4, 2)];
        }
    }
    switch (type)
    {
        case GSTimeType_YYnMMyddr:
            return [NSString stringWithFormat:@"%@年%@月%@日",year,month,day];
            break;
        case GSTimeType_YYpMMpdd:
            return [NSString stringWithFormat:@"%@.%@.%@",year,month,day];
            break;
        case GSTimeType_YYMM:
            return [NSString stringWithFormat:@"%@-%@",year,month];
            break;
        case GSTimeType_MMyddr:
            return [NSString stringWithFormat:@"%@月%@日",month,day];
            break;
        case GSTimeType_MMdd:
            return [NSString stringWithFormat:@"%@-%@",month,day];
            break;
        default:
            return [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
            break;
    }
}

+ (NSString *)formatterYMDHMDate:(NSString *)date toType:(GSTimeType)type
{
    NSString *year=@"",*month=@"-",*day=@"",*hour=@"--",*minute=@"--";
    if (date)
    {
        if (date.length==10)
        {
            year=[date substringWithRange:NSMakeRange(0, 2)];
            month=[date substringWithRange:NSMakeRange(2, 2)];
            day=[date substringWithRange:NSMakeRange(4, 2)];
            hour = [date substringWithRange:NSMakeRange(6, 2)];
            minute = [date substringWithRange:NSMakeRange(8, 2)];
        }
    }
    switch (type)
    {
        case GSTimeType_YYYYYnMMyddrHHmm:
            return [NSString stringWithFormat:@"%@年%@月%@日 %@:%@",year,month,day,hour,minute];
            break;
        case GSTimeType_YYnMMyddr:
            return [NSString stringWithFormat:@"%@年%@月%@日",year,month,day];
            break;
        case GSTimeType_YYpMMpdd:
            return [NSString stringWithFormat:@"%@.%@.%@",year,month,day];
            break;
        case GSTimeType_YYMM:
            return [NSString stringWithFormat:@"%@-%@",year,month];
            break;
        case GSTimeType_MMyddr:
            return [NSString stringWithFormat:@"%@月%@日",month,day];
            break;
        case GSTimeType_MMdd:
            return [NSString stringWithFormat:@"%@-%@",month,day];
            break;
        default:
            return [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
            break;
    }
}


#pragma mark - Time Compare

+ (NSInteger)daysFromYMDDateToNow:(NSNumber *)date
{
    NSDate *ymdDate = [self dateWithYMD:date.stringValue];
    NSDate *nowDate = [self dateWithYMD:[self formatterDate:[NSDate date] dateFormat:kGSTime_YYMMDD]];
    
    return [self daysFromDate:ymdDate toDate:nowDate];
}

+ (NSInteger)daysFromNowToYMDDate:(NSNumber *)date
{
    NSDate *nowDate = [self dateWithYMD:[self formatterDate:[NSDate date] dateFormat:kGSTime_YYMMDD]];
    NSDate *ymdDate = [self dateWithYMD:date.stringValue];
    
    return [self daysFromDate:nowDate toDate:ymdDate];
}

+ (NSInteger)daysFromYMDDate:(NSNumber *)date toNumber:(NSNumber *)number
{
    NSDate *fromDate = [self dateWithYMD:date.stringValue];
    NSDate *toDate = [self dateWithNumber:number];
    
    return [self daysFromDate:fromDate toDate:toDate];
}

+ (NSInteger)daysFromNumber:(NSNumber *)fromNumber toNumber:(NSNumber *)toNumber
{
    NSDate *fromDate = [self dateWithNumber:fromNumber];
    NSDate *toDate = [self dateWithNumber:toNumber];
    
    return [self daysFromDate:fromDate toDate:toDate];
}

+ (NSInteger)daysFromYMDNumber:(NSNumber *)fromNumber toYMDNumber:(NSNumber *)toNumber
{
    NSDate *fromDate = [self ymdDateWithNumber:fromNumber];
    NSDate *toDate = [self ymdDateWithNumber:toNumber];
    
    return [self daysFromDate:fromDate toDate:toDate];
}

+ (NSInteger)daysFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSDateComponents *componets = [self componentsBetween:fromDate with:toDate];
    return componets.day + 1;
}

+ (NSInteger)daysFromNumberToNow:(NSNumber *)number
{
    NSDate *fromDate = [self ymdDateWithNumber:number];
    return [self daysFromDate:fromDate toDate:[NSDate date]];
}

+ (BOOL)isFutureTimeNumber:(NSNumber *)number
{
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    
    return number.doubleValue > nowTime;
}

+ (NSDate *)dateFromBirthday:(NSString *)birthday
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone localTimeZone];
    formatter.dateFormat = kGSTime_YYYYMMdd;
    return [formatter dateFromString:birthday];
}

#pragma mark - Tool

/** 计算两个时间之间的Components */
+ (NSDateComponents *)componentsBetween:(NSDate *)one with:(NSDate *)two
{
    NSCalendar *canlendar=[NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [canlendar components:unit fromDate:one toDate:two options:0];
}

/** 格式化NSDate时间 */
+ (NSString *)formatterDate:(NSDate *)date dateFormat:(NSString*)dateFormat
{
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    formatter.dateFormat=dateFormat;
    return [formatter stringFromDate:date];
}

/**
 *  将YYMMDD格式时间转化为NSDate
 */
+ (NSDate *)dateWithYMD:(NSString *)YMD
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone localTimeZone];
    formatter.dateFormat = kGSTime_YYMMDD;
    return [formatter dateFromString:YMD];
}

/**
 *  将标准时间格式化为NSDate
 *
 *  @param number 标准时间
 */
+ (NSDate *)dateWithNumber:(NSNumber *)number
{
    return [[NSDate alloc] initWithTimeIntervalSince1970:(number.longLongValue)];
}

/**
 * 将Date转化为只有年月日的NSDate
 */
+ (NSDate *)ymdDateWithDate:(NSDate *)date
{
    return [self dateWithYMD:[self formatterDate:date dateFormat:kGSTime_YYMMDD]];
}

/**
 * 将标准时间转化为只有年月日的NSDate
 */
+ (NSDate *)ymdDateWithNumber:(NSNumber *)number
{
    return [self ymdDateWithDate:[self dateWithNumber:number]];
}

@end
