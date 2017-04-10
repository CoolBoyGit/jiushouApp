//
//  ShareTool.h
//  EasyShop
//
//  Created by guojian on 16/5/28.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ShareType) {
    ShareType_WexinTimeline,    //微信朋友圈
    ShareType_WexinSession,     //微信对话
};

@interface ShareTool : NSObject

+ (instancetype)shareTool;

- (void)shareWithType:(ShareType)type
                title:(NSString *)title
                  url:(NSString *)url
                image:(NSString *)image;

@end
