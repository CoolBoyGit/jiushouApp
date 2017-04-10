//
//  UIBaseViewController.m
//  包天下
//
//  Created by LDZPro on 16/1/9.
//  Copyright © 2016年 LDZPro. All rights reserved.
//

#import "UIBaseViewController.h"
//#import "Define.h"
@interface UIBaseViewController ()

@end

@implementation UIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
//设置导航栏的标题
-(void)setNavigationTitle:(NSString *)naviagtionTitle{
    UILabel *label = [[UILabel alloc ]initWithFrame:CGRectMake(0, 0, 120, 20)];
    label.text = naviagtionTitle;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.adjustsFontSizeToFitWidth = YES;//自动调整字体大小（根据label的宽度，自动把字体缩小）
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView  = label;
}
-(void)setNavigationTitle:(NSString *)naviagtionTitle andCorlor:(UIColor *)color{
    UILabel *label = [[UILabel alloc ]initWithFrame:CGRectMake(0, 0, 120, 20)];
    label.text = naviagtionTitle;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:20];
    label.adjustsFontSizeToFitWidth = YES;//自动调整字体大小（根据label的宽度，自动把字体缩小）
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView  = label;
}
/**
 导航栏左侧添加一个按钮
 参数一：按钮的标题
 参数二：背景图片的名字
 参数三： 消息的执行者
 参数四：按钮点击的回调函数
 */
-(void)addLeftNavigationItem:(NSString *)btnTitle backImage:(NSString *)imageName target:(id)target
                    selector:(SEL)selector{

    self.leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [self.leftButton setTitle:btnTitle forState:UIControlStateNormal];
    //
    [self.leftButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    
}
-(void)addRightNavigationItem:(NSString *)btnTitle backImage:(NSString *)imageName target:(id)target
                     selector:(SEL)selector{
    self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [self.rightButton setTitle:btnTitle forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.rightButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = leftBar;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
