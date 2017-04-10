//
//  StatusBarScrollViewTool.m
//  EasyShop
//
//  Created by guojian on 16/7/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "StatusBarScrollViewTool.h"

@implementation StatusBarScrollViewTool

+ (void)scrollViewScrollToTop
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)view
{
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]] && [self isShowingOnKeyWindow:view]) {
            UIScrollView *scrollView = (UIScrollView *)subView;
            
            CGPoint offset = scrollView.contentOffset;
            offset.y = -scrollView.contentInset.top;
            [scrollView setContentOffset:offset animated:YES];
        }
        [self searchScrollViewInView:subView];
    }
}

+ (BOOL)isShowingOnKeyWindow:(UIView *)view
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect newFrame = [keyWindow convertRect:view.frame fromView:view.superview];
    CGRect winBounds = keyWindow.bounds;
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    return !view.isHidden && view.alpha > 0.01 && view.window == keyWindow && intersects;
}


@end
