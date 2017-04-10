//
//  ESUserMoreCell.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/4/29.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESUserMoreCell.h"
#import "TIBTUIButton.h"
#import "NormalWebViewController.h"
#import "ESAddressListController.h"
#import "ESMyScoreController.h"
#import "ESChatViewController.h"
#import "ICDrawbackController.h"
#import "ESChangeInfoController.h"
#import <BlocksKit+UIKit.h>
#import "ESLoginViewController.h"
#import "ESMyFootController.h"
#import "ESCouponPageController.h"
#import "ESESRefoundController.h"
#import "ESFeedbackController.h"
#import "JSMessagesViewController.h"
#import "ESRefundListController.h"
#import "EaseMob.h"

@implementation ESUserMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupViews
{
//    NSArray *titleArr = @[@"收货地址",@"我的足迹",@"优惠券",@"退货/退款",@"售后客服",@"意见反馈",@"个人资料",@"关于就手",@"退出登陆"];
//    NSArray *imageArr =
//  @[@"mine_address",@"user_ footprint_select",@"user_coupon",@"mine_drawback",@"mine_chat",@"mine_Feedback",@"mine_change",@"mine_about",@"mine_Logout"];
//    NSArray *titleArr = @[@"收货地址",@"我的足迹",@"优惠券",@"退货/退款",@"售后客服",@"个人资料",@"关于就手",@"退出登陆"];
//    NSArray *imageArr =
//    @[@"mine_address",@"mine_foot",@"mine_coupon",@"mine_drawback",@"mine_chat",@"mine_ information",@"mine_about",@"mine_Logout"];
    NSArray *titleArr = @[@"收货地址",@"我的足迹",@"优惠券",@"退货/退款",@"售后客服",@"个人资料"];
    NSArray *imageArr =
    @[@"mine_address",@"mine_foot",@"mine_coupon",@"mine_drawback",@"mine_chat",@"mine_ information"];
    CGFloat W = (ScreenWidth) / 4.0;
    for (int i = 0; i < titleArr.count; i++) {
        if (i==3) {
            UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 70,ScreenWidth,0.5)];
            lable.alpha=1;
            lable.backgroundColor=RGB(210, 210, 210);
            [self.contentView addSubview:lable];
        }
        TIBTUIButton *btn = [[TIBTUIButton alloc]initWithFrame:CGRectMake(W*(i%4), 71*(i/4), W, 70)];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.leftImg.contentMode = UIViewContentModeScaleToFill;
        if (kUserManager.isUseOtherImage) {
            NSFileManager*mangge=[NSFileManager defaultManager];
            NSString*newRoute=[kUserManager.themRootRoute stringByAppendingPathComponent:imageArr[i]];
            NSString*imagefile=[newRoute stringByAppendingPathComponent:@"@2x"];
            if ([mangge fileExistsAtPath:imagefile]==YES) {
                btn.leftImg.image=[UIImage imageWithContentsOfFile:newRoute];
                
                
            }else{
                NSString *image = imageArr[i];
                btn.leftImg.image = [UIImage imageNamed:image];
                
            }
            
        }else{
            NSString *image = imageArr[i];
            btn.leftImg.image = [UIImage imageNamed:image];
        }
        btn.rightLabel.text = titleArr[i];
        btn.rightLabel.textColor=RGB(35, 35, 35);
        [self.contentView addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)button
{

    if (button.tag == 0) {//收货地址管理
        ESLoginVerify
        
        ESAddressListController *vc = [[ESAddressListController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [[AppDelegate shared] pushViewController:vc animated:YES];
    }else if (button.tag == 1) {//我的足迹
        ESLoginVerify
        
        ESMyFootController *vc = [[ESMyFootController alloc]init];
        vc.flag=3;
        vc.hidesBottomBarWhenPushed = YES;
        [[AppDelegate shared] pushViewController:vc animated:YES];
    }else if (button.tag == 2) {//我的优惠券
        ESLoginVerify
        ESCouponPageController *vc =[[ESCouponPageController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [[AppDelegate shared] pushViewController:vc animated:YES];
        
    }else if (button.tag == 3) {//退货退款
        ESLoginVerify
        
//        ESRefundListController *vc = [[ESRefundListController alloc]init];
        /****/
        
//        vc.hidesBottomBarWhenPushed = YES;
//        [[AppDelegate shared] pushViewController:vc animated:YES];
        
        ICDrawbackController *vc = [[ICDrawbackController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [[AppDelegate shared] pushViewController:vc animated:YES];
   }else if (button.tag == 4) {//售后服务
       ESLoginVerify;
       NSString *easeMob = @"JiuShouGuoJi2";

       ESChatViewController * controller = [[ESChatViewController alloc] initWithConversationChatter:easeMob conversationType:eConversationTypeChat];
//        *vc = [[ESChatViewController alloc]init];
       controller.hidesBottomBarWhenPushed = YES;
       [[AppDelegate shared] pushViewController:controller animated:YES];
   }
//   else if (button.tag == 5) {//意见反馈
//       ESLoginVerify
//       
//       ESFeedbackController *vc = [[ESFeedbackController alloc]init];
//       vc.hidesBottomBarWhenPushed = YES;
//       [[AppDelegate shared] pushViewController:vc animated:YES];
//       return;
//   }
   else if (button.tag == 5) {//修改个人资料
       ESLoginVerify
       
       ESChangeInfoController *vc = [[ESChangeInfoController alloc]init];
       vc.hidesBottomBarWhenPushed = YES;
       [[AppDelegate shared] pushViewController:vc animated:YES];
   }else if (button.tag == 6) {//关于就手
        NormalWebViewController *vc = [[NormalWebViewController alloc] init];
        vc.url = @"http://api.jiushouguoji.hk/app/Guider/aboutUs";
        vc.title = @"关于就手";
        vc.hidesBottomBarWhenPushed = YES;
        [[AppDelegate shared] pushViewController:vc animated:YES];
   }else if (button.tag == 7){//退出登录
       ESLoginVerify
       
       UIActionSheet *sheet = [[UIActionSheet alloc] init];
       [sheet bk_addButtonWithTitle:@"退出登录" handler:^{
           
           [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
               [kUserManager doUserLogout];
               ESLoginViewController *login = [[ESLoginViewController alloc] init];
               [[AppDelegate shared] pushViewController:login animated:YES];
               
           } onQueue:nil];
          
       }];
       [sheet bk_addButtonWithTitle:@"取消" handler:nil];
       [sheet showInView:kKeyWindow];
//       UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:@"提示信息" message:@"您确认退出当前登录？"];
//       [alertView bk_addButtonWithTitle:@"去切换" handler:^{
//           ESLoginViewController *login = [[ESLoginViewController alloc] init];
//           [[AppDelegate shared] pushViewController:login animated:YES];
//       }];
//       [alertView bk_addButtonWithTitle:@"退出登录" handler:^{
//           [kUserManager doLogout];
//       }];
//       [alertView show];
   }
}


@end
