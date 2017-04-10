//
//  ESRemindController.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/20.
//  Copyright © 2016年 wcz. All rights reserved.
//到货提醒界面

#import "ESRemindController.h"
#import "ESRemindLIstCell.h"

@interface ESRemindController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

/** 到货提醒 （item ：FavoritesGoodsInfo ） */
@property (nonatomic,strong) NSArray *remindItems;

@end

@implementation ESRemindController

- (void)viewDidLoad
{
    [super viewDidLoad];
    TitleCenter;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"到货提醒";
    [self.view addSubview:self.tableView];
//    [self initalizedCumstomNav];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@(0));
        make.bottom.equalTo(@-44);
    }];
    
    [self fetchRemindGoods];
}

#pragma mark
#pragma mark - tableview代理方法;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.remindItems.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //            NormalWebViewController *vc = [[NormalWebViewController alloc] init];
    //            vc.hidesBottomBarWhenPushed = YES;
    //            [self.navigationController pushViewController:vc animated:NO];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESRemindLIstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESRemindLIstCell"];
    cell.goodsInfo = [self.remindItems objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark
#pragma mark lazy init
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESRemindLIstCell class] forCellReuseIdentifier:@"ESRemindLIstCell"];
        @weakify(self);
        _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self fetchRemindGoods];
        }];
    }
    return _tableView;
}

#pragma mark - Networking
- (void)fetchRemindGoods
{
    GetFavoritesGoodsRequest *request = [GetFavoritesGoodsRequest request];
    request.type = @2;//到货提醒
    
    @weakify(self);
    [ESService getFavoritesGoodsRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        
        self.remindItems = response;
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
