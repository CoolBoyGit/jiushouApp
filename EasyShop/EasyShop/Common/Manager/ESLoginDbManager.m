//
//  LDZDetailDbManager.m
//  1513-LDZ
//
//  Created by qf1 on 16/1/4.
//  Copyright (c) 2016年 李达志. All rights reserved.
//

#import "ESLoginDbManager.h"
#import "FMDB.h"
@interface ESLoginDbManager(){
    FMDatabaseQueue *_dataBaseQueue;
}
@end
@implementation ESLoginDbManager
SYNTHESIZE_SINGLETON_FOR_CLASS(ESLoginDbManager);
-(id)init{
    if (self = [super init]) {
        [self createDb];
    }
    return self;
}

-(void)createDb{
    //把数据库放在沙盒下的 Documents
    
    NSArray *docArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获得Document的目录地址
    NSString *docPath = [docArray lastObject];
    NSLog(@"docPath %@",docPath);
    
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"ESApp.db"];
    NSLog(@"dbPath %@",dbPath);
    //databaseQueueWithPath 如果这个数据库，就打开；如果数据库不存在则帮我们创建数据库
    _dataBaseQueue = [FMDatabaseQueue  databaseQueueWithPath:dbPath];
    
    [self createTableOne];
    
}
//创建表格
-(void)createTableOne{
    
    //1写建表的语句
    NSString *sql = @"CREATE TABLE IF NOT EXISTS LoginList (mobile text,imageStr text)";
    
    //在队列执行sql语句，一条sql语句执行完，另一条语句被执行（同时有两个sql语句，其中一条sql语句的执行排队）
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        //2executeUpdate 执行非查询语句
        BOOL isSu = [db executeUpdate:sql];
        if (isSu) {
            NSLog(@"执行建表语句成功");
                   }
        else{
           NSLog(@"执行建表语句失败");
        }
    }];
}
-(void)insertInto:(ESLoginModel *)model{
    //(重点)一定不能是基本类型，NSInteger 把基本类型转为NSNumber或者字符串。参数类型是NSObject的子类。
    //放在队列执行sql语句
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        //根据model.applicationId 查询是否存在，如果存在就不执行，如果不存在，插入
        //查询sql语句
        NSString *selectSql = @"select * from  LoginList where mobile = ?";
        //执行查询sql语句
        FMResultSet *set =  [db executeQuery:selectSql,model.mobile];
        BOOL isExist ;
        isExist = NO;
        //next 指针指向下一条数据
        while ([set next]) {
            isExist = YES;
        }
        if (isExist == NO) {
            //这条数据不存在
            
            //1写插入的sql语句
            NSString *insertSQL =  @"INSERT INTO LoginList(mobile ,imageStr) VALUES(?, ?)";
            //2执行sql语句
            BOOL isSucess =  [db executeUpdate:insertSQL,model.mobile,model.imageStr];
            if (isSucess) {
                NSLog(@"%@",@"执行插入语句成功");
            }else{
                NSLog(@"%@",@"执行插入语句失败");
            }
        }
        
    }];
    
}
//获得所有的object
-(void)getAllObjects:(GetAllObjectsBlock )block{
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        //1写查询语句
        NSString *selectSql = @"select * from LoginList";
        //2执行查询语句获得结果集
        FMResultSet *rs  = [db executeQuery:selectSql];
        //存储模型的数组
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        //3next 一条一条的指向
        while ([rs next]) {
            ESLoginModel  *model = [[ESLoginModel alloc] init];
            model.mobile=[rs stringForColumn:@"mobile"];
            model.imageStr=[rs stringForColumn:@"imageStr"];
            //数组添加模型
            [tempArray addObject:model];
        }
        //调用block
        block(tempArray);
        
    }];
}
-(void)creatThemeTable{
    //1写建表的语句
    NSString *sql = @"CREATE TABLE IF NOT EXISTS Theme (version text,sub_version text, start_time text,end_time text,url text ,md5 text ,package_name text)";
    
    //在队列执行sql语句，一条sql语句执行完，另一条语句被执行（同时有两个sql语句，其中一条sql语句的执行排队）
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        //2executeUpdate 执行非查询语句
        BOOL isSu = [db executeUpdate:sql];
        if (isSu) {
            DZLog(@"%@",@"执行建主题表语句成功");
        }
        else{
            DZLog(@"%@",@"执行建主题表语句失败");
        }
    }];

}
-(void)insterInfo:(OtherThemeInfo *)info{
    //放在队列执行sql语句
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        //查询sql语句
        NSString *selectSql = @"select * from  Theme where version = ?";
        //执行查询sql语句
        FMResultSet *set =  [db executeQuery:selectSql,info.version];
        BOOL isExist ;
        isExist = NO;
        //next 指针指向下一条数据
        while ([set next]) {
            isExist = YES;
        }
        if (isExist == NO) {
            //这条数据不存在
            
            //1写插入的sql语句
            NSString *insertSQL =  @"INSERT INTO Theme (version ,sub_version, start_time ,end_time ,url  ,md5 ,package_name) VALUES(?,?,?,?,?,?,?)";
            //2执行sql语句
            BOOL isSucess =  [db executeUpdate:insertSQL,info.version,info.sub_version,info.start_time,info.end_time,info.url,info.md5,info.package_name];
            if (isSucess) {
                DZLog(@"%@",@"执行插入主题语句成功");
            }else{
                DZLog(@"%@",@"执行插入主题语句失败");
            }
        }
        
    }];

}
-(void)getAllThemeinfo:(GetAllObjectsBlock)block{
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        //1写查询语句
        NSString *selectSql = @"select * from Theme";
        //2执行查询语句获得结果集
        FMResultSet *rs  = [db executeQuery:selectSql];
        
        //存储模型的数组
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        //3next 一条一条的指向
        while ([rs next]) {
            OtherThemeInfo  *model = [[OtherThemeInfo alloc] init];
            model.version=[rs stringForColumn:@"version"];
            model.sub_version=[rs stringForColumn:@"sub_version"];
            model.start_time=[rs stringForColumn:@"start_time"];
            model.end_time=[rs stringForColumn:@"end_time"];
            model.url=[rs stringForColumn:@"url"];
            model.md5=[rs stringForColumn:@"md5"];
            model.package_name=[rs stringForColumn:@"package_name"];
            if ( [model.start_time intValue] <= [[kUserManager nowDate] intValue]<=[model.end_time intValue]) {
                kUserManager.nowUseThemeName=model.package_name;
                kUserManager.isUseOtherImage=YES;
                [tempArray addObject:model];
            }
        }
        block(tempArray);
        
    }];

}
@end
