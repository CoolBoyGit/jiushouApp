





//
//  ESPageController.m
//  EasyShop
//
//  Created by wcz on 16/3/26.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESPageController.h"
#import "ESHomeController.h"
#import "ESKIDSController.h"
#import "ESHomeSearchView.h"
#import "ESEmptyViewController.h"
#import "ESCountryController.h"
#import "ESShopCommentController.h"
#import "UIHomeSelectView.h"
#import "ICAlert.h"
#import "ESMyOrderPageController.h"
#import "RichScanViewController.h"
//#import "HomeTitleView.h"
#import "ESHomePopView.h"
#import "ICCouponController.h"
#import "ESChatViewController.h"
#import "EaseMob.h"
#import "ESScanViewController.h"
#import "UIImage+extention.h"
@interface ESPageController ()

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, strong)ESHomePopView *popView;
/** 是否导航信息为空 */
@property (nonatomic,assign) BOOL isEmpty;
/** empty */
@property (nonatomic,weak) ESEmptyViewController *emptyController;
/** 导航信息（item ： NavInfo ） */
@property (nonatomic,strong) NSArray *navItems;
/** 分类信息( item : GoodsCategoryInfo ) */
//@property (nonatomic,strong) NSArray *categoryItems;

/** Indicator */
@property (nonatomic,strong) ESIndicator *indicator;
@property (nonatomic, weak) UIView *navBarView;
@end

@implementation ESPageController

- (UIView *)circleView
{
    if (_circleView == nil) {
        _circleView = [[UIView alloc] init];
        _circleView.layer.cornerRadius = 5;
        _circleView.backgroundColor = AllButtonBackColor;
        _circleView.layer.masksToBounds = YES;
    }
    return _circleView;
}

- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}

- (BOOL)isEmpty
{
    return !(self.navItems && self.navItems.count>0);
}



-(instancetype)init
{
    if ([super init]) {
        self.menuViewStyle = WMMenuViewStyleLine;
        self.progressColor = RGB(233, 40, 46);
        self.menuBGColor = [UIColor whiteColor];
        self.progressHeight = 1.5;
    }
    return self;
}

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleSizeSelected = 15;
    self.titleSizeNormal = 15;
    self.menuHeight = 35;
    self.menuItemWidth = 65;
    self.itemMargin = 10;
    self.pageAnimatable=YES;
    self.postNotification = YES;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.bounces = NO;
    self.titleColorNormal = RGB(138, 138, 138);
    self.titleColorSelected = AllButtonBackColor;
    //self.navigationController.navigationBar.translucent = NO;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,25,25)];
    [leftButton setImage:[UIImage imageNamed:@"home_message"]forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnAction)forControlEvents:UIControlEventTouchUpInside];
    
    [leftButton addSubview:self.circleView];
    
    self.circleView.hidden = YES;
    [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.height.width.equalTo(@10);
        make.top.equalTo(@0);
    }];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.navBarView];
    self.navBarView.dk_backgroundColorPicker=DKColorPickerWithKey(BG);
    UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    UIBarButtonItem*leftnegate=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftnegate.width=-10;
    self.navigationItem.leftBarButtonItems= @[leftnegate,leftItem];
    //扫一扫
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,25,25)];
    [rightButton setImage:[UIImage imageNamed:@"home_sweep"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnAction)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    UIBarButtonItem*rightNe=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNe.width=-10;
    
    self.navigationItem.rightBarButtonItems=@[rightNe,rightItem] ;
    ESHomeSearchView *titleView = [[ESHomeSearchView alloc] initWithFrame:CGRectMake(25, 30, 300, 30)];
    titleView.isAllowToPush = YES;
    titleView.placeholderColor=[UIColor colorWithRed:(142.0/255) green:(142.0/255) blue:(147.0/255) alpha:1];
    titleView.textColor=[UIColor colorWithRed:(142.0/255) green:(142.0/255) blue:(147.0/255) alpha:1];
    ;
    titleView.placeholder=@"在千万海外商品中搜索";
    self.navigationItem.titleView=titleView;
    
    [self fetchNavList];
}

- (UIView *)navBarView {
    if (!_navBarView) {
        UIView *navBarView = [[UIView alloc] init];
        navBarView.backgroundColor = [UIColor whiteColor];
        navBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        UIView*lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 63.5, ScreenWidth, 0.5)];
        lineView.backgroundColor=RGB(240, 240, 240);
        [navBarView addSubview:lineView];
        
        [self.view addSubview:navBarView];
        self.navBarView = navBarView;
    }
    return _navBarView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    NSInteger totalNum =  [[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
    NSString*str=[NSString stringWithFormat:@"%ld",totalNum];
    [[NSNotificationCenter defaultCenter]postNotificationName:KKUpdateApplicationIconBadgeNumber object:str];
    if (totalNum) {
        self.circleView.hidden = NO;
        self.isShow = YES;
    } else
    {
        self.circleView.hidden = YES;
        self.isShow = NO;
    }
}

 -(void)showUnread
{
    self.circleView.hidden = NO;
    self.isShow = YES;
}

-(void)leftBtnAction
{
    ESHomePopView *popView = [[ESHomePopView alloc] init];
    popView.isShow = self.isShow;
    self.popView = popView;
    @weakify(self);
    popView.selectedBlock = ^(NSInteger index){
        ESLoginVerify

      @strongify(self);
        if (index == 0) {//我的订单
            ESMyOrderPageController *controller = [[ESMyOrderPageController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }else if (index == 1){//现金券
            ICCouponController *coupon = [[ICCouponController alloc] init];
            coupon.couponType = CouponType_Get;
            [self.navigationController pushViewController:coupon animated:YES];
        }else{//消息
            NSString *easeMob = @"JiuShouGuoJi2";
            
            ESChatViewController * controller = [[ESChatViewController alloc] initWithConversationChatter:easeMob conversationType:eConversationTypeChat];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];

            
            
        }
        
    };
    [popView showPopView];
    
}
//扫一扫
-(void)rightBtnAction
{
    ESScanViewController*vc=[[ESScanViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - WMPageControllerDataSource

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController
{
    if (self.isEmpty) {
        return 1;
    }
    return self.navItems.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index
{
    if (self.isEmpty) {
        return @"";
    }
    NavInfo *info = [self.navItems objectAtIndex:index];
    return info.name;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    if (self.isEmpty) {
        ESEmptyViewController *empty = [[ESEmptyViewController alloc] init];
        @weakify(self);
        empty.RefreshBlock = ^{
            @strongify(self);
            [self fetchNavList];
        };
        self.emptyController = empty;
        return empty;
    }
    NavInfo *info = [self.navItems objectAtIndex:index];
    //全球购
    if ([info.nid isEqualToString:@"2"]) {
        ESHomeController *home = [[ESHomeController alloc] init];
        home.navInfo            = info;
        return home;
        //国家馆
    }else if ([info.nid isEqualToString:@"6"]){
        ESCountryController *controller    = [[ESCountryController alloc] init];
        controller.navInfo              = info;
        return controller;
    }else{//其他页面
        ESKIDSController *controller    = [[ESKIDSController alloc] init];
        controller.navInfo              = info;
        return controller;
    }
}


#pragma mark - Networking
/**
 *  获取导航信息
 */
- (void)fetchNavList
{
    GetNavListRequest *request = [GetNavListRequest request];
    
    @weakify(self);
    [self beginNetworking];
    [ESService getNavListRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        
        self.navItems = response;
        [self reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}

#pragma mark GSNetworking
- (void)beginNetworking
{
    self.emptyController.isNetworking = YES;
    [self.indicator startAnimation];
}

- (void)endGSNetworking
{
    self.emptyController.isNetworking = NO;
    [self.indicator stopAnimation];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    self.navigationController.navigationBar.hidden = YES;
}

@end
