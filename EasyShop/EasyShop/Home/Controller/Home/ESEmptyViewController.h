//
//  ESEmptyViewController.h
//  EasyShop
//
//  Created by guojian on 16/5/28.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESEmptyViewController : UIViewController

/** 是否正在请求数据 */
@property (nonatomic,assign) BOOL isNetworking;

/** 刷新block */
@property (nonatomic,copy)  void (^RefreshBlock)();

@end
