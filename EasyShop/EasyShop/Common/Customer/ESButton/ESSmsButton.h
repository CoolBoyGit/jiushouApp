//
//  ESSmsButton.h
//  EasyShop
//
//  Created by guojian on 16/6/4.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESSmsButton : UIButton

/** 手机号码 */
@property (nonatomic,copy) NSString *phone;

- (void)resetSmsButton;

@end
