//
//  ESServiceMacro.h
//  EasyShop
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 wcz. All rights reserved.
//

#ifndef ESServiceMacro_h
#define ESServiceMacro_h

#define kESBaseUrl @"http://api.jiushouguoji.hk/app/"

#define kUser                       @"user"
#define KUserEasemobInfo            @"user/getEasemobInfo"
#define kUserAdd                    @"user/add"
#define kUserLogin                  @"user/login"
#define kUserEdit                   @"user/edit"
#define kUserLogout                 @"user/logout"
#define kUserBinding                @"user/userBinding"
#define kUserReset                  @"user/reset"
#define kUserDelFootprint           @"user/delFootprint"
#define KGetWeiXinOpenID           @"user/getWeiXinOpenID"
#define KGetTheme                   @"theme/getTheme/type/2"

#define kCommonGetVerify            @"Common/getVerify"
#define kCommonGetSmsVerify         @"Common/getSmsVerify"
#define kCommonGetDistrict          @"Common/getDistrict"
#define kCommonGetAnnouncement      @"Common/getAnnouncement"
#define kCommonGetShopInfo          @"Common/getShopInfo"
#define kCommonFileUpload           @"Common/fileUpload"
#define kCommonGetOrderTraces       @"Common/getOrderTraces"
#define kCommonGetExpress           @"Common/getExpress"

#define kAddress                    @"Address"
#define kAddressGetAddressList      @"Address/getAddressList"
#define kAddressDeleteAddress       @"Address/deleteAddress"
#define kAddressSetDefault          @"Address/setDefault"
#define kAddressAddAddress          @"Address/addAddress"
#define kAddressEditAddress         @"Address/editAddress"

#define kGoods                      @"Goods"
#define kGoodsGetNavList            @"Goods/getNavList"
#define kGoodsGetActivityList       @"Goods/getActivityList"
#define kGoodsGetActivityGoodsList  @"Goods/getActivityGoodsList"
#define kGoodsGetGoodsDetail        @"Goods/getGoodsDetail"
#define kGoodsGetRelatedGoods       @"Goods/getRelatedGoods"
#define kGoodsGetGoodsCategory      @"Goods/getGoodsCategory"
#define kGoodsGetGoodsEvaluation    @"Goods/getGoodsEvaluation"
#define kGoodsGetEvaluationInfo     @"Goods/getEvaluationInfo"
#define kGoodsSubGoodsList          @"Goods/subGoodsList"

#define kFavoritesGetFavoritesGoods         @"Favorites/getFavoritesGoods"
#define kFavoritesAddFavoritesGoods         @"Favorites/addFavoritesGoods"
#define kFavoritesCancelFavoritesGoods      @"Favorites/cancelFavoritesGoods"
#define kFavoritesAddFavoritesShop          @"Favorites/addFavoritesShop"
#define kFavoritesCancelFavoritesShop       @"Favorites/cancelFavoritesShop"
#define kFavoritesGetFavoritesShop          @"Favorites/getFavoritesShop"
#define kFavoritesGetFootprint              @"Favorites/getFootprint"

#define kEvaluate                           @"Evaluate"
#define kEvaluateAddEvaluation              @"Evaluate/addEvaluation"

#define kCart                       @"Cart"
#define kCartAddCartGoods           @"Cart/addCartGoods"
#define kCartEditCartGoods          @"Cart/editCartGoods"
#define kCartDeleteCartGoods        @"Cart/deleteCartGoods"
#define kCartGetCartInfo            @"Cart/getCartInfo"
#define kCartEditStatus             @"Cart/editStatus"

#define kOrder                      @"Order"
#define kOrderGetOrderDetail        @"Order/getOrderDetail"
#define kOrderConfirm               @"Order/orderConfirm"
#define kOrderCreateOrder           @"Order/createOrder"
#define kOrderCancelOrder           @"Order/cancelOrder"
#define kOrderComfirmOrder          @"Order/comfirmOrder"
#define kOrderGetReturnList         @"Order/getAfterSaleList"///获取退款的商品列表
#define kOrderApplyOrder            @"Order/applyOrder"
#define kOrderUpdateApply           @"Order/updateApply"
#define KAllOrderCount              @"order/getOrderInfo"
#define KRefundMoney               @"Order/getRefundDetail"//退款详情

#define kShareFeed                  @"share/feed"
#define kSharePush                  @"share/push"
#define kShareMyFollow              @"share/myfollow"
#define kShareFollow                @"share/follow"
#define kShareDig                   @"share/dig"
#define kShareDedig                 @"share/dedig"
#define kShareUserInfo              @"share/userInfo"

#define kPayGetPayMsg               @"pay/getPayMsg"//微信支付
#define kPaySelectCoupon            @"pay/selectCoupon"

#define kSearchGetSearchHotWord     @"search/getSearchHotWord"
#define kSearchAutoWordList         @"search/autoWordList"
#define kSearsh                     @"search"

#define kCoupon                     @"Coupon"
#define kCouponQueryCoupon          @"Coupon/queryCoupon"
#define kCouponGetCoupon            @"Coupon/getCoupon"
#define kCouponSelectCoupon         @"Coupon/SelectCoupon"
#define khOrderApplyOrder           @"Order/ApplyOrder"


#pragma mark - 分享特别接口
#define kShareBaseUrl               @"http://share.jiushouguoji.com/index.php"

#pragma mark 拼团相关接口

#define  KGetCluster                 @"Cluster/getCluster"//获取详情页拼团人数列表
#define  KgetClusterDetail           @"Cluster/getClusterDetail"//获取拼团的详细信息
#define  KCreateCluster              @"Cluster/createCluster"//创团支付
#define  KJoinCluster                @"Cluster/joinCluster"//这个参团支付
#define  KGetClusterList             @"Cluster/getClusterList"//获取个人中心的团购列表
#define  KgetClusterOrderDetail      @"Cluster/getClusterOrderDetail"//获取个人中心拼团订单详细信息
#define KGetSimpGoods                @"Goods/getSimpleGoods"//获取拼团支付页面的商品信息
#define KGetClusterCounpon           @"Coupon/selectClusterCoupon"// 接口描述:根据商品获取可用优惠券
#define KGetClusterGoods             @"Goods/getClusterGoods"

#endif /* ESServiceMacro_h */







