//
//  ESThirdRegisterView.h
//  EasyShop
//
//  Created by wcz on 16/6/3.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESThirdRegisterView : UIView

/** 绑定 */
@property (nonatomic,copy) void (^bindBlock)(NSString *moblie,NSString *smsCode);

@end
