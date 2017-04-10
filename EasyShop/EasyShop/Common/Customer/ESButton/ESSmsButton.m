//
//  ESSmsButton.m
//  EasyShop
//
//  Created by guojian on 16/6/4.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESSmsButton.h"
#import "NSString+GSRegex.h"

@interface ESSmsButton()

{
    int _flag;
    dispatch_source_t _timer;
}

@end

@implementation ESSmsButton

#pragma mark - Public
- (void)resetSmsButton
{
    [self stopTimer];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _flag=0;
        
        [self setTitle:@"验证" forState:UIControlStateNormal];
        self.titleLabel.textAlignment=NSTextAlignmentRight;
        [self addTarget:self action:@selector(smsAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)dealloc
{
    
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    
}

/** 获取验证码 */
- (void)smsAction
{
    if ([NSString isEmptyString:self.phone]) {
        [ESToast showError:@"请输入手机号！"];
        return;
    }
    if ([self.phone isInvalidPhone]) {
        [ESToast showError:@"无效的手机号！"];
        return;
    }
    
    [self getSmsVerifyCode];
    
    __block int timeout = 60; //倒计时时间
    @weakify(self);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{//block 执行事件
        @strongify(self);
        if(timeout <= 0){ //倒计时结束，关闭
            
            [self stopTimer];
        }else{
            NSString *strTime = [NSString stringWithFormat:@"%.2d", timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                DZLog(@"倒计时 - %@",strTime);
            self.enabled = NO;
            [self setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);//作用是恢复
}

- (void)stopTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        //设置界面的按钮显示 根据自己需求设置
        @strongify(self);
       
        self.enabled = YES;
        self.backgroundColor=[UIColor whiteColor];
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
    });
}

#pragma mark - Networking

- (void)getSmsVerifyCode
{
    GetSmsVerifyRequest *request = [GetSmsVerifyRequest request];
    request.mobile = self.phone;
    [ESService getSmsVerifyRequest:request success:^{
        TipViewAnimation*tipView=[[TipViewAnimation alloc]initWithFrame:CGRectZero andTip:@"验证码已成功发送,注意查收"];
        [tipView show];
        //[ESToast showSuccess:@"验证码获取成功"];
        self.enabled=NO;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            _flag=1;
//            
//        });
    } failure:^(NSError *error) {
    }];
}

@end