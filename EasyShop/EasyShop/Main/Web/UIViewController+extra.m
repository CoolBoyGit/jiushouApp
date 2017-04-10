//
//  UIViewController+extra.m
//  1111
//
//  Created by wcz on 16/6/16.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "UIViewController+extra.h"
#import <objc/runtime.h>
#import "HomeTitleView.h"


static const void *kHoldInsideBar = &kHoldInsideBar;

@interface UIViewController () <HomeTitleViewDelegate>

@end

@implementation UIViewController (extra)

//- (void)setIsNavHidden:(BOOL)isNavHidden
//{
//    objc_setAssociatedObject(self, kHoldInsideBar, @(isNavHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (BOOL)isNavHidden
//{
//    return objc_getAssociatedObject(self, kHoldInsideBar);
//}
//
//- (void)initalizedCumstomNav
//{
////            HomeTitleView *titleView=  [[HomeTitleView alloc] initWithTitle:self.title titleAlignment:NSTextAlignmentCenter leftImage:nil rightImage:nil leftText:nil rightText:nil];
////    
////            if (self.navigationController.viewControllers.count > 1)
////            {
////                [titleView changeLeftImage:[UIImage imageNamed:@"left_back"]];
////            }
////            titleView.titleLabel.text = self.title;
////            titleView.delegate = self;
////            titleView.backgroundColor = [UIColor whiteColor];
////            [self.view addSubview:titleView];
////            self.edgesForExtendedLayout = UIRectEdgeNone;
//    
//    HomeTitleView *titleView = [[HomeTitleView alloc] initWithTile:self.navigationItem.title?self.navigationItem.title:self.title withBackRuturn:self.navigationController.viewControllers.count > 1];
//    [self.view addSubview:titleView];
//    titleView.delegate = self;
//}


- (void)leftBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

//+ (void)load
//{
//    IMP orgIMP = class_getMethodImplementation([self class], @selector(viewDidLoad));
//    IMP newIMP = class_getMethodImplementation([self class], @selector(wc_viewDidLoad));
//    Method orginMe = class_getInstanceMethod([self class], @selector(viewDidLoad));
//    Method newMe = class_getInstanceMethod([self class], @selector(wc_viewDidLoad));
//    method_setImplementation(newMe, orgIMP);
//    method_setImplementation(orginMe, newIMP);
//}
//
//- (void)wc_viewDidLoad
//{
//    [self wc_viewDidLoad];
//    self.navigationController.navigationBar.hidden = YES;
//    if (!self.isNavHidden)
//    {
//        HomeTitleView *titleView=  [[HomeTitleView alloc] initWithTitle:self.title titleAlignment:NSTextAlignmentCenter leftImage:nil rightImage:nil leftText:nil rightText:nil];
//        if (self.navigationController.viewControllers.count > 1)
//        {
//            [titleView changeLeftImage:[UIImage imageNamed:@"left_back"]];
//        }
//        titleView.backgroundColor = [UIColor brownColor];
//        [self.view addSubview:titleView];
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
//
//}



@end
