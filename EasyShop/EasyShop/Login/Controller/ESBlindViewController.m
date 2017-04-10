//
//  ESBlindViewController.m
//  EasyShop
//
//  Created by wcz on 16/6/2.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESBlindViewController.h"
#import "ESThirdRegisterView.h"
#import "ESThirdBlindView.h"

@interface ESBlindViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *registerLabel;
@property (nonatomic, strong) UILabel *blindLabel;
@property (nonatomic,strong)UIScrollView *scrollview;
/** Indicator */
@property (nonatomic,strong) ESIndicator *indicator;
@end

@implementation ESBlindViewController
#pragma mark - <uigesturerecognizerdelegate>
//实现代理方法:return YES :手势有效, NO :手势无效
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    //当导航控制器的子控制器个数 大于1 手势才有效
    return self.navigationController.viewControllers.count > 1;
}
- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _lineView;
}

-(void)exitKeyboard{
    [self.view endEditing:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"绑定";
    self.view.backgroundColor = [UIColor whiteColor];
        self.scrollview = [[UIScrollView alloc] init];
    self.scrollview.pagingEnabled = YES;
    self.scrollview.alwaysBounceHorizontal=YES;
    [self.scrollview setShowsHorizontalScrollIndicator:NO];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitKeyboard)];
    [self.scrollview addGestureRecognizer:tap];
    self.scrollview.contentSize = CGSizeMake(ScreenWidth *2, 0);
    self.scrollview.delegate = self;
    //self.scrollview.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:self.scrollview];
   // self.scrollview.backgroundColor=[UIColor yellowColor];
    [self.scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.width.equalTo(@(ScreenWidth));
        make.top.equalTo(@(194));
        make.bottom.equalTo(@0);
    }];
    //绑定的页面
    ESThirdRegisterView *registerView= [[ESThirdRegisterView alloc] init];
    registerView.backgroundColor = [UIColor whiteColor];
    [self.scrollview addSubview:registerView];
    [registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(ScreenHeight-130));
        make.top.equalTo(@(-40));
    }];
    @weakify(self);
    registerView.bindBlock = ^(NSString *moblie,NSString *smsCode){
        @strongify(self);
     
        [self userBindingMoblie:moblie code:smsCode pwd:nil];
    };
    //绑定注册
    ESThirdBlindView *blindView= [[ESThirdBlindView alloc] init];
    blindView.backgroundColor = [UIColor whiteColor];
    [self.scrollview addSubview:blindView];
    [blindView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(-40));
        make.left.equalTo(@(ScreenWidth));
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(ScreenHeight-130));
    }];
    blindView.bindBlock = ^(NSString *moblie,NSString *smsCode,NSString *pwd){
        @strongify(self);
        if ([self isIntThePassWord:pwd]) {
            
            return ;
        }
        [self userBindingMoblie:moblie code:smsCode pwd:pwd];
    };
    
    self.registerLabel = [[UILabel alloc] init];
    self.registerLabel.text = @"您已有就手账号";
    self.registerLabel.userInteractionEnabled=YES;
    self.registerLabel.font = [UIFont systemFontOfSize:15];
    self.registerLabel.textColor = LoginComColor;
    self.registerLabel.textAlignment  = NSTextAlignmentCenter;
    UITapGestureRecognizer* tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushScrollview)];
    [self.registerLabel addGestureRecognizer:tap1];
    self.registerLabel = self.registerLabel;
    [self.view addSubview:self.registerLabel];
    [self.registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.right.equalTo(self.view.mas_centerX);
        make.height.equalTo(@35);
        make.bottom.equalTo(self.scrollview.mas_top);
        //make.top.equalTo(@125);
    }];
    
    self.blindLabel = [[UILabel alloc] init];
    self.blindLabel.userInteractionEnabled=YES;
    self.blindLabel.text = @"您没有就手账号";
    self.blindLabel = self.blindLabel;
    self.blindLabel.textColor = LoginComColor;
    self.blindLabel.font = [UIFont systemFontOfSize:15];
    self.blindLabel.textAlignment  = NSTextAlignmentCenter;
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushRegisterAndBlind)];
    [self.blindLabel addGestureRecognizer:tap2];
    [self.view addSubview:self.blindLabel];
    [self.blindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-40));
        make.left.equalTo(self.view.mas_centerX);
        make.height.equalTo(@35);
        make.bottom.equalTo(self.scrollview.mas_top);
        //make.top.equalTo(@125);
    }];
    
    UIView *lineView= [[UIView alloc] init];
    [self.view addSubview:lineView];
    lineView.backgroundColor = [UIColor whiteColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.right.equalTo(@(-40));
        make.height.equalTo(@.5);
        make.bottom.equalTo(self.blindLabel);
    }];
    [self.view addSubview:self.lineView];
    self.lineView.backgroundColor = RGB(233, 40, 46);
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.registerLabel);
        make.width.equalTo(@(110));
        make.height.equalTo(@2);
        make.bottom.equalTo(lineView);
    }];

}
-(void)pushScrollview{
     [self.scrollview setContentOffset:CGPointMake(0, self.scrollview.contentOffset.y) animated:YES];
    [UIView animateWithDuration:1 animations:^{
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.registerLabel);
            make.width.equalTo(@(110));
            make.height.equalTo(@2);
            make.bottom.equalTo(self.scrollview.mas_top);
        }];
    }];

}
-(void)pushRegisterAndBlind{
    [self.scrollview setContentOffset:CGPointMake(ScreenWidth, self.scrollview.contentOffset.y) animated:YES];
    [UIView animateWithDuration:1 animations:^{
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.blindLabel);
            make.width.equalTo(@(110));
            make.height.equalTo(@2);
            make.bottom.equalTo(self.scrollview.mas_top);
        }];
    }];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x /ScreenWidth != 1) {
        [UIView animateWithDuration:1 animations:^{
            [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.registerLabel);
                make.width.equalTo(@(110));
                make.height.equalTo(@2);
                make.bottom.equalTo(scrollView.mas_top);
            }];
        }];
        
    } else
    {
        [UIView animateWithDuration:1 animations:^{
            [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.blindLabel);
                make.width.equalTo(@(110));
                make.height.equalTo(@2);
                make.bottom.equalTo(scrollView.mas_top);
            }];
        }];
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Networking
- (void)userBindingMoblie:(NSString *)moblie code:(NSString *)code pwd:(NSString *)pwd
{
    UserBindingRequest *request = [UserBindingRequest request];
    request.mobile = moblie;
    request.verify = code;
    request.password = pwd;
    request.open_id = self.open_id;
    switch (self.bindType) {
        case ESBindType_Wechat://微信
        {
            request.type = @1;
        }
            break;
        case ESBindType_QQ://QQ
        {
            request.type = @2;
        }
            break;
        default:
            break;
    }
    @weakify(self);
    [self.indicator startAnimation];
    [ESService userBindingRequest:request success:^{
        @strongify(self);
        [self endGSNetworking];
        
        [ESToast showSuccess:@"绑定成功！"];
        
        NSDictionary *dict = @{@"type":request.type,@"open_id":request.open_id};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kDidBindSuccessNotification object:nil userInfo:dict];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}
/**
 *  判断是不是纯数字
 */
-(BOOL)isIntThePassWord:(NSString*)passWord{
    NSString *regex =@"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:passWord]) {
        return YES;
    }
    return NO;
}
#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.indicator stopAnimation];
}

@end
