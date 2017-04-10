//
//  ESCouponPageController.m
//  iCarePregnant
//
//  Created by wcz on 16/6/22.
//  Copyright © 2016年 oenius. All rights reserved.
//优惠卷

#import "ESCouponPageController.h"
#import "ICCouponController.h"
#import "UIImage+extention.h"
@interface ESCouponPageController()
@property (nonatomic,weak) UIView*navBarView;
@end
@implementation ESCouponPageController
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

-(instancetype)init
{
    if ([super init]) {
        self.menuViewStyle = WMMenuViewStyleLine;
        self.progressColor = AllButtonBackColor;
        self.menuBGColor = [UIColor whiteColor];
        self.progressHeight = 1.5;
        self.menuViewLayoutMode=WMMenuViewLayoutModeCenter;
        self.titleSizeSelected = 15;
        self.titleSizeNormal = 15;
        self.menuHeight = 35;
        self.pageAnimatable=YES;
        self.menuItemWidth = 60;
        self.itemMargin = 25;
        self.titleColorNormal = RGB(138, 138, 138);
        self.titleColorSelected = AllButtonBackColor;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"优惠券";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
     [self.view addSubview:self.navBarView];
    self.navBarView.dk_backgroundColorPicker=DKColorPickerWithKey(BG);

    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController
{
    return 3;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index
{
    if(index == 0){
        return @"未使用";
    }else if(index == 1){
        return @"已使用";
    }else{
        return @"已过期";
    }
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    ICCouponController *controller = [[ICCouponController alloc] init];
    controller.couponType = CouponType_Center;
    controller.isComeFromUserCenter=YES;
    if(index == 0){
        controller.type = @1;
    }else if(index == 1){
        controller.type = @2;
    }else{
        controller.type = @3;
    }
    return controller;
}







@end
