//
//  ESMyOrderListController.m
//  EasyShop
//
//  Created by wcz on 16/4/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESMyOrderPageController.h"
#import "ESMyOrderListController.h"
#import "OrderItem.h"
#import "ESSureOrderController.h"
#import "UIImage+extention.h"
@interface ESMyOrderPageController ()

/** 订单item */
@property (nonatomic,strong) NSArray *orderItems;
@property (nonatomic,weak) UIView*navBarView;

@end

@implementation ESMyOrderPageController
- (UIView *)navBarView {
    if (!_navBarView) {
        UIView *navBarView = [[UIView alloc] init];
        navBarView.backgroundColor = [UIColor whiteColor];
        navBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        UIView*lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 63.5, ScreenWidth, 0.5)];
        lineView.backgroundColor=RGB(230, 230, 230);
        [navBarView addSubview:lineView];
        [self.view addSubview:navBarView];
        self.navBarView = navBarView;
    }
    return _navBarView;
}
- (NSArray *)orderItems
{
    if (!_orderItems) {
        _orderItems = @[[OrderItem itemWithTitle:@"全部" type:OrderType_All],
                        [OrderItem itemWithTitle:@"待付款" type:OrderType_WaitingPay],
                        [OrderItem itemWithTitle:@"待发货" type:OrderType_WaitingSend],
                        [OrderItem itemWithTitle:@"待收货" type:OrderType_WaitingSure],
                        [OrderItem itemWithTitle:@"待评价" type:OrderType_OK],[OrderItem itemWithTitle:@"已取消" type:OrderType_Cancel]];
    }
    return _orderItems;
}


- (instancetype)init
{
    if(self = [super init])
    {
        self.menuHeight = 35;
        //设置下划线的颜色
        self.progressColor = AllButtonBackColor;
        self.progressHeight = 1.5;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = 50 ;
        self.postNotification = YES;
        self.titleSizeSelected = 15;
        self.itemMargin = 20;
        self.menuBGColor=[UIColor whiteColor];
        self.pageAnimatable=YES;
//        self.itemsWidths=@[@"33",@"45",@"45",@"45",@"45",@"45"];
        self.titleSizeNormal = 15;
        
        self.titleColorSelected = AllButtonBackColor;
        self.titleColorNormal = RGB(138, 138, 138);

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我的订单";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.navBarView];
    // 设置夜间效果的颜色
    self.navBarView.dk_backgroundColorPicker=DKColorPickerWithKey(BG);//    [self addColorChangedBlock:^{
//        @strongify(self);
//        self.navBarView.normalBackgroundColor=[UIColor whiteColor];
//        self.navBarView.nightBackgroundColor=[UIColor blackColor];
//    }];


}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //ShowNavbar;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //如果是从确认订单页面进入，则清除该页面
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [mArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[ESSureOrderController class]]) {
            [mArr removeObject:obj];
        }
    }];
    self.navigationController.viewControllers = [mArr copy];
    
}


- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController
{
    return self.orderItems.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index
{
    OrderItem *item = [self.orderItems objectAtIndex:index];
    return item.title;//返回的是全部、待发货等分类文字
}
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    ESMyOrderListController *order = [[ESMyOrderListController alloc] init];
    OrderItem *item = [self.orderItems objectAtIndex:index];
    order.orderType = item.orderType;//设定分类下的控制器都是同一个
    return order;
}

@end
