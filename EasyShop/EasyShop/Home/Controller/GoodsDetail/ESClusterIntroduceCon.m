//
//  ESClusterIntroduceCon.m
//  EasyShop
//
//  Created by 就手国际 on 16/11/2.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterIntroduceCon.h"

@interface ESClusterIntroduceCon ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView*webView;
@end

@implementation ESClusterIntroduceCon

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"如何玩";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.jiushouguoji.hk/app/Guider/clusterBuyGuilder"]]];

    [self.view addSubview:self.webView];
    self.view.backgroundColor=RGB(247, 247, 247);
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom. equalTo(@0);
        make.top.equalTo(@64);
    }];
    
    // Do any additional setup after loading the view.
}
-(UIWebView *)webView{
    if (_webView==nil) {
        _webView=[[UIWebView alloc]init];
        _webView.scrollView. backgroundColor=RGB(247, 247, 247);
        _webView.scrollView.showsVerticalScrollIndicator=NO;
        [_webView setScalesPageToFit:YES];
    }
    return  _webView;
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
