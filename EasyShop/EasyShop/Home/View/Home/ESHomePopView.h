//
//  ESHomePopView.h
//  EasyShop
//
//  Created by guojian on 16/7/6.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESHomePopView : UIView

/** 选择block */
@property (nonatomic,copy) void (^selectedBlock)(NSInteger index);
@property (nonatomic, assign) BOOL isShow;

- (void)showPopView;

@end
