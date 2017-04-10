//
//  ESShipAddressListController.m
//  EasyShop
//
//  Created by wcz on 16/5/29.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShipAddressListController.h"
#import "ESShipAddressCell.h"
@interface ESShipAddressListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

/** 地址items （item ：AddressInfo ） */
@property (nonatomic,strong) NSArray *addressItems;

/** indicator */
@property (nonatomic,strong) ESIndicator *indicator;

@end

@implementation ESShipAddressListController

- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];

    self.navigationItem.title = @"收货地址";
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@64);
    }];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self fetchAddressList];
    }];
    
    [self fetchAddressList];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[ESShipAddressCell class] forCellReuseIdentifier:@"cell"];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.addressItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESShipAddressCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.addressInfo = [self.addressItems objectAtIndex:indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.addressBlock) {
        AddressInfo *info = [self.addressItems objectAtIndex:indexPath.section];
        self.addressBlock(info);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 请求地址列表
- (void)fetchAddressList
{
    GetAddressListRequest *request = [GetAddressListRequest request];
    
    @weakify(self);
    [self.indicator startAnimation];
    [ESService getAddressListRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        
        self.addressItems = response;
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}

#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.indicator stopAnimation];
    [self.tableView.mj_header endRefreshing];
}


@end
