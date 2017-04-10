//
//  ESChatViewController.m
//  EasyShop
//
//  Created by wcz on 16/4/23.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESChatViewController.h"
#import "ICChatMessageCell.h"
#import "IMessageModel.h"
#import "ICProductMessageCell.h"
#import "UIImage+extention.h"
@interface
ESChatViewController () <EaseMessageViewControllerDataSource, EaseMessageViewControllerDelegate>
@property (nonatomic, weak) UIView *navBarView;

@end

@implementation ESChatViewController
- (UIView *)navBarView {
    if (!_navBarView) {
        UIView *navBarView = [[UIView alloc] init];
        navBarView.backgroundColor = [UIColor whiteColor];
        navBarView.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, 64);
        UIView*lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 63.5, ScreenWidth, 0.5)];
        lineView.backgroundColor=RGB(230, 230, 230);
        [navBarView addSubview:lineView];
        [self.view addSubview:navBarView];
        self.navBarView = navBarView;
    }
    return _navBarView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"客服";
    //TitleCenter;
    self.showRefreshHeader = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
//    UIImage*toImage=[UIImage imageNamed:@"chatto_bg_focused"];
//    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[toImage stretchableImageWithLeftCapWidth:30 topCapHeight:15]];//设置发送气泡
    [[NSNotificationCenter defaultCenter]postNotificationName:KKupdateHadApplicationIconBadgeNumber object:nil];
    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[[UIImage imageNamed:@"icon_sender" ] stretchableImageWithLeftCapWidth:5 topCapHeight:15]];//设置发送气泡
//    UIImage*comImage=[UIImage imageNamed:@"chatfrom_bg_normal"];
//    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[comImage stretchableImageWithLeftCapWidth:comImage.size.width/5 topCapHeight:50]];//设置接收气泡
//    
    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[[UIImage imageNamed:@"icon_receive"] stretchableImageWithLeftCapWidth:10 topCapHeight:15]];//设置接收气泡
    self.delegate = self;
    self.dataSource = self;
    
    [self tableViewDidTriggerHeaderRefresh];
    [self.view addSubview:self.navBarView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:LoginViewwillDiddisAppear object:nil];
    //ShowNavbar;
}
- (UITableViewCell *)messageViewController:(UITableView *)tableView cellForMessageModel:(id<IMessageModel>)messageModel
{
    if (messageModel.bodyType == eMessageBodyType_Text)
    {
        if ([messageModel.message.ext objectForKey:@"msgtype"])
        {
            NSString *CellIdentifier1 = @"ICProductMessageCell";
            ICProductMessageCell *cell = (ICProductMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (cell == nil) {
                cell = [[ICProductMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1 model:messageModel];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.model = messageModel;
            return cell;
        }
        
        
        NSString *CellIdentifier = [ICChatMessageCell cellIdentifierWithModel:messageModel];
        ICChatMessageCell *cell = (ICChatMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[ICChatMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:messageModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.hasRead.text = @"";
        cell.model = messageModel;
        return nil;
    }else{
        return nil;
    }
    return nil;
}
- (CGFloat)messageViewController:(EaseMessageViewController *)viewController
           heightForMessageModel:(id<IMessageModel>)messageModel
                   withCellWidth:(CGFloat)cellWidth
{
    if ([messageModel.message.ext objectForKey:@"msgtype"]) {
        return 130;
    }
    return 0;
}

- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    //用户可以根据自己的用户体系,根据message设置用户昵称和头像
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];                            //默认头像
    model.avatarURLPath = model.isSender ? kUserManager.userInfo.logo : @""; //头像网络地址
    
    model.nickname = model.isSender ?  kUserManager.userInfo.nickname :@"就手001";
    return model;
}



//-(BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//-(BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
//{
//    if (action == @selector(copy:)) {
//        return YES;
//    }
//    return NO;
//}
//-(void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
//{
//    ICChatMessageCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    EMTextMessageBody *body = [[cell.model message] messageBodies][0];
//    NSLog(@"%@",[body class]);
//    if(!(body.messageBodyType == eMessageBodyType_Text))
//    {
//    }
//    if (action == @selector(copy:)) {
//        [UIPasteboard generalPasteboard].string = [body text];
//    }
//}


@end