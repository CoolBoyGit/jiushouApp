//
//  ESFeedbackController.m
//  EasyShop
//
//  Created by wcz on 16/6/23.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESFeedbackController.h"
#import "TextView.h"
#import "TypeView.h"
@interface ESFeedbackController ()<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) UIView *TypeView;
@property (nonatomic,strong) UIView *ContentView;
@property (nonatomic,strong) UIView *ContactView;
@property (nonatomic,strong) UITextField *tf;
@property (nonatomic,strong) TextView    *tv;
@end

@implementation ESFeedbackController


- (void)viewDidLoad {
    [super viewDidLoad];
    TitleCenter;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.98f green:0.98f blue:0.98f alpha:1.00f];
    self.navigationItem.title = @"意见反馈";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:0 target:self action:nil];
    
    _scroll = [[UIScrollView alloc] init];
    [self.view addSubview:_scroll];
    [_scroll addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)]];
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self ViewAll];
    [self typeViewConfig];
    [self ContentViewConfig];
    [self ContactViewConfig];
}
- (void)ViewAll {
    
    _TypeView = [[UIView alloc] init];
    [_scroll addSubview:_TypeView];
    [_TypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(215);
    }];
    
    
    _ContentView = [[UIView alloc] init];
    [_scroll addSubview:_ContentView];
    [_ContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_TypeView.mas_bottom).offset(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(215);
    }];
    
    _ContactView = [[UIView alloc] init];
    [_scroll addSubview:_ContactView];
    [_ContactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_ContentView.mas_bottom).offset(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(124);
        make.bottom.mas_equalTo(_scroll.mas_bottom).offset(0);
    }];
    
}
- (void)typeViewConfig {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"反馈类型";
    label.textColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.00f];
    [_TypeView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(65);
    }];
    
    TypeView *back = [[TypeView alloc] init];
    back.layer.borderColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f].CGColor;
    back.layer.borderWidth = 1;
    back.backgroundColor = [UIColor whiteColor];
    [_TypeView addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(label.mas_bottom).offset(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(150);
    }];
    
    
    
}
- (void)ContentViewConfig {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"反馈内容";
    label.textColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.00f];
    
    [_ContentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(65);
    }];
    
    _tv = [[TextView alloc] init];
    _tv.placeHolder = @"    乐意聆听对于手机客户端的任何意见或建议!";
    _tv.layer.borderColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f].CGColor;
    [_ContentView addSubview:_tv];
    [_tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(label.mas_bottom).offset(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(150);
    }];
    
}
- (void)ContactViewConfig {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"联系方式";
    label.textColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.00f];
    [_ContactView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(65);
    }];
    
    _tf = [[UITextField alloc] init];
    _tf.placeholder = @"    请输入手机号或邮箱(选填)";
    _tf.layer.borderColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f].CGColor;
    _tf.font = [UIFont systemFontOfSize:13];
    _tf.backgroundColor = [UIColor whiteColor];
    _tf.delegate = self;
    [_ContactView addSubview:_tf];
    [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(label.mas_bottom).offset(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(54);
    }];
}

- (void)endEdit {
    [self.view endEditing:YES];
}


@end
