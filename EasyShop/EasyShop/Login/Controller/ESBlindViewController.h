//
//  ESBlindViewController.h
//  EasyShop
//
//  Created by wcz on 16/6/2.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ESBindType) {
    ESBindType_Wechat,
    ESBindType_QQ,
};

@interface ESBlindViewController : ESMyViewController

/** 绑定类型 */
@property (nonatomic,assign) ESBindType bindType;
/** 微信登录返回的code || QQ登录的open_id */
@property (nonatomic,copy) NSString *open_id;

@end
