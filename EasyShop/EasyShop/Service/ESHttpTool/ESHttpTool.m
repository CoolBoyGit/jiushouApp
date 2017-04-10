//
//  ESHttpTool.m
//  EasyShop
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <AFNetworking.h>
#import "EXTScope.h"

#import "ESHttpTool.h"

@implementation ESHttpTool
//上传图片 表单形式
+ (NSURLSessionTask *)postImageWithURL:(NSString *)url
                            imageItems:(NSArray *)imageItems
                                params:(NSDictionary *)params
                               success:(SuccessBlock)success
                               failure:(FailureBlock)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    @weakify(self);
    [self logTitle:@"请求session URL" url:url params:params];
    
    [self beginAnimation];
    return [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        int i = 0;
        for (UIImage *image in imageItems) {
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            
            [formData appendPartWithFileData:data
                                        name:[NSString stringWithFormat:@"file%d",i]
                                    fileName:[NSString stringWithFormat:@"photo%d.jpg",i]
                                    mimeType:@"image/jpeg"];
            DZLog(@"上传图片 file%d",i);
            i++;
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            @strongify(self);
            [self endAnimation];
            //答应返回数据
            NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            DZLog(@"返回数据 ： %@",response);
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @strongify(self);
        [self endAnimation];
        
        DZLog(@"error信息:%@\n",error);
        
        if (failure) {
            failure(error);
        }
    }];
}


+ (NSURLSessionDataTask *)postWithURL:(NSString *)url
                               params:(NSDictionary *)params
                              success:(SuccessBlock)success
                              failure:(FailureBlock)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //打印请求参数
    [self logTitle:@"请求session URL" url:url params:params];
    
    [self beginAnimation];
    
    @weakify(self);
    NSURLSessionDataTask *task = [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self);
        [self endAnimation];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @strongify(self);
        [self endAnimation];
        
        failure(error);
    }];
    
    return task;
}
+(void)downloadFileWithURL:(NSString*)requestURLString
                 request:(BaseRequest*)request
                  savedPath:(NSString*)savedPath
            downloadSuccess:(void (^)(NSURLResponse *response, NSURL *filePath))success
            downloadFailure:(void (^)(NSError *error))failure
           downloadProgress:(void (^)(NSProgress *downloadProgress))progress

{
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *newrequest =[serializer requestWithMethod:@"POST" URLString:requestURLString parameters:[request params] error:nil];
    NSURLSessionDownloadTask *task = [[AFHTTPSessionManager manager] downloadTaskWithRequest:newrequest progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:savedPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(error){
            failure(error);
        }else{
            success(response,filePath);
        }
    }];
    [task resume];
    
}
#pragma mark - Tool
/** 打开系统联网指示器 */
+ (void)beginAnimation
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
}
/** 关闭系统联网指示器 */
+ (void)endAnimation
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}

/** 打印请求url */
+ (void)logTitle:(NSString *)title url:(NSString *)url params:(NSDictionary *)params
{
    DZLog(@"%@:\n%@?%@\n^\n^\n^",title,url,[[NSString alloc] initWithData:[self bodyWithParams:params] encoding:NSUTF8StringEncoding]);
}

/**
 *  将请求参数转化为http请求参数
 */
+ (NSData *)bodyWithParams:(NSDictionary *)parmas
{
    __block NSString *body=@"";
    [parmas enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSArray class]])
        {
            NSArray *array=(NSArray *)obj;
            [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                body= [body stringByAppendingFormat:@"%@%@[]=%@",(body.length==0)?@"":@"&",key,obj];
            }];
        }
        else
        {
            body=[body stringByAppendingFormat:@"%@%@=%@",(body.length==0)?@"":@"&",key,obj];
        }
    }];
    return [body dataUsingEncoding:NSUTF8StringEncoding];
}

@end
