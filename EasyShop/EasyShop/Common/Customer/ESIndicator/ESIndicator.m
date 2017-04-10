//
//  ESIndicator.m
//  EasyShop
//
//  Created by guojian on 16/5/2.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESIndicator.h"
#import <MBProgressHUD.h>

@interface ESIndicator()

@property (nonatomic,strong) MBProgressHUD *hud;

@end

@implementation ESIndicator

- (MBProgressHUD *)hud
{
    if (!_hud)
    {
        _hud = [[MBProgressHUD alloc] initWithView:self];
        _hud.labelFont       = [UIFont systemFontOfSize:12];
        [self addSubview:_hud];
    }
    return _hud;
}

- (void)dealloc
{
    self.hud = nil;
}

+ (instancetype)indicatorToView:(UIView *)view
{
    ESIndicator *indicator  = [[self alloc] initWithFrame:view.bounds];
    indicator.hidden        = YES;
    [view addSubview:indicator];
    return indicator;
}

- (void)startAnimation
{
    self.hidden = NO;
    self.hud.labelText = nil;
    [self.hud show:YES];
}

- (void)startAnimationWithMessage:(NSString *)message
{
    self.hidden = NO;
    self.hud.labelText = message;
    [self.hud show:YES];
}

- (void)stopAnimation
{
    self.hidden = YES;
    self.hud.labelText = nil;
    [self.hud hide:YES];
}

@end
