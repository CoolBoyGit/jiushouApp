//
//  ESNavigationController.m
//  EasyShop
//
//  Created by wcz on 16/3/26.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESNavigationController.h"

@interface ESNavigationController ()

@end

@implementation ESNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
