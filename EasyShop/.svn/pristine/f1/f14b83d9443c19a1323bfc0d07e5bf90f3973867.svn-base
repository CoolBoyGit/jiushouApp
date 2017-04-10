//
//  AppDelegate+ESExtension.h
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (ESExtension)

@property(nonatomic,weak,readonly)UINavigationController *curNav;
@property(nonatomic,weak,readonly)UIViewController *topVC;

+ (AppDelegate *)shared;

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void(^)(void))completion;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)popToRootViewControllerAnimated:(BOOL)animated;

@end
