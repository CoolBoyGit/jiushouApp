//
//  ShareTool.m
//  EasyShop
//
//  Created by guojian on 16/5/28.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ShareTool.h"
#import "WXApi.h"

@implementation ShareTool

+ (instancetype)shareTool
{
    static ShareTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    return tool;
}

- (void)shareWithType:(ShareType)type title:(NSString *)title url:(NSString *)url image:(NSString *)image
{
    WXWebpageObject *webObj = [WXWebpageObject object];
     webObj.webpageUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    webObj.webpageUrl=url;
   
    WXMediaMessage *message = [WXMediaMessage message];
    message.title       = title;
    message.description = title;
    message.mediaObject = webObj;
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:image]];
    NSData*newdata= UIImageJPEGRepresentation([UIImage imageWithData:data], 0.2);
    [message setThumbImage:[[UIImage alloc] initWithData:newdata]];
    
    SendMessageToWXReq *wxReq = [[SendMessageToWXReq alloc] init];
    switch (type) {
        case ShareType_WexinTimeline: wxReq.scene = WXSceneTimeline; break;
            
        case ShareType_WexinSession: wxReq.scene = WXSceneSession;    break;
    }
    //wxReq.scene=WXSceneSession;
    wxReq.bText = NO;
    wxReq.message = message;
    [WXApi sendReq:wxReq];
}

@end
