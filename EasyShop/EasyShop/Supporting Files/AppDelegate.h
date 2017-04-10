//
//  AppDelegate.h
//  EasyShop
//
//  Created by wcz on 16/3/23.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/** tabbar控制器 */
@property (nonatomic,weak) ESTabBarController *tabbarController;


@end

