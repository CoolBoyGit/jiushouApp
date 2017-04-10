//
//  ESSearchView.h
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/19.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESSearchView : UIView

/** 搜索输入框 */
@property (nonatomic,weak) UITextField *searchField;

/** 查询block */
@property (nonatomic,copy) void (^searchBlock)();

@end
