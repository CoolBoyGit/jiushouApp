//
//  ESWebSocket.m
//  TestWebSocket
//
//  Created by guojian on 16/5/20.
//  Copyright © 2016年 naijoug. All rights reserved.
//

#import "ESWebSocket.h"
#import "SRWebSocket.h"
#import "ESTypeResponse.h"

static NSString *const kESWebSocketUrl = @"http://www.jiushouguoji.com:7272";
static NSString *const kBroadcastOrder = @"BroadcastOrder";//广播消息
static NSString *const kPing = @"ping";

@interface ESWebSocket()<SRWebSocketDelegate>

/** webSocket */
@property (nonatomic,strong) SRWebSocket *webSocket;

@end

@implementation ESWebSocket

- (SRWebSocket *)webSocket
{
    if (!_webSocket) {
        _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kESWebSocketUrl]]];
        _webSocket.delegate = self;
    }
    return _webSocket;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Public

- (void)connect
{
    [self.webSocket open];
}

- (void)close
{
    self.webSocket.delegate = nil;
    [self.webSocket close];
    self.webSocket = nil;
}

#pragma mark - SRWebSocketDelegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSLog(@":( Websocket Failed With Error %@", error);
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    NSLog(@"Received \"%@\"", message);
    
    ESTypeResponse *response = [ESTypeResponse mj_objectWithKeyValues:message];
    
    if ([response.type isEqualToString:kBroadcastOrder]) {//接收到广播消息
        if (self.receiveBroadcastOrder) {
            BroadcastOrderInfo *info = [BroadcastOrderInfo mj_objectWithKeyValues:response.content];
            self.receiveBroadcastOrder(info);
        }
    }else if ([response.type isEqualToString:kPing]){//回复消息
        NSString *pong = @"{\"type\":\"pong\"}";
        [webSocket sendString:pong];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed");
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload;
{
    NSLog(@"Websocket received pong");
}


@end
