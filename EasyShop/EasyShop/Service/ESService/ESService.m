//
//  ESService.m
//  EasyShopService
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "ESService.h"
#import <MJExtension.h>
#import "StatusResponse.h"
#import "ESServiceMacro.h"
#import "ESHttpTool.h"


typedef void (^SuccessBlock)(id json);          //网络请求成功block,返回json串(字典)

@implementation ESService


#pragma mark - ESService Post
/**
 *  返回请求url
 */
+ (NSString *)urlWithSuffix:(NSString *)suffix
{
    return [kESBaseUrl stringByAppendingString:suffix];
}

+ (NSURLSessionTask *)statusWithSuffix:(NSString *)suffix
                               request:(BaseRequest *)request
                               success:(SuccessBlock)success
                               faiulre:(FailureBlock)failure
{
    return [ESHttpTool postWithURL:[self urlWithSuffix:suffix] params:[request params] success:^(id json) {
        StatusResponse *response = [StatusResponse mj_objectWithKeyValues:json];
        if (response.status.intValue > 0) {//请求成功
            success(response.data);
        }else{//失败
            if (response.status.intValue == -1001) {//未登录
                kUserManager.isLogin = NO;
                [kUserManager doUserAutoLogin];
            }else{
                [ESToast showError:response.message];
            }
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/** 需要上传图片的接口使用 */
+ (NSURLSessionTask *)statusImageWithSuffix:(NSString *)suffix
                                    request:(BaseRequest *)request
                                 imageItems:(NSArray *)imageItems
                                    success:(SuccessBlock)success
                                    faiulre:(FailureBlock)failure
{
    return [ESHttpTool postImageWithURL:[self urlWithSuffix:suffix] imageItems:imageItems params:[request params] success:^(id json) {
        
        StatusResponse *response = [StatusResponse mj_objectWithKeyValues:json];
        
        if (response.status.intValue > 0) {//请求成功
            success(response.data);
        }else{//失败
            if (response.status.intValue == -1001) {//未登录
                [kUserManager doUserAutoLogin];//后台自动登录
            }else{
                [ESToast showError:response.message];
            }
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**下载文件接口使用**/
+ (void)statusImageWithSuffix:(NSString *)suffix
                      request:(BaseRequest *)request
                      success:(OkBlock)success
                      faiulre:(FailureBlock)failure{
    
    
    
}
@end

#pragma mark - 4 - 用户管理
@implementation ESService (User)

#pragma mark 4.1 获取当前已登录用户的个人资料
+ (NSURLSessionTask *)userRequest:(UserRequest *)request
                          success:(void (^)(UserInfo *))success
                          failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kUser request:request success:^(id json) {
        UserInfo *response = [UserInfo mj_objectWithKeyValues:json];
        
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

//获取环信接口的密码
+ (NSURLSessionTask *)getEaseMobInfo:(BaseRequest *)request
                             success:(void (^)(EombaseInfo *response))success
                             failure:(FailureBlock)failure
{
    return [self statusWithSuffix:KUserEasemobInfo request:request success:^(id json) {
        EombaseInfo *response = [EombaseInfo mj_objectWithKeyValues:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 4.2 用户注册
+ (NSURLSessionTask *)userAddRequest:(UserAddRequest *)request
                             success:(void (^)(NSString *))success
                             failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kUserAdd request:request success:^(id json) {
        
        success(json);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 4.3 用户登录
+ (NSURLSessionTask *)userLoginRequest:(UserLoginRequest *)request
                               success:(void (^)(LoginInfo *))success
                               failure:(FailureBlock)failure
{
    return [ESHttpTool postWithURL:[self urlWithSuffix:kUserLogin] params:[request params] success:^(id json) {
        StatusResponse *response = [StatusResponse mj_objectWithKeyValues:json];
        
        if (response.status.intValue > 0) {//请求成功
            id keyvalues = response.data;
            LoginInfo *loginInfo = [LoginInfo mj_objectWithKeyValues:keyvalues];
            loginInfo.status = response.status;
            success(loginInfo);
        }else if (response.status.intValue == -3){
            LoginInfo *loginInfo = [[LoginInfo alloc] init];
            loginInfo.status = response.status;
            success(loginInfo);
        }else{//失败
            if (response.status.intValue == -1001) {//未登录
                kUserManager.isLogin = NO;
                [kUserManager doUserAutoLogin];
            }else{
                [ESToast showError:response.message];
            }
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark 4.4 编辑用户资料
+ (NSURLSessionTask *)userEditRequest:(UserEditRequest *)request
                              success:(OkBlock)success
                              failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kUserEdit request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 4.5 用户退出登录
+ (NSURLSessionTask *)userLogoutRequest:(UserLogoutRequest *)request
                                success:(OkBlock)success
                                failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kUserLogout request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 4.6 绑定第三方
+ (NSURLSessionTask *)userBindingRequest:(UserBindingRequest *)request
                                 success:(OkBlock)success
                                 failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kUserBinding request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 4.7 重置用户密码
+ (NSURLSessionTask *)userResetRequest:(UserResetRequest *)request
                               success:(OkBlock)success
                               failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kUserReset request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark  4.8 删除用户足迹
+ (NSURLSessionTask *)delFootprintRequest:(DelFootprintRequest *)request
                                  success:(OkBlock)success
                                  failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kUserDelFootprint request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark 4.9 获取用户的微信登录的OPId
+ (NSURLSessionTask *)getWeiXinOpenIdRequest:(GetWeiXinOpenIdRequest *)request
                                     success:(void(^)(WeiXinOpenIdInfo* info))success
                                     failure:(FailureBlock)failure{

    return [self statusWithSuffix:KGetWeiXinOpenID request:request success:^(id json) {
        WeiXinOpenIdInfo*info=[WeiXinOpenIdInfo mj_objectWithKeyValues:json];
        success(info);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];

}
@end

#pragma mark - 5 - 通用接口
@implementation ESService (Common)

#pragma mark 5.1 获取验证码
+ (NSURLSessionTask *)getVerifyRequest:(GetVerifyRequest *)request
                               success:(void (^)(NSData *))success
                               failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCommonGetVerify request:request success:^(id json) {
        
        success(json);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 5.2 获取短信验证码
+ (NSURLSessionTask *)getSmsVerifyRequest:(GetSmsVerifyRequest *)request
                                  success:(OkBlock)success
                                  failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCommonGetSmsVerify request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 5.3 获取地区和地区代号
+ (NSURLSessionTask *)getDistrictRequest:(GetDistrictRequest *)request
                                 success:(ArrayBlock)success
                                 failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCommonGetDistrict request:request success:^(id json) {
        
        NSArray *response = [DistrictInfo mj_objectArrayWithKeyValuesArray:json];
        
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 5.4 获取公告
+ (NSURLSessionTask *)getAnnouncementRequest:(GetAnnouncementRequest *)request
                                     success:(ArrayBlock)success
                                     failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCommonGetAnnouncement request:request success:^(id json) {
        
        NSArray *response = [AnnouncementInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 5.5 获取店铺信息
+ (NSURLSessionTask *)getShopInfoRequest:(GetShopInfoRequest *)request
                                 success:(void (^)(ShopInfo *))success
                                 failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCommonGetShopInfo request:request success:^(id json) {
        
        ShopInfo *response = [ShopInfo mj_objectWithKeyValues:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 5.6 图片上传（'jpg', 'gif', 'png', 'jpeg'）
+ (NSURLSessionTask *)fileUploadRequest:(FileUploadRequest *)request
                                success:(void (^)(NSArray *))success
                                failure:(FailureBlock)failure
{
    return [self statusImageWithSuffix:kCommonFileUpload request:request imageItems:request.imageItems success:^(id json) {
        
        success(json);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}



#pragma mark 5.8 获取物流信息追踪
+ (NSURLSessionTask *)getOrderTracesRequest:(GetOrderTracesRequest *)request
                                    success:(void (^)(OrderTracesInfo *))success
                                    failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCommonGetOrderTraces request:request success:^(id json) {
        
        OrderTracesInfo *response = [OrderTracesInfo mj_objectWithKeyValues:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark  5.9 获取物流公司信息

+ (NSURLSessionTask *)getExpressRequest:(GetExpressRequest *)request
                                success:(ArrayBlock)success
                                failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCommonGetExpress request:request success:^(id json) {
        
        NSArray *response = [ExpressInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}
+(NSURLSessionTask*)getIsNeeddownloadThemeZipRequest:(BaseRequest *)request success:(ArrayBlock)success failure:(FailureBlock)failure{
    
  return [self statusWithSuffix:KGetTheme request:request success:^(id json) {
      NSArray*responeArray=[OtherThemeInfo mj_objectArrayWithKeyValuesArray:json];
      success(responeArray);
    } faiulre:^(NSError *error) {
        
    }];
}
@end

#pragma mark - 6 - 用户收货地址管理
@implementation ESService (Address)

#pragma mark 6.1 获取用户默认地址或指定id地址
+ (NSURLSessionTask *)addressRequest:(AddressRequest *)request
                             success:(void (^)(AddressInfo *))success
                             failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kAddress request:request success:^(id json) {
        
        AddressInfo *response = [AddressInfo mj_objectWithKeyValues:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 6.2 获取用户地址列表
+ (NSURLSessionTask *)getAddressListRequest:(GetAddressListRequest *)request
                                    success:(ArrayBlock)success
                                    failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kAddressGetAddressList request:request success:^(id json) {
        
        NSArray *response = [AddressInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 6.3 删除指定id地址
+ (NSURLSessionTask *)deleteAddressRequest:(DeleteAddressRequest *)request
                                   success:(OkBlock)success
                                   failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kAddressDeleteAddress request:request success:^(id json) {
       
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 6.4 设置指定id地址为默认地址
+ (NSURLSessionTask *)setDefaultRequest:(SetDefaultRequest *)request
                                success:(OkBlock)success
                                failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kAddressSetDefault request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 6.5 新增用户收货地址
+ (NSURLSessionTask *)addAddressRequest:(AddAddressRequest *)request
                                success:(void (^)(StatusResponse *respone))success
                                failure:(FailureBlock)failure
{
   return [ESHttpTool postWithURL:[self urlWithSuffix:kAddressAddAddress] params:[request params] success:^(id json) {
       
       StatusResponse *response = [StatusResponse mj_objectWithKeyValues:json];
       success(response);
   } failure:^(NSError *error) {
       
       
   }];
    //    return [self statusWithSuffix:kAddressAddAddress request:request success:^(id json) {
//        
//        success();
//        
//    } faiulre:^(NSError *error) {
//        failure(error);
//    }];
}

#pragma mark 6.6 编辑用户收货地址
+ (NSURLSessionTask *)editAddressRequest:(EditAddressRequest *)request
                                 success:(void (^)(AddressInfo *respone))success
                                 failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kAddressEditAddress request:request success:^(id json) {
        AddressInfo*info=[AddressInfo mj_objectWithKeyValues:json];
        success(info);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

@end

#pragma mark - 7 - 商品相关
@implementation ESService (Goods)

#pragma mark 7.1 获取商品列表
+ (NSURLSessionTask *)goodsRequest:(GoodsRequest *)request
                           success:(ArrayBlock)success
                           failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kGoods request:request success:^(id json) {
        
        NSArray *response = [GoodsInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 7.2 获取商品导航分类列表
+ (NSURLSessionTask *)getNavListRequest:(GetNavListRequest *)request
                                success:(ArrayBlock)success
                                failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kGoodsGetNavList request:request success:^(id json) {
        
        NSArray *response = [NavInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 7.3 获取分类下的每个活动专场
+ (NSURLSessionTask *)getActivityListRequest:(GetActivityListRequest *)request
                                     success:(ArrayBlock)success
                                     failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kGoodsGetActivityList request:request success:^(id json) {
        
        NSArray *response = [ActivityInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 7.4 获取活动专场下的商品列表
+ (NSURLSessionTask *)getActivityGoodsListRequest:(GetActivityGoodsListRequest *)request
                                          success:(ArrayBlock)success
                                          failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kGoodsGetActivityGoodsList request:request success:^(id json) {
        
        NSArray *response = [GoodsInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 7.5 获取商品详情
+ (NSURLSessionTask *)getGoodsDetailRequest:(GetGoodsDetailRequest *)request
                                    success:(void (^)(GoodsDetailInfo *))success
                                    failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kGoodsGetGoodsDetail request:request success:^(id json) {
        
        GoodsDetailInfo *response = [GoodsDetailInfo mj_objectWithKeyValues:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 7.6 获取推荐商品列表
+ (NSURLSessionTask *)getRelatedGoodsRequest:(GetRelatedGoodsRequest *)request
                                     success:(ArrayBlock)success
                                     failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kGoodsGetRelatedGoods request:request success:^(id json) {
        
        NSArray *response = [GoodsInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 7.7 获取商品分类信息
+ (NSURLSessionTask *)getGoodsCategoryRequest:(GetGoodsCategoryRequest *)request
                                      success:(ArrayBlock)success
                                      failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kGoodsGetGoodsCategory request:request success:^(id json) {
        
        NSArray *response = [GoodsCategoryInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 7.8 获取商品评论
+ (NSURLSessionTask *)getGoodsEvaluationRequest:(GetGoodsEvaluationRequest *)request
                                        success:(ArrayBlock)success
                                        failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kGoodsGetGoodsEvaluation request:request success:^(id json) {
        
        NSArray *response = [GoodsEvaluationInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 7.9 获取商品评论信息统计
+ (NSURLSessionTask *)getEvaluationInfoRequest:(GetEvaluationInfoRequest *)request
                                       success:(void (^)(EvaluationInfo *))success
                                       failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kGoodsGetEvaluationInfo request:request success:^(id json) {
        
        EvaluationInfo *response = [EvaluationInfo mj_objectWithKeyValues:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 7.10 获取导航商品列表
+ (NSURLSessionTask *)subGoodsListRequest:(SubGoodsListRequest *)request
                                  success:(ArrayBlock)success
                                  failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kGoodsSubGoodsList request:request success:^(id json) {
        
        NSArray *response = [GoodsInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 7.10 抢购
+ (NSURLSessionTask *)panicRequestWithSuccess:(void (^)(PanicInfo *))success failure:(FailureBlock)failure
{
    SubGoodsListRequest *request = [SubGoodsListRequest request];
    request.type = @2;
    
    return [self statusWithSuffix:kGoodsSubGoodsList request:request success:^(id json) {
        
        PanicInfo *response = [PanicInfo mj_objectWithKeyValues:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

@end

#pragma mark - 8 - 用户关注
@implementation ESService (Favorites)

#pragma mark 8.1 获取用户关注商品
+ (NSURLSessionTask *)getFavoritesGoodsRequest:(GetFavoritesGoodsRequest *)request
                                       success:(ArrayBlock)success
                                       failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kFavoritesGetFavoritesGoods request:request success:^(id json) {
        
        NSArray *response = [FavoritesGoodsInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 8.2 添加用户关注商品
+ (NSURLSessionTask *)addFavoritesGoodsRequest:(AddFavoritesGoodsRequest *)request
                                       success:(OkBlock)success
                                       failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kFavoritesAddFavoritesGoods request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 8.3 取消用户关注商品
+ (NSURLSessionTask *)cancelFavoritesGoodsRequest:(CancelFavoritesGoodsRequest *)request
                                          success:(OkBlock)success
                                          failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kFavoritesCancelFavoritesGoods request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 8.4 收藏店铺
+ (NSURLSessionTask *)addFavoritesShopRequest:(AddFavoritesShopRequest *)request
                                      success:(OkBlock)success
                                      failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kFavoritesAddFavoritesShop request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 8.5 取消收藏店铺
+ (NSURLSessionTask *)cancelFavoritesShopRequest:(CancelFavoritesShopRequest *)request
                                         success:(OkBlock)success
                                         failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kFavoritesCancelFavoritesShop request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 8.6 获取用户关注店铺列表
+ (NSURLSessionTask *)getFavoritesShopRequest:(GetFavoritesShopRequest *)request
                                      success:(ArrayBlock)success
                                      failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kFavoritesGetFavoritesShop request:request success:^(id json) {
        
        NSArray *response = [FavoritesShopInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 8.7 获取当前用户足迹
+ (NSURLSessionTask *)getFootprintRequest:(GetFootprintRequest *)request
                                  success:(ArrayBlock)success
                                  failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kFavoritesGetFootprint request:request success:^(id json) {
        
        NSArray *response = [FootprintInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

@end

#pragma mark - 9 - 商品评价

@implementation ESService (Evaluate)

#pragma mark 9.1 获取个人待评价商品
+ (NSURLSessionTask *)evaluateRequest:(EvaluateRequest *)request
                              success:(ArrayBlock)success
                              failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kEvaluate request:request success:^(id json) {
        
        NSArray *response = [EvaluateGoodsInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 9.2 增加商品评价
+ (NSURLSessionTask *)addEvaluationRequest:(AddEvaluationRequest *)request
                                   success:(OkBlock)success
                                   failure:(FailureBlock)failure
{
//    NSString *str = [request params].mj_JSONString;
//    NSLog(@"评论字符串  : %@",str);
    return [self statusWithSuffix:kEvaluateAddEvaluation request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
    
}

@end

#pragma mark - 10 - 购物车
@implementation ESService (Cart)

#pragma mark 10.1 查询购物车商品（需要登录）
+ (NSURLSessionTask *)cartRequest:(CartRequest *)request
                          success:(void (^)(CartInfo *))success
                          failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCart request:request success:^(id json) {
        CartInfo *response = [[CartInfo alloc] init];
        NSMutableArray *mArr = [NSMutableArray array];
        if ([json isKindOfClass:[NSDictionary class]]) {
            for (NSString *key in ((NSDictionary *)json).allKeys) {
                if ([key isEqualToString:@"cartInfo"]) {//购物车统计信息
                    response.cartInfo = [CartSumInfo mj_objectWithKeyValues:[json objectForKey:key]];
                }else{
                    CartShopInfo *info  = [[CartShopInfo alloc] init];
                    info.shop_id    = key;
                    info.goodsItems = [CartGoodsInfo mj_objectArrayWithKeyValuesArray:[json objectForKey:key]];
                    [mArr addObject:info];
                }
            }
        }
        response.shopsItems = [mArr copy];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark 10.2 往购物车添加商品（需要登录）
+ (NSURLSessionTask *)addCartGoodsRequest:(AddCartGoodsRequest *)request
                                  success:(OkBlock)success
                                  failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCartAddCartGoods request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 10.3 编辑购物车商品（需要登录）
+ (NSURLSessionTask *)editCartGoodsRequest:(EditCartGoodsRequest *)request
                                   success:(OkBlock)success
                                   failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCartEditCartGoods request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 10.4 删除购物车商品（需要登录）
+ (NSURLSessionTask *)deleteCartGoodsRequest:(DeleteCartGoodsRequest *)request
                                     success:(OkBlock)success
                                     failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCartDeleteCartGoods request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark  10.5 统计购物车中商品件数和总价（不包括运费）（需要登录）
+ (NSURLSessionTask *)getCartInfoRequest:(GetCartInfoRequest *)request
                                 success:(void (^)(CartPriceInfo* response))success
                                 failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCartGetCartInfo request:request success:^(id json) {
        
        CartPriceInfo *response = [CartPriceInfo mj_objectWithKeyValues:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark  10.6 更新购物车中商品要结算的状态（需要登录）
+ (NSURLSessionTask *)editStatusRequest:(EditStatusRequest *)request
                                success:(OkBlock)success
                                failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCartEditStatus request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}


@end

#pragma mark - 11 - 订单处理
@implementation ESService (Order)

#pragma mark 11.1 获取订单（需要登录）
+ (NSURLSessionTask *)orderRequest:(OrderRequest *)request
                           success:(ArrayBlock)success
                           failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kOrder request:request success:^(id json) {
        
        NSArray *response = [OrderInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 11.2 获取订单详细信息（需要登录）
+ (NSURLSessionTask *)getOrderDetailRequest:(GetOrderDetailRequest *)request
                                    success:(void (^)(OrderDetailInfo *response))success
                                    failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kOrderGetOrderDetail request:request success:^(id json) {
        
        OrderDetailInfo *response = [OrderDetailInfo mj_objectWithKeyValues:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 11.3 确认订单（需要登录）
+ (NSURLSessionTask *)orderConfirmRequest:(OrderConfirmRequest *)request
                                  success:(void (^)(OrderConfirmInfo *))success
                             stockFailure:(void (^)(NSMutableArray*array))stockFailure
                                  failure:(FailureBlock)failure
{
    return [ESHttpTool postWithURL:[self urlWithSuffix:kOrderConfirm] params:[request params] success:^(id json) {
        StatusResponse *response = [StatusResponse mj_objectWithKeyValues:json];
        
        if (response.status.intValue > 0) {//请求成功
            OrderConfirmInfo *res  = [[OrderConfirmInfo alloc] init];
            NSMutableArray *mArr        = [NSMutableArray array];
            if ([response.data isKindOfClass:[NSDictionary class]]) {
                for (NSString *key in ((NSDictionary *)response.data).allKeys) {
                    NSArray *arr        = [response.data objectForKey:key];
                    for (NSString *shop in arr) {
                        OrderConfirmShopInfo *shopInfo = [OrderConfirmShopInfo mj_objectWithKeyValues:shop];
                        [mArr addObject:shopInfo];
                    }
                }
            }
            res.shops              = [mArr copy];
            success(res);
        }else{//失败
            if (response.status.intValue == -1001) {//未登录
                kUserManager.isLogin = NO;
                [kUserManager doUserAutoLogin];
            }else if (response.status.integerValue == -1){//库存不足
                NSMutableArray*arr=[[NSMutableArray alloc]init];
                
                for (NSString*string in response.data) {
                    GoodsStockMessageInfo*info=[GoodsStockMessageInfo mj_objectWithKeyValues:string];
                    [arr addObject:info];
                }
                
                stockFailure(arr);
                
            }else{
                [ESToast showError:response.message];
            }
            failure(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    return [self statusWithSuffix:kOrderConfirm request:request success:^(id json) {
        
        
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 11.4 生成订单（需要登录）
+ (NSURLSessionTask *)createOrderRequest:(CreateOrderRequest *)request
                                 success:(void (^)(ShopInfoStatusNeedPesonid* response))success
                                 failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kOrderCreateOrder request:request success:^(id json) {
        ShopInfoStatusNeedPesonid*respone=[ShopInfoStatusNeedPesonid mj_objectWithKeyValues:json]
        ;
        success(respone);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}


#pragma mark 11.5 取消订单（需要登录）
+ (NSURLSessionTask *)cancelOrderRequest:(CancelOrderRequest *)request
                                 success:(OkBlock)success
                                 failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kOrderCancelOrder request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 11.6 确认收货（需要登录）
+ (NSURLSessionTask *)comfirmOrderRequest:(ComfirmOrderRequest *)request
                                  success:(OkBlock)success
                                  failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kOrderComfirmOrder request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 11.7 查询退款/退货订单（需要登录）
+ (NSURLSessionTask *)getReturnListRequest:(GetReturnListRequest *)request
                                   success:(ArrayBlock)success
                                   failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kOrderGetReturnList request:request success:^(id json) {
        
        NSArray *response = [OrderInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 11.8 申请退款（需要登录）
+ (NSURLSessionTask *)applyOrderRequest:(ApplyOrderRequest *)request
                                success:(OkBlock)success
                                failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kOrderApplyOrder request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 11.9 更新物流信息（需要登录）
+ (NSURLSessionTask *)updateApplyRequest:(UpdateApplyRequest *)request
                                 success:(OkBlock)success
                                 failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kOrderUpdateApply request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark 11.0 获取所有的订单的数量 用来跟新待收获数字
+(NSURLSessionTask *)GetAllOrderCountRequest:(GetAllOrderCount *)request success:(void(^)(AllOrderCount *count))success failure:(FailureBlock)failure{
    
   return  [self statusWithSuffix:KAllOrderCount request:request success:^(id json) {
       AllOrderCount*count=[AllOrderCount mj_objectWithKeyValues:json];
       success(count);
       
    } faiulre:^(NSError *error) {
        
    }];
}
+(NSURLSessionTask*)GetRefundResultRequest:(GetRefundResultRequest *)request success:(void (^)(RefundResultRespone *))success failure:(FailureBlock)failure{
    return [self statusWithSuffix:KRefundMoney request:request success:^(id json) {
        RefundResultRespone*respone=[RefundResultRespone mj_objectWithKeyValues:json];
        success(respone);
        
    } faiulre:^(NSError *error) {
        
    }];
}
@end


#pragma mark - 12 - 分享

@implementation ESService (Share)

#pragma mark 12.1、12.2 获取分享内容
+ (NSURLSessionTask *)shareFeedRequest:(ShareFeedRequest *)request
                               success:(ArrayBlock)success
                               failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kShareFeed request:request success:^(id json) {
        
        NSArray *response = [ShareFeedInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 12.3、12.4 推送、转发一条消息
+ (NSURLSessionTask *)sharePushRequest:(SharePushRequest *)request
                               success:(OkBlock)success
                               failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kSharePush request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 12.5 分页获取我关注的分享内容
+ (NSURLSessionTask *)shareMyFollowRequest:(ShareMyFollowRequest *)request
                                   success:(ArrayBlock)success
                                   failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kShareMyFollow request:request success:^(id json) {
        
        NSArray *response = [ShareFeedInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 12.6 关注一个用户
+ (NSURLSessionTask *)shareFollowRequest:(ShareFollowRequest *)request
                                 success:(OkBlock)success
                                 failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kShareFollow request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 12.7 喜欢+1
+ (NSURLSessionTask *)shareDigRequest:(ShareDigRequest *)request
                              success:(OkBlock)success
                              failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kShareDig request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 12.8 喜欢-1
+ (NSURLSessionTask *)shareDedigRequest:(ShareDedigRequest *)request
                                success:(OkBlock)success
                                failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kShareDedig request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark  12.9 获取指定用户信息
+ (NSURLSessionTask *)shareUserInfoRequest:(ShareUserInfoRequest *)request
                                   success:(ArrayBlock)success
                                   failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kShareUserInfo request:request success:^(id json) {
        
        NSArray *response = [ShareUserInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

@end

#pragma mark - 13 - 支付接口
@implementation ESService (Pay)

#pragma mark  13.1 获取微信支付信息
+ (NSURLSessionTask *)getWeixinPayMsgRequest:(GetPayMsgRequest *)request
                                     success:(void (^)(WeixinPayAllInfo *response))success
                                     failure:(FailureBlock)failure
{
    request.channel = @2;
    return [self statusWithSuffix:kPayGetPayMsg request:request success:^(id json) {
        
        WeixinPayAllInfo *response = [WeixinPayAllInfo mj_objectWithKeyValues:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark  13.2 获取支付宝支付信息
+ (NSURLSessionTask *)getAliPayMsgRequest:(GetPayMsgRequest *)request
                                  success:(void (^)(NSString *))success
                                  failure:(FailureBlock)failure
{
    request.channel = @1;
    return [self statusWithSuffix:kPayGetPayMsg request:request success:^(id json) {
        
        success(json);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 13.3 获取通联支付信息
+ (NSURLSessionTask *)getAllInPayMsgRequest:(GetPayMsgRequest *)request
                                    success:(void (^)(NSString *response))success
                                    failure:(FailureBlock)failure
{
    request.channel = @3;//通联支付
    return [self statusWithSuffix:kPayGetPayMsg request:request success:^(id json) {
        
        success([json mj_JSONString]);
        NSLog(@"%@",[json mj_JSONString]);
        // success(json);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}


@end


#pragma mark - 15 - 搜索接口
@implementation ESService (Search)

#pragma mark 15.1 热门关键字
+ (NSURLSessionTask *)getSearchHotWordRequest:(GetSearchHotWordRequest *)request
                                      success:(ArrayBlock)success
                                      failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kSearchGetSearchHotWord request:request success:^(id json) {
        
        NSArray *response = [KeyWord mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 15.2 自动完成关键字
+ (NSURLSessionTask *)autoWordListRequest:(AutoWordListRequest *)request
                                  success:(ArrayBlock)success
                                  failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kSearchAutoWordList request:request success:^(id json) {
        
        NSArray *response = [KeyWord mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 15.3 搜索接口
+ (NSURLSessionTask *)searchRequest:(SearchRequest *)request
                            success:(ArrayBlock)success
                            failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kSearsh request:request success:^(id json) {
        
        NSArray *response = [GoodsInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

@end

#pragma mark - 16 - 优惠券接口
@implementation ESService (Coupon)

#pragma mark 16.1 查询用户个人中心优惠券
+ (NSURLSessionTask *)couponRequest:(CouponRequest *)request
                            success:(ArrayBlock)success
                            failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCoupon request:request success:^(id json) {
        
        NSArray *response = [CouponInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 16.2 查询用户可以领取的优惠券
+ (NSURLSessionTask *)queryCouponRequest:(QueryCouponRequest *)request
                                 success:(ArrayBlock)success
                                 failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCouponQueryCoupon request:request success:^(id json) {
        
        NSArray *response = [GetCouponInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark 16.3 获取优惠券
+ (NSURLSessionTask *)getCouponRequest:(GetCouponRequest *)request
                               success:(OkBlock)success
                               failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCouponGetCoupon request:request success:^(id json) {
        
        success();
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark  16.4 获取某个订单可以用到的优惠券
+ (NSURLSessionTask *)selectCouponRequest:(SelectCouponRequest *)request
                                  success:(ArrayBlock)success
                                  failure:(FailureBlock)failure
{
    return [self statusWithSuffix:kCouponSelectCoupon request:request success:^(id json) {
        
        NSArray *response = [CouponInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];
}


@end
#pragma mark 拼团接口类
@implementation ESService (Cluster)
/**
 *  17.1 获取商品详情页拼团列表
 */
+ (NSURLSessionTask *)getClusterRequest:(ClusterRequest *)request
                                success:(ArrayBlock)success
                                failure:(FailureBlock)failure{
    return[self statusWithSuffix:KGetCluster request:request success:^(id json) {
        
        NSArray*array=[ClusterRespone mj_objectArrayWithKeyValuesArray:json];
        success(array);
    } faiulre:^(NSError *error) {
        failure(error);

    }];
    
    
}
/**
 *  17.2 获取商品拼团的详细信息
 */
+ (NSURLSessionTask *)getClusterDetailRequest:(GetClusterDetailRequest *)request
                                      success:(void (^)(GetClusterDetailRespone *response))success
                                      failure:(FailureBlock)failure{
    return[self statusWithSuffix:KgetClusterDetail request:request success:^(id json) {
        
        GetClusterDetailRespone*respone=[GetClusterDetailRespone mj_objectWithKeyValues:json];
        success(respone);
        
    } faiulre:^(NSError *error) {
        failure(error);

    }];
    

}

/**
 *  17.3 创团
 */


/**
 *  17.4 参团
 */

+ (NSURLSessionTask *)joinClusterRequest:(JoinClusterRequest *)request
                                 success:(void (^)(NSString *response))success
                                 failure:(FailureBlock)failure;
{
    return[self statusWithSuffix:KJoinCluster request:request success:^(id json) {
        success(json);
        
    } faiulre:^(NSError *error) {
        failure(error);

    }];
    

}
+(NSURLSessionTask*)createClusterRequest:(CreateClusterRequest *)request success:(void (^)(NSString *))success failure:(FailureBlock)failure{
    return [self statusWithSuffix:KCreateCluster request:request success:^(id json) {
        
        success(json);
        
    } faiulre:^(NSError *error) {
        
    }];
    
}


+(NSURLSessionTask*)joinWeixinClusterRequest:(JoinClusterRequest *)request success:(void (^)(WeixinPayAllInfo *))success failure:(FailureBlock)failure{
    
        return [self statusWithSuffix:KJoinCluster request:request success:^(id json) {
    
            WeixinPayAllInfo *response = [WeixinPayAllInfo mj_objectWithKeyValues:json];
            success(response);
    
        } faiulre:^(NSError *error) {
            failure(error);
        }];
}
+(NSURLSessionTask*)createWeixinClusterRequest:(CreateClusterRequest *)request success:(void (^)(WeixinPayAllInfo *))success failure:(FailureBlock)failure{
    return [self statusWithSuffix:KCreateCluster request:request success:^(id json) {
        
        WeixinPayAllInfo *response = [WeixinPayAllInfo mj_objectWithKeyValues:json];
        success(response);
        
    } faiulre:^(NSError *error) {
        failure(error);
    }];

}
/**
 *  17.5获取个人中心的团购列表数据
 */
+ (NSURLSessionTask *)getClusterListRequest:(GetClusterListRequest *)request
                                    success:(ArrayBlock)success
                                    failure:(FailureBlock)failure;
{
    return[self statusWithSuffix:KGetClusterList request:request success:^(id json) {
        
        NSArray*array=[ GetClusterListRespone mj_objectArrayWithKeyValuesArray:json];
        success(array);
    } faiulre:^(NSError *error) {
        failure(error);

    }];
    

}
/**
 *  17.6 获取个人中心拼团订单详细信息
 */

+ (NSURLSessionTask *)getClusterOrderDetailRequest:(GetClusterOrderDetailRequest *)request
                                           success:(void (^) (GetClusterOrderDetailRespone *respone))success
                                           failure:(FailureBlock)failure;
{
    return[self statusWithSuffix:KgetClusterOrderDetail request:request success:^(id json) {
        GetClusterOrderDetailRespone*respone=[GetClusterOrderDetailRespone mj_objectWithKeyValues:json];
        
        
        success(respone);
        
    } faiulre:^(NSError *error) {
        failure(error);

    }];
    

}
/**
 *  17.7 获取个人的商品信息
 */
+(NSURLSessionTask *)getClusterSimpleGoodsRequest:(GetSimpGoodsRequest *)request success:(void (^)(GetSimpGoodsRespone *))success failure:(FailureBlock)failure{

     return [self statusWithSuffix:KGetSimpGoods request:request success:^(id json) {
         GetSimpGoodsRespone*respone=[GetSimpGoodsRespone mj_objectWithKeyValues:json];
         success(respone);
         
         
     } faiulre:^(NSError *error) {
         
     }];

}
+(NSURLSessionTask *)GetclusterCouponRequest:(GetclusterCouponRequest *)request success:(ArrayBlock)success failure:(FailureBlock)failure{
    
    return [self statusWithSuffix:KGetClusterCounpon request:request success:^(id json) {
        NSArray *response = [CouponInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
        
    } faiulre:^(NSError *error) {
        
    }];
}
+(NSURLSessionTask *)GetClusterGoodsRequest:(GetClusterGoodsRequest *)request success:(ArrayBlock)success failure:(FailureBlock)failure{
    
    return [self statusWithSuffix:KGetClusterGoods request:request success:^(id json) {
        NSArray *response = [GoodsInfo mj_objectArrayWithKeyValuesArray:json];
        success(response);
        
        
    } faiulre:^(NSError *error) {
        
    }];

    
}
@end

