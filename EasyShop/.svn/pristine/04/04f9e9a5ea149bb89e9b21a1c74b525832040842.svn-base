//
//  ESSharePageController.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/18.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESSharePageController.h"
#import "ESForumPageController.h"
#import "ESShareController.h"
#import "ESForumTopView.h"
#import "CreateCommentViewController.h"

@interface ESSharePageController () <UIScrollViewDelegate,UITabBarControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ESShareController *myServiceVc;
@property (nonatomic, strong) ESForumPageController *planServiceVc;
@property (nonatomic, strong) ESForumTopView *topView;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation ESSharePageController

- (UIScrollView *)scrollView
{
    if (_scrollView == nil)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(ScreenWidth * 2, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationItem.title = @"分享社区";
//    [self.tabBarController setValue:self forKey:@"tabDelegate"];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    ESForumTopView *topView = [[ESForumTopView alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    self.topView = topView;
    __weak typeof(self) weakify = self;
    
    [self.topView setButtonSelect:^(NSInteger index) {
        weakify.scrollView.contentOffset = CGPointMake(ScreenWidth * index, 0);
    }];
    self.tabBarController.delegate = self;
    self.selectIndex = 2;
    self.navigationItem.titleView = topView;
    [self initalizedView];
}


- (void)initalizedView
{
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.right.equalTo(@0);
        make.height.equalTo(@(ScreenHeight - 49 -64));
    }];
    
    self.planServiceVc = [[ESForumPageController alloc] init];
    [self.scrollView addSubview:self.planServiceVc.view];

    [self addChildViewController:self.planServiceVc];
    [self.planServiceVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@(0));
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(ScreenHeight - 49 - 64));
    }];
    
    
    self.myServiceVc = [[ESShareController alloc] init];
    
    [self addChildViewController:self.myServiceVc];
    [self.scrollView addSubview:self.myServiceVc.view];
    [self.myServiceVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@(ScreenWidth));
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(ScreenHeight - 49 - 64));
    }];
    
}

//-(void)ESTabBarControllerDidSelect
//{
//    CreateCommentViewController *controller = [[CreateCommentViewController alloc] init];
////    [self presentViewController:cont animated:<#(BOOL)#> completion:<#^(void)completion#>:controller completion:nil];
//    [self.navigationController pushViewController:controller animated:YES];
//}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    UINavigationController *nav = (UINavigationController *)viewController;
    if ( self.selectIndex == 2 && [nav.topViewController isKindOfClass:[ESSharePageController class]])
    {
        CreateCommentViewController *controller = [[CreateCommentViewController alloc] init];
        //    [self presentViewController:cont animated:<#(BOOL)#> completion:<#^(void)completion#>:controller completion:nil];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    self.selectIndex = self.tabBarController.selectedIndex;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    if (scrollView.contentOffset.x / ScreenWidth == 0) {
//
//    }
    [self.topView scrollviewToIndex:scrollView.contentOffset.x / ScreenWidth];
}


@end
