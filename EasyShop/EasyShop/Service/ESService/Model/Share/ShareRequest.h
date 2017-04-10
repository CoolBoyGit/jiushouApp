//
//  ShareRequest.h
//  EasyShop
//
//  Created by guojian on 16/5/10.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"

/** 12.1、12.2 获取分享内容 */
@interface ShareFeedRequest : BaseRequest

//分页获取
/** 分页号 */
@property (nonatomic,strong) NSNumber *page;
/** 每页条数 */
@property (nonatomic,strong) NSNumber *n;

//获取一个分享内容
/** 分享id */
@property (nonatomic,copy) NSString *sid;

@end

/** 12.3、12.4 推送、转发一条消息 */
@interface SharePushRequest : BaseRequest

/** 方式（post:推送 ，repost: 转发，postimg为分享图片） */
@property (nonatomic,copy) NSString *type;
/** 主观内容 */
@property (nonatomic,copy) NSString *content;
/** 目标分享id */
@property (nonatomic,copy) NSString *repost_id;

//推送
/** 分享的分类 */
@property (nonatomic,copy) NSString *feed_class;

@end

/** 12.5 分页获取我关注的分享内容  */
@interface ShareMyFollowRequest : BaseRequest

/** 分页号 */
@property (nonatomic,strong) NSNumber *page;
/** 每页条数 */
@property (nonatomic,strong) NSNumber *n;

@end

/** 12.6 关注一个用户 */
@interface ShareFollowRequest : BaseRequest

/** 目标用户id */
@property (nonatomic,copy) NSString *uid;

@end

/** 12.7 喜欢+1 */
@interface ShareDigRequest : BaseRequest

/** 目标分享id */
@property (nonatomic,copy) NSString *feed_id;

@end

/** 12.8 喜欢-1 */
@interface ShareDedigRequest : BaseRequest

/** 目标分享id */
@property (nonatomic,copy) NSString *feed_id;

@end

/** 12.9 获取指定用户信息 */
@interface ShareUserInfoRequest : BaseRequest

/** 目标用户id */
@property (nonatomic,copy) NSString *uid;

@end

/** 新增分享接口基类 */
@interface ShareBaseRequest : BaseRequest

/** app = api */
@property (nonatomic,copy) NSString *app;
/** mod = jiushou */
@property (nonatomic,copy) NSString *mod;
/** act */
@property (nonatomic,copy) NSString *act;

@end

/** 获取指定分享用户信息 */
@interface ShareGetUserInfoRequest : ShareBaseRequest

/** 目标用户id（空则为：获取当前登录用户信息  GET方式） */
@property (nonatomic,copy) NSString *uid;

@end

/** 修改用户头像 */
@interface ShareUpdateAvatarRequest : ShareBaseRequest

/** step ：（upload ：上传头像（以表单格式上传  ；save ：保存头像）） */
@property (nonatomic,copy) NSString *step;

@end




