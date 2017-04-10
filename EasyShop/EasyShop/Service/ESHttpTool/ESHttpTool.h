//
//  ESHttpTool.h
//  EasyShop
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(id json);          //网络请求成功block,返回json串(字典)
typedef void (^FailureBlock)(NSError *error);   //网络请求失败block

@interface ESHttpTool : NSObject

/** 发送post请求，带有图片参数 */
+ (NSURLSessionTask *)postImageWithURL:(NSString *)url
                            imageItems:(NSArray *)imageItems
                                params:(NSDictionary *)params
                               success:(SuccessBlock)success
                               failure:(FailureBlock)failure;

/**
 *  发送post请求
 *
 *  @param url     请求URL
 *  @param params  请求参数
 *  @param success 请求成功返回
 *  @param failure 请求失败返回
 */
+ (NSURLSessionDataTask *)postWithURL:(NSString *)url
                               params:(NSDictionary *)params
                              success:(SuccessBlock)success
                              failure:(FailureBlock)failure;


+(void)downloadFileWithURL:(NSString*)requestURLString
                    request:(BaseRequest*)request
                  savedPath:(NSString*)savedPath
            downloadSuccess:(void (^)(NSURLResponse *response, NSURL *filePath))success
            downloadFailure:(void (^)(NSError *error))failure
           downloadProgress:(void (^)(NSProgress *downloadProgress))progress;
@end
