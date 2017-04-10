//
//  ESUserCenterController.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/9.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESUserCenterController.h"
#import "ESAllOrderCell.h"
#import "ESOrderStateCell.h"
#import "ESUserInfoCell.h"
#import "NormalWebViewController.h"
#import "ESAddressListController.h"
#import "ESMyScoreController.h"
#import "ESChatViewController.h"
#import "ICDrawbackController.h"
#import "ESMyOrderPageController.h"
#import "ESLoginViewController.h"
#import "ESUserMoreCell.h"
#import "ESRegisterController.h"
#import "ESChangeInfoController.h"
#import "ESMyCLusterrPageCon.h"
#import "UIImage+extention.h"
#import "ESUsecerHeadView.h"
#import "UserResponse.h"
#import "ESLoginModel.h"
#import "ESSetUpController.h"
static CGFloat const imageH=143;
static CGFloat const startH = 0;
@interface ESUserCenterController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) AllOrderCount*orderCount;
@property (nonatomic,strong) NSMutableArray*itemArray;
@property (nonatomic,strong) UIImageView* headerImageView;
@property (nonatomic,assign) int flag;
/** 导航条View */
@property (nonatomic, weak) UIView *navBarView;
@property (nonatomic,strong) UILabel*titleLable;


@property (nonatomic,strong) UILabel*namelable;
@property (nonatomic,strong) ESUsecerHeadView*headerView;
@property (nonatomic,strong) UIView*lineView;
@property (nonatomic,strong) NSDictionary*themeDic;
@end

@implementation ESUserCenterController
-(NSDictionary *)themeDic{
    if (_themeDic==nil) {
        _themeDic=@{@"NORMAL":@"#ffffff",@"NIGHT":@"000000",@"RED":@"fa0000",@"BROWN":@"A67D3D",@"BLUSH":@"FF2400",@"ORCHID":@"9370DB",@"FIREBRICK":@"8E2323",@"DEEPBROWN":@"5C4033",@"OTHERRED":@"BC1717",
                    };
    }
    return _themeDic;
}
-(ESUsecerHeadView *)headerView{
    if (_headerView==nil) {
        _headerView=[[ESUsecerHeadView alloc]initWithFrame:CGRectMake(0, -95, ScreenWidth, 73)];
    }
    return _headerView;
}
-(UILabel *)titleLable{
    if (_titleLable==nil) {
        _titleLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
        _titleLable.text=@"个人中心";
        _titleLable.textAlignment=NSTextAlignmentCenter;
        _titleLable.textColor=RGBA(70, 70, 70, 0);
    }
    return _titleLable;
}
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 63.5, ScreenWidth, 0.5)];
        _lineView.backgroundColor=[UIColor clearColor];
    }
    return _lineView;
}
- (UIView *)navBarView {
    if (!_navBarView) {
        UIView *navBarView = [[UIView alloc] init];
        
        navBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        [navBarView addSubview:self.titleLable];
        [navBarView addSubview:self.lineView];
        self.navBarView = navBarView;
        [self.view insertSubview:self.navBarView aboveSubview:self.tableView];
        self.navBarView.dk_backgroundColorPicker=DKColorPickerWithKey(BG);
        
    }
    return _navBarView;
}

-(NSMutableArray *)itemArray{
    if (_itemArray==nil) {
        _itemArray=[[NSMutableArray alloc]init];
        
    }
    return _itemArray;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarView.alpha=0;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.headerView.userInfo=kUserManager.userInfo;
    if (kUserManager.isLogin==YES) {
        self.headerView.nickNameLabel.hidden=NO;
        self.headerView.signatureLable.hidden=NO;
        self.headerView.loginButton.hidden=YES;
        self.headerView.registerButton.hidden=YES;
        self.headerView.centerLineView. hidden=YES;
        if (kUserManager.userInfo.nickname.length!=0) {
            self.titleLable.text=kUserManager.userInfo.nickname;
            
        }else{
            self.titleLable.text  = [kUserManager .userInfo.username stringByReplacingCharactersInRange:NSMakeRange(4, 4) withString:@"***"];
        }
    }else{
        self.headerView.nickNameLabel.hidden=YES;
        self.headerView.signatureLable.hidden=YES;
        self.headerView.loginButton.hidden=NO;
        self.headerView.registerButton.hidden=NO;
        self.headerView.centerLineView. hidden=NO;
        self.titleLable.text=@"个人中心";
    }
}
-(UIImageView *)headerImageView{
    if (_headerImageView==nil) {
        _headerImageView=[[UIImageView alloc]init];
        _headerImageView.image=[UIImage imageNamed:@"mine_topbackimage"];
    }
    return _headerImageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addNotification];
    self.flag=0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInset = UIEdgeInsetsMake(imageH, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 49, 0);
    self.headerImageView.frame = CGRectMake(0, -imageH, [UIScreen mainScreen].bounds.size.width, imageH);
    self.headerImageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.tableView insertSubview:self.headerImageView atIndex:0];
    [self.tableView insertSubview:self.headerView aboveSubview:self.headerImageView];
    [self.view addSubview:self.tableView];
    @weakify(self);
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 23, 23);
    [button setBackgroundImage:[UIImage imageNamed:@"setup"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushTo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
    [self.tableView setContentOffset:CGPointMake(0, -imageH) animated:YES];
    [self getAllOrderCount];
    [self.view addSubview:self.navBarView];
    self.headerView.registerBlock=^(){
        @strongify(self);
        ESRegisterController*vc=[[ESRegisterController alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    };
    self.headerView.loaginBlock=^(){
        @strongify(self);
        ESLoginViewController*vc=[[ESLoginViewController alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    };
    self.headerView.userCenterBlock=^(){
        @strongify(self);
        ESChangeInfoController*vc=[[ESChangeInfoController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    
}
//跳转去设置界面
-(void)pushTo{
    ESSetUpController*vc=[[ESSetUpController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.navBarView.alpha=1;
    CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY > -imageH + startH) {
        CGFloat alpha = MIN(1, 1 - ((-imageH + startH + 64 - offsetY) / 64));
        [self.view insertSubview:self.navBarView aboveSubview:self.tableView];
            NSString*themeStr=[self.themeDic objectForKey:self.dk_manager.themeVersion];
            self.navBarView.backgroundColor=[themeStr colorWithHexlpha:alpha];
            self.titleLable.textColor=RGBA(70, 70, 70, alpha);
        } 
        else {
        self.navBarView.backgroundColor = RGBA(255, 255, 255, 0);
        self.lineView.backgroundColor=RGBA(240, 240, 240, 0);
        
    }
    CGFloat down = - imageH - scrollView.contentOffset.y;
    if (down < 0) return;
    CGRect  tFrame=self.headerView.frame;
    tFrame.origin.y=-200-down;
    CGRect frame = self.headerImageView.frame;
    frame.origin.y = - imageH - down;
    frame.size.height = imageH + down;
    self.headerImageView.frame = frame;
}
-(void)getAllOrderCount{
    GetAllOrderCount *request=[GetAllOrderCount request];
    
    [ESService GetAllOrderCountRequest:request success:^(AllOrderCount *count) {
        self.orderCount=count;
        NSIndexPath*indext=[NSIndexPath indexPathForRow:1 inSection:1];
        [self.itemArray removeAllObjects];
        [self.itemArray addObject:count.wait_pay];
        [self.itemArray addObject:count.order_payed];
        [self.itemArray addObject:count.wait_confirm];
        [self.itemArray addObject:count.wait_evaluation];
        [self .tableView reloadRowsAtIndexPaths:@[indext] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSError *error) {
        
    }];
}
- (void)dealloc
{
    [self removeNotification];
}

#pragma mark - Notification
- (void)addNotification
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAllOrderCount) name:KKUpdateAllOredrCountNotifacation object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin) name:kUserLoginNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:kUserLogoutNotification object:nil];
    //是用户资料获取的时候
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoUpdate) name:kUserInfoUpdateNotification object:nil];
}

- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)userDidLogin
{
    
    [self getAllOrderCount];
    
}
- (void)userDidLogout
{
    self.namelable.textColor=[UIColor yellowColor];
    [self.tableView reloadData];
}
- (void)userInfoUpdate
{
    [self.tableView reloadData];
}

#pragma mark
#pragma mark - tableview代理方法;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 1;
            break;
            
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return .1;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 70;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 30;
        }
        return 70;
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return 30;
        }
        return 70;
    }
    
    
    return 70*2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
        if (indexPath.section==1) {
        ESLoginVerify
            ESMyOrderPageController *controller = [[ESMyOrderPageController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
            return;
    }
    if (indexPath.section == 2) {
        ESLoginVerify
        ESMyCLusterrPageCon*vc=[[ESMyCLusterrPageCon alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
        [[AppDelegate shared] pushViewController:vc animated:YES];
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {//用户信息
        ////                Fade = 1,                   //淡入淡出
        ////                Push,                       //推挤
        ////                Reveal,                     //揭开
        ////                MoveIn,                     //覆盖
        ////                Cube,                       //立方体
        ////                SuckEffect,                 //吮吸
        ////                OglFlip,                    //翻转
        ////                RippleEffect,               //波纹
        ////                PageCurl,                   //翻页
        ////                PageUnCurl,                 //反翻页
        ////                CameraIrisHollowOpen,       //开镜头
        ////                CameraIrisHollowClose,      //关镜头
        ////                CurlDown,                   //下翻页
        ////                CurlUp,                     //上翻页
        ////                FlipFromLeft,               //左翻转
        ////                FlipFromRight,              //右翻转
        ////                CATransition *transition = [[CATransition alloc] init];
        ////                transition.type =kCATransitionPush;                //立方体翻转
        ////                transition.subtype = kCATransitionFromTop;
        ////                transition.duration = 0.6;
        ////                transition.delegate = self;
        ////                transition.timingFunction=UIViewAnimationCurveEaseInOut;
        //                [self.navigationController pushViewController:controller animated:YES];
        ////                [self.navigationController. view.layer addAnimation:transition forKey:nil];
        //
        //               // [[AppDelegate shared]presentViewController:controller animated:YES completion:nil];
        //
        //
        //            };
        //            cell.registerBlock=^{
        //                ESRegisterController* registerVc=[[ESRegisterController alloc]init];
        //                registerVc.hidesBottomBarWhenPushed=YES;
        //                [self.navigationController pushViewController:registerVc animated:YES];
        //
        //            };
        //            return cell;
        //        }
        
        ESOrderStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESOrderStateCell"];
        cell.titleArr = @[@"我的收藏",@"心愿单",@"到货提醒"];
        cell.tag = indexPath.section;
        cell.imgArr = @[@"mine_collet",@"mine_wish",@"mine_tips"];
        return cell;
    }else if (indexPath.section==1){
        if (indexPath.row == 0) {
            ESAllOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESAllOrderCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"查看全部订单";
            cell.detailTextLabel.font = ADeanFONT13;
            cell.imgStr = @"allOrder";
            cell.titleStr = @"我的订单";
            
            cell.detailTextLabel.textColor = ADeanHEXCOLOR(0x999999);
            return cell;
        }
        ESOrderStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESOrderStateCell"];
        cell.titleArr = @[@"待付款",@"待发货",@"待收货",@"待评价"];
        cell.tag = indexPath.section;
        cell.imgArr = @[@"mine_waitfor",@"mine_dispatchgoods",@"mine_ consignee",@"mine_ judge"];
        cell.itemArray=self.itemArray;
        
        return cell;

        
    }
    else if (indexPath.section == 2) {//我的订单
        if (indexPath.row == 0) {
            ESAllOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESAllOrderCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"查看全部拼团";
            cell.detailTextLabel.font = ADeanFONT13;
            cell.imgStr = @"allOrder";
            cell.titleStr = @"我的拼团";
            
            cell.detailTextLabel.textColor = ADeanHEXCOLOR(0x999999);
            return cell;
        }
        ESOrderStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESOrderStateCell"];
        cell.titleArr = @[@"全部",@"拼团成功",@"拼团中",@"拼团失败"];
        cell.tag = indexPath.section;
        cell.imgArr = @[@"mine_cluster_all",@"mine_cluster_success",@"mine_cluster_being",@"mine_cluster_fail"];
        return cell;

    
    }else {
        ESUserMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESUserMoreCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

#pragma mark
#pragma mark lazy init
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.backgroundColor=RGBA(247, 247, 247, 1);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESUserMoreCell class] forCellReuseIdentifier:@"ESUserMoreCell"];
        [_tableView registerClass:[ESUserInfoCell class] forCellReuseIdentifier:@"ESUserInfoCell"];
        [_tableView registerClass:[ESOrderStateCell class] forCellReuseIdentifier:@"ESOrderStateCell"];
        [_tableView registerClass:[ESAllOrderCell class] forCellReuseIdentifier:@"ESAllOrderCell"];
    }
    return _tableView;
}

@end
