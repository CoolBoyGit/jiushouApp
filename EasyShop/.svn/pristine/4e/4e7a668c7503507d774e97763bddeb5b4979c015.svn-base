//
//  UIBaseViewController.h
//  包天下
//
//  Created by LDZPro on 16/1/9.
//  Copyright © 2016年 LDZPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBaseViewController : UIViewController
-(void)setNavigationTitle:(NSString *)naviagtionTitle;
-(void)setNavigationTitle:(NSString *)naviagtionTitle andCorlor:(UIColor *)color;
@property(nonatomic,strong)UIButton *rightButton;
@property(nonatomic,strong)UIButton*leftButton;
/**
 导航栏左侧添加一个按钮
 参数一：按钮的标题
 参数二：背景图片的名字
 参数三： 消息的执行者
 参数四：按钮点击的回调函数
 */
-(void)addLeftNavigationItem:(NSString *)btnTitle backImage:(NSString *)imageName target:(id)target
                    selector:(SEL)selector;
-(void)addRightNavigationItem:(NSString *)btnTitle backImage:(NSString *)imageName target:(id)target
                     selector:(SEL)selector;

@end
