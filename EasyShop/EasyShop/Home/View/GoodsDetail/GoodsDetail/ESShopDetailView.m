

//
//  ESShopDetailView.m
//  EasyShop
//
//  Created by wcz on 16/6/13.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShopDetailView.h"

@interface ESShopDetailView ()<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic,weak) UIWebView *webView;

@end

@implementation ESShopDetailView


- (void)setBody:(NSString *)body
{
    _body = body;
    
    [self.webView loadHTMLString:body baseURL:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIWebView *webView = [[UIWebView alloc] init];
        [self addSubview:webView];
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        self.webView.scrollView.delegate = self;
        self.webView = webView;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == 0) {
        self.webView.superview.userInteractionEnabled = YES;
    } else
    {
        self.webView.superview.userInteractionEnabled = NO;
    }
}

@end
