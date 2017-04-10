//
//  NormalWebViewController.h
//  MFBank
//
//  Created by 脉融iOS开发 on 15/11/24.
//  Copyright (c) 2015年 MFBank. All rights reserved.
//

#import "NormalWebViewController.h"

@interface NormalWebViewController ()<UIWebViewDelegate>

@end

@implementation NormalWebViewController
@dynamic title;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=RGBA(247, 247, 247, 1);
   self.navigationItem.title= self.title;

    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    web.scalesPageToFit = YES;
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    web.scrollView.backgroundColor=RGB(247, 247, 247);
    web.delegate = self;
    [self.view addSubview:web];
}

@end
