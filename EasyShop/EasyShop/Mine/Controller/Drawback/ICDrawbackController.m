

//
//  ICDrawbackController.m
//  EasyShop
//
//  Created by wcz on 16/4/23.
//  Copyright © 2016年 wcz. All rights reserved.
//
//退货退款界面
#import "ICDrawbackController.h"
#import "ESDrawbackCell.h"
#import "ESMyOrderListCell.h"
#import "MyOrderHeaderView.h"
#import "ESOrderDetailController.h"

@interface ICDrawbackController ()<UITableViewDataSource,UITableViewDelegate>//<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//@property (nonatomic, strong) UICollectionView *collectionview;
/** tableview */
@property (nonatomic,strong) UITableView *tableView;

/** from */
@property (nonatomic,assign) NSInteger page;
/** 退货订单信息 （item ：OrderInfo ） */
@property (nonatomic,strong) NSMutableArray *returnItems;

@end
@implementation ICDrawbackController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"退货/退款";
    //TitleCenter;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@64);
    }];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshList];
    }];
    MJRefreshAutoNormalFooter*footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self moreList];
    }];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    self.tableView.mj_footer=footer;
    [self refreshList];
    
}


- (NSMutableArray *)returnItems
{
    if (!_returnItems) {
        _returnItems = [NSMutableArray array];
    }
    return _returnItems;
}


- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.backgroundColor=RGBA(247, 247, 247, 1);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESMyOrderListCell class] forCellReuseIdentifier:kIDMyOrderListCell];
        [_tableView registerClass:[MyOrderHeaderView class] forHeaderFooterViewReuseIdentifier:kIDMyOrderHeader];
//        [_tableView registerClass:[MyOrderFooterView class] forHeaderFooterViewReuseIdentifier:kIDMyOrderFooter];
    }
    return _tableView;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.returnItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OrderInfo *info = [self.returnItems objectAtIndex:section];
    return info.order_goods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESMyOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:kIDMyOrderListCell forIndexPath:indexPath];
    OrderInfo *info = [self.returnItems objectAtIndex:indexPath.section];
    cell.goodsInfo = [info.order_goods objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderInfo *info = [self.returnItems objectAtIndex:indexPath.section];
//    if (info.orderStatus != OrderStatus_Cancel) {//不是已取消订单
//        ESOrderDetailController *detail = [[ESOrderDetailController alloc] init];
//        detail.order_id = info.order_id;
//        [self.navigationController pushViewController:detail animated:YES];
//    }/
    ESOrderDetailController *detail = [[ESOrderDetailController alloc] init];
    detail.order_id = info.order_id;
    [self.navigationController pushViewController:detail animated:YES];

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeightMyOrderHeader;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MyOrderHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kIDMyOrderHeader];
    headerView.orderInfo    = [self.returnItems objectAtIndex:section];
    return headerView;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView*view=[[UIView alloc]init];
    view.backgroundColor=RGBA(247, 247, 247, 1);
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
#pragma mark - Networking

#pragma mark 请求退货退款订单
- (void)refreshList
{
    self.page = 1;
    [self fetchReturnList];
}
- (void)moreList
{
    self.page ++ ;
    [self fetchReturnList];
}

- (void)fetchReturnList
{
    GetReturnListRequest *request = [GetReturnListRequest request];
    request.status = @0;
    request.page = [NSNumber numberWithInteger:self.page];
    request.n = @20;
    
    @weakify(self);
    [ESService getReturnListRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        
        if (self.page == 1) {
            [self.returnItems removeAllObjects];
        }
//        self.tableView.mj_footer.hidden = response.count < 20;
        if (response.count < 20) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else
        {
            [self.tableView.mj_footer resetNoMoreData];
        }
        
        [self.returnItems addObjectsFromArray:response];
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
    [self.tableView.mj_footer endRefreshing];
}

@end