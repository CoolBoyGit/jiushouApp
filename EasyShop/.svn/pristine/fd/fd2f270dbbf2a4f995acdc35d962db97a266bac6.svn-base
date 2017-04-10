//
//  ESEmptyViewController.m
//  EasyShop
//
//  Created by guojian on 16/5/28.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESEmptyViewController.h"

@interface ESEmptyViewController ()
{
    CGFloat left,top,width,height;
    CGFloat margin;
}

/** 按钮 */
@property (nonatomic,weak) UIButton *button;
/** title */
@property (nonatomic,weak) UILabel *titleLabel;

@end

@implementation ESEmptyViewController

- (void)setIsNetworking:(BOOL)isNetworking
{
    _isNetworking = isNetworking;
    
    self.button.hidden = _isNetworking;
    self.titleLabel.hidden = _isNetworking;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    width   = self.view.width;
    height  = self.view.height;
    
    CGFloat buttonW = 100;
    CGFloat buttonH = 30;
    left = (width - buttonW)/2;
    top = (height - buttonH)/2 - buttonH*2;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(left, top, buttonW, buttonH)];
    [button setTitle:@"刷新数据" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.borderWidth = 0.5;
    [self.view addSubview:button];
    self.button = button;
    CGFloat labelH = 30;
    left = 0;
    top = button.bottom + 15;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, top, width, labelH)];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"数据请求失败，请重试！";
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    self.isNetworking = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshAction
{
    if (self.RefreshBlock) {
        self.RefreshBlock();
    }
}

@end
