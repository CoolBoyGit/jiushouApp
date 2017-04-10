//
//  PanicBuyingController.m
//  EasyShop
//
//  Created by wcz on 16/4/18.
//  Copyright © 2016年 wcz. All rights reserved.
//
//抢购页面
#import "ESPanicBuyingController.h"
#import "ESHomeSearchView.h"
#import "ESBannerScrollview.h"
#import "ESHomeProductCell.h"
#import "ESSingleTableViewCell.h"
#import "ESHomeCategaryView.h"
#import "ESHomeCategoryTitleView.h"
#import "ESHomeShopDetailController.h"

@interface ESPanicBuyingController ()<UITableViewDataSource,UITableViewDelegate>

/** ESBannerScrollview */
@property (nonatomic,weak) ESBannerScrollview *bannerView;

@property (nonatomic, strong) UITableView *tableView;

/** PanicInfo */
@property (nonatomic,strong) PanicInfo  *panicInfo;

@end

@implementation ESPanicBuyingController

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESHomeProductCell class] forCellReuseIdentifier:kIDESHomeProductCell];
    }
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"抢购";
    //    self.navigationItem.titleView = self.searchTextField;
    self.tableView.tableHeaderView = ({
      ESBannerScrollview *bannerView =   [[ESBannerScrollview alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*408/617.0+59)];
        self.bannerView = bannerView;
        bannerView;
    });
    [self.view addSubview:self.tableView];
//    [self initalizedCumstomNav];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self fetchPainc];
    }];
    
    [self fetchPainc];
}


#pragma mark - tableview代理方法;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.panicInfo.activeList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityInfo *info =   [self.panicInfo.activeList objectAtIndex:indexPath.row];
    //    if (info.haveGoods==YES) {
    //        return 0;
    //    }
    if (info.goods_list.count == 0) {
        return ScreenWidth*(408/617.0);
    }
    return ScreenWidth*(408/617.0)+230.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        ESHomeProductCell *cell = [tableView dequeueReusableCellWithIdentifier:kIDESHomeProductCell forIndexPath:indexPath];
    cell.activityInfo = [self.panicInfo.activeList objectAtIndex:indexPath.row];
        return cell;
}

#pragma mark - Networking
- (void)fetchPainc
{
    @weakify(self);
    [ESService panicRequestWithSuccess:^(PanicInfo *response) {
        @strongify(self);
        [self endGSNetworking];
        
        NavInfo * navInfo = [[NavInfo alloc] init];
        navInfo.nid = response.pid;
        navInfo.name = response.name;
        navInfo.m_banner = response.m_banner;
        self.bannerView.navInfo = navInfo;
        
        self.panicInfo = response;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}

#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.tableView.mj_header endRefreshing];
}

@end