//
//  ESWebSocket.h
//  TestWebSocket
//
//  Created by guojian on 16/5/20.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BroadcastOrderInfo.h"


@interface ESWebSocket : NSObject

/** webSockt 连接 */
- (void)connect;
/** webSocket 关闭 */
- (void)close;


/** 接收到广播消息 */
@property (nonatomic,copy) void (^receiveBroadcastOrder)(BroadcastOrderInfo *info);

@end