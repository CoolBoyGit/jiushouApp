//
//  ESMyTogetherPageController.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/19.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESMyCLusterrPageCon.h"
#import "TogetherJoinItem.h"
#import "ESMyCLusterOrderListCon.h"
#import "UIImage+extention.h"

@interface ESMyCLusterrPageCon ()
@property (nonatomic,strong) NSArray*togetherItems;
/** 订单item */
@property (nonatomic,strong) NSArray *orderItems;
/** 导航条View */
@property (nonatomic, weak) UIView *navBarView;
@end

@implementation ESMyCLusterrPageCon
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我的团";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.navBarView];
    // 设置夜间效果的颜色
   self.navBarView.dk_backgroundColorPicker=DKColorPickerWithKey(BG);    
}
-(NSArray *)togetherItems{
    if (_togetherItems==nil) {
        _togetherItems=@[[TogetherJoinItem itemWithTitle:@"全部" type:TogetherType_All],[TogetherJoinItem itemWithTitle:@"拼团成功" type:TogetherType_Succeed],[TogetherJoinItem itemWithTitle:@"拼团中" type:TogetherType_Waiting],[TogetherJoinItem itemWithTitle:@"拼团失败" type:TogetherType_Failed]
                         ];
    }
    return _togetherItems;
}

- (instancetype)init
{
    if(self = [super init])
    {
        self.menuHeight = 35;
        self.progressColor = AllButtonBackColor;
        self.progressHeight = 1.5;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = 70 ;
//        self.itemsWidths=@[@"33",@"60",@"45",@"60"];
        self.postNotification = YES;
        self.titleSizeSelected = 15;
        self.itemMargin = 20;
        self.menuBGColor=[UIColor whiteColor];
        self.pageAnimatable=YES;
        self.titleSizeNormal = 15;
        self.titleColorSelected = AllButtonBackColor;
        self.titleColorNormal = RGB(138, 138, 138);
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //ShowNavbar;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
}


- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController
{
    return self.togetherItems.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index
{
    TogetherJoinItem *item = [self.togetherItems objectAtIndex:index];
    return item.title;//返回的是全部 拼团中等分类文字
}
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    ESMyCLusterOrderListCon*listVc=[[ESMyCLusterOrderListCon alloc]init];
    TogetherJoinItem*item=[self.togetherItems objectAtIndex:index];
    listVc.type=item.TogetherType;
    return listVc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
