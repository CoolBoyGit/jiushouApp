//
//  ESScanWebController.m
//  EasyShop
//
//  Created by jiushou on 16/6/14.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESScanWebController.h"
#import "ESIndicator.h"
@interface ESScanWebController ()<UIWebViewDelegate>
@property (nonatomic ,strong)UIWebView*scanWebView;
/** indicator */
@property (nonatomic,strong) ESIndicator *indicator;
@end

@implementation ESScanWebController
- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}

-(UIWebView *)scanWebView{
    if (_scanWebView==nil) {
        _scanWebView= [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _scanWebView.delegate=self;
        NSURLRequest*request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.url]];
        [_scanWebView loadRequest:request];
    }
    return _scanWebView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.dk_barTintColorPicker=DKColorPickerWithKey(BG);
    [self.view addSubview:self.scanWebView];
    [self.scanWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
    }];
    // Do any additional setup after loading the view.
}
#pragma mark 网页开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView{
   [ESToast showSuccess:@"开始加载"];
    
}
#pragma mark 网页完成加载
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [ESToast showSuccess:@"加载完成"];
}
#pragma mark 加载失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
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
