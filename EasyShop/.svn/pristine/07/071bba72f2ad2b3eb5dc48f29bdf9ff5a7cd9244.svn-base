//
//  ESShareController.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/18.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShareController.h"
#import "ESBannerScrollview.h"
#import "ESShareScrollviewCell.h"
#import "ESShareFunctionCell.h"
#import "NJShareView.h"
#import "ESForumPageController.h"
#import "ESImagePickerController.h"
#import "CreateCommentViewController.h"
#import "ESForumPushCell.h"
#import "ESShareHeaderView.h"
#import "ESSharePageController.h"
#import "ESCommentController.h"


@interface ESShareController()<UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate,HomePushCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

/** 分享items （item : ShareFeedInfo ） */
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic,strong) NSMutableArray *feedItems;
/** page */
@property (nonatomic,assign) NSInteger page;
@property (nonatomic, strong) ESShareScrollviewCell *cell;

@end

@implementation ESShareController

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESForumPushCell  class] forCellReuseIdentifier:@"ESForumPushCell"];

        [_tableView registerClass:[ESShareScrollviewCell  class] forCellReuseIdentifier:@"ESShareScrollviewCell"];
    }
    return _tableView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"分享";
    self.tabBarController.delegate = self;
    self.selectIndex = 2;
//    [self initalizedCumstomNav];
    self.tableView.tableHeaderView = [[ESBannerScrollview alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 200)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
}

#pragma mark
#pragma mark - tableview代理方法;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ESShareHeaderView *view = [[ESShareHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
//    view.backgroundColor = [UIColor redColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 170;
    }
    return ScreenHeight - 69 - 49 -44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ESForumPushCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESForumPushCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    } else {
        ESShareScrollviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESShareScrollviewCell"];
       cell.userInteractionEnabled = NO;
        self.cell = cell;

//        cell.delegate = self;
//        cell.feedInfo  = [self.feedItems objectAtIndex:indexPath.row];
        return cell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= 295) {
       self.cell.userInteractionEnabled = NO;
    }else
    {
       self.cell.userInteractionEnabled = YES;
    }
//    self.cell.userInteractionEnabled = YES;
}

- (void)clickHomePush:(NSInteger)tag
{
    
    ESSharePageController *controller = [[ESSharePageController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ESCommentController *vc = [[ESCommentController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
}
//- (NSMutableArray *)feedItems
//{
//    if (!_feedItems) {
//        _feedItems = [NSMutableArray array];
//    }
//    return _feedItems;
//}
//
//#pragma mark - LifeCycle
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.title = @"分享社区";
//    self.tableView.tableHeaderView = [[ESBannerScrollview alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 200)];
//    self.tabBarController.delegate = self;
//    self.selectIndex = 2;
//
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(@0);
//    }];
//    
//    @weakify(self);
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        @strongify(self);
//        [self refreshList];
//    }];
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//       @strongify(self);
//        [self moreList];
//    }];
//    
//    [self refreshList];
//}
//
//#pragma mark
//#pragma mark - tableview代理方法;
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 1;
//    }
//    return self.feedItems.count;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 1) {
//        return 360;
//    }
//    return 44;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    
//    ESForumPageController *vc = [[ESForumPageController alloc] init];
//    [self.navigationController pushViewController:vc animated:NO];
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0) {
//        ESShareFunctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESShareFunctionCell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    } else {
//        ESShareListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESShareListCell"];
//        cell.delegate = self;
//        cell.feedInfo  = [self.feedItems objectAtIndex:indexPath.row];
//        return cell;
//    }
//}
//
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    UINavigationController *nav = (UINavigationController *)viewController;
    
    if ( self.selectIndex == 2 && [nav.topViewController isKindOfClass:[self class]])
    {
        ESImagePickerController *controller = [[ESImagePickerController alloc] init];

        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        [controller setCallBack:^(NSArray *array) {
            CreateCommentViewController *controller = [[CreateCommentViewController alloc] init];

            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];

            controller.imageArray =array;
            
            [self presentViewController:navController animated:YES completion:^{
                
            }];
            
        }];
        [self presentViewController:nav animated:NO completion:^{
            
        }];
    }
    self.selectIndex = self.tabBarController.selectedIndex;
}
//
//
//#pragma mark
//#pragma mark - Other delagate
//-(void)ESShareListCellShare
//{
//    NJShareView *vc = [[NJShareView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
//    [vc show];
//}
//
//#pragma mark
//#pragma mark - lazy init
//- (UITableView *)tableView
//{
//    if (_tableView == nil) {
//        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.delegate = self;
//        _tableView.tableFooterView = [[UIView alloc] init];
//        [_tableView registerClass:[ESShareListCell  class] forCellReuseIdentifier:@"ESShareListCell"];
//        [_tableView registerClass:[ESShareFunctionCell class] forCellReuseIdentifier:@"ESShareFunctionCell"];
//    }
//    return _tableView;
//}
//
//#pragma mark - Networking
//- (void)refreshList
//{
//    self.page = 1;
//    [self fetchMyShare];
//}
//- (void)moreList
//{
//    self.page++;
//    [self fetchMyShare];
//}
//
//- (void)fetchMyShare
//{
//    ShareFeedRequest *request = [ShareFeedRequest request];
//    request.page    = [NSNumber numberWithInteger:self.page];
//    request.n       = @10;
//    
//    @weakify(self);
//    [ESService shareFeedRequest:request success:^(NSArray *response) {
//        @strongify(self);
//        [self endGSNetworking];
//        
//        self.tableView.mj_footer.hidden = response.count < 10;
//        
//        if (self.page == 1) {
//            [self.feedItems removeAllObjects];
//        }
//        [self.feedItems addObjectsFromArray:response];
//        [self.tableView reloadData];
//        
//    } failure:^(NSError *error) {
//        @strongify(self);
//        [self endGSNetworking];
//    }];
//    
//}
//
//#pragma mark GSNetworking
//- (void)endGSNetworking
//{
//    [self.tableView.mj_header endRefreshing];
//    [self.tableView.mj_footer endRefreshing];
//}

@end
