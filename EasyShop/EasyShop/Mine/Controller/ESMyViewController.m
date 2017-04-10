//
//  ESMyViewController.m
//  EasyShop
//
//  Created by 就手国际 on 17/1/3.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import "ESMyViewController.h"
#import "UIImage+extention.h"
#import "DKNightVersion.h"
@interface ESMyViewController ()
/** 导航条View */
@property (nonatomic, weak) UIView *navBarView;
@end

@implementation ESMyViewController
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
     [self.view addSubview:self.navBarView];
    self.navBarView.dk_backgroundColorPicker=DKColorPickerWithKey(BG);    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

@end
