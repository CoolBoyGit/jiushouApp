//
//  ESMyOrderListController.m
//  EasyShop
//
//  Created by wcz on 16/4/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESMyOrderListController.h"
#import "ESMyOrderListCell.h"
#import "MyOrderHeaderView.h"
#import "MyOrderFooterView.h"
#import <UIAlertView+BlocksKit.h>
#import "PostCommentViewController.h"
#import "ESHomeShopDetailController.h"
#import "ESOrderDetailController.h"
#import "ESPayListController.h"
#import "ESESRefoundController.h"
#import "ESLogisticsController.h"
#import "ESRefundResultCon.h"
#import "ESProductViewCell.h"
#import "ESCollectHeaderView.h"
@interface ESMyOrderListController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView   *bottomCollectionView;
/** tableview */
@property (nonatomic,strong) UITableView *tableView;
/** page */
@property (nonatomic,assign) NSInteger page;
/** 订单 (item : OrderInfo ) */
@property (nonatomic,strong) NSMutableArray  *orderItems;

/** indicator */
@property (nonatomic,strong) ESIndicator *indicator;
@property (nonatomic,strong) NSMutableArray*relatItemArray;
//表示获取推荐商品的页数
@property (nonatomic,assign) NSInteger relaPage;

@end

@implementation ESMyOrderListController

- (NSMutableArray *)orderItems
{
    if (!_orderItems) {
        _orderItems = [NSMutableArray array];
    }
    return _orderItems;
}
-(NSMutableArray *)relatItemArray{
    if (_relatItemArray==nil) {
        _relatItemArray=[NSMutableArray array];
        
    }
    return _relatItemArray;
}
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
    
    [self addNotification];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
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
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    self.tableView.mj_footer=footer;
    
    
    [self.view addSubview:self.bottomCollectionView];
    [self.bottomCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    self.bottomCollectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getRelateGoodsList];
    }];
    MJRefreshAutoNormalFooter*nFooter=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self moreRelateGoodsList];
    }];
    [nFooter setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    self.bottomCollectionView.mj_footer=nFooter;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self refreshList];
}
- (void)dealloc
{
    [self removeNotification];
}

#pragma mark - Notification
- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadOrderList) name:kReloadRefoundOrderListNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadOrderList) name:kReloadOrderListNotification object:nil];
}
- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadOrderList
{
    [self refreshList];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.orderItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OrderInfo *info = [self.orderItems objectAtIndex:section];
    return info.order_goods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ESMyOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:kIDMyOrderListCell forIndexPath:indexPath];
    OrderInfo *info = [self.orderItems objectAtIndex:indexPath.section];
    cell.goodsInfo = [info.order_goods objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 75;
   // return kHeightMyOrderListCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderInfo *info = [self.orderItems objectAtIndex:indexPath.section];
    
    //订单详情
    
    //if (info.orderStatus != OrderStatus_Cancel) {//不是已取消订单
        ESOrderDetailController *detail = [[ESOrderDetailController alloc] init];
        detail.order_id = info.order_id;
        detail.totalMoney=[NSString stringWithFormat:@"%@",info.total_fee];
        [self.navigationController pushViewController:detail animated:YES];
    //}
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeightMyOrderHeader;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    OrderInfo *info = [self.orderItems objectAtIndex:section];
    return info.footerHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MyOrderHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kIDMyOrderHeader];
    headerView.orderInfo    = [self.orderItems objectAtIndex:section];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //订单页面的尾部;
    MyOrderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kIDMyOrderFooter];
    OrderInfo*orderInfo     = [self.orderItems objectAtIndex:section];
    //NSLog(@"%ld",self.orderItems.count);
    
    if (self.orderItems.count==0) {
        return footerView;
    }else{
        footerView.orderInfo    = orderInfo;
    }
    @weakify(self);
    footerView.cancleBlock  = ^{//取消订单/左边的按钮
        @strongify(self);
        [self cancleOrderAtSection:section];
    };
    footerView.rightBlock   = ^{
        @strongify(self);
        [self handleAtSection:section];
    };
    footerView.applyMoney =^{
        @strongify(self);
        if (orderInfo.refund_status.intValue==0) {
            ESESRefoundController *refoundVc=[[ESESRefoundController alloc]init];
            refoundVc.isRefound=YES;//代表的是申请退款
            refoundVc.orderInfo=orderInfo;
            
            [self.navigationController pushViewController:refoundVc animated:YES];
        }else{
            ESRefundResultCon *vc=[[ESRefundResultCon alloc]init];
            vc.isFromDetailOrder=NO;
            vc.reasonStr=@"退款";
            vc.order_id=orderInfo.order_id;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    };
    footerView.refoundBlock=^{
        ESESRefoundController *refoundVc=[[ESESRefoundController alloc]init];
        refoundVc.isRefound=NO;//代表的是申请退货
        refoundVc.orderInfo=orderInfo;
        [self.navigationController pushViewController:refoundVc animated:YES];
    };
    return footerView;
}
#pragma mark - 取消订单 尾部的左边的按钮的事件处理
- (void)cancleOrderAtSection:(NSInteger)section
{
    OrderInfo *orderInfo    = [self.orderItems objectAtIndex:section];
    switch (orderInfo.orderStatus) {
        case OrderStatus_Cancel://取消订单->取消订单
            
            break;
        case OrderStatus_WaitSend://待发货
            
            break;
        case OrderStatus_WaitPay://等待支付 -> 取消订单
        {
            [self cancelOrder:orderInfo];
        }
            break;
        case OrderStatus_WaitReply://待评价 -> 查看物流
        {
            ESLogisticsController*esLogitic=[[ESLogisticsController alloc]init];
            esLogitic.orderId=orderInfo.order_id;
            [self.navigationController pushViewController:esLogitic animated:YES];
        }
            break;
        case OrderStatus_WaitSure://待确认 -> 查看物流
        {
            ESLogisticsController*esLogitic=[[ESLogisticsController alloc]init];
            esLogitic.orderId=orderInfo.order_id;
            [self.navigationController pushViewController:esLogitic animated:YES];
            
        }
            break;
            
    }
}
#pragma mark 取消订单
-(void)cancelOrder:(OrderInfo*)order{
    CancelOrderRequest *request = [CancelOrderRequest request];
    request.order_id = order.order_id;
    
    @weakify(self);
    [self.indicator startAnimationWithMessage:@"正在取消订单..."];
    [ESService cancelOrderRequest:request success:^{
        @strongify(self);
        [self endGSNetworking];
        
        [ESToast showSuccess:@"取消订单成功!"];
        [[NSNotificationCenter defaultCenter]postNotificationName:KKUpdateAllOredrCountNotifacation object:nil];
        [self refreshList];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];

}
#pragma mark 点击footer右边的按钮触发的事件
- (void)handleAtSection:(NSInteger)section
{
    OrderInfo *info = [self.orderItems objectAtIndex:section];
    
    switch (info.orderStatus) {
        case OrderStatus_Cancel://取消订单
        case OrderStatus_WaitSend://待发货
            break;
        case OrderStatus_WaitPay://等待支付 -> 立即支付
        {
            ESPayListController *pay = [[ESPayListController alloc] init];
            pay.total_fee =  @(info.total_fee.integerValue)  ;
            pay.order_id = info.order_id;
            pay.isComFromOrderDetail=NO;
            [self.navigationController pushViewController:pay animated:YES];
        }
            break;
        case OrderStatus_WaitReply://待评价 -> 立刻评价
        {
            PostCommentViewController *vc=[[PostCommentViewController alloc]init];
            vc.orderInfo = info;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case OrderStatus_WaitSure://待确认 -> 确认收货
        {
            UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:@"确认收货" message:@"您确认收货吗？"];
            [alertView bk_addButtonWithTitle:@"取消" handler:nil];
            @weakify(self);
            [alertView bk_addButtonWithTitle:@"确认收货" handler:^{//进入评论页面
                @strongify(self);
                        [self comfirmOrderAtSection:section];
                
            }];
            [alertView show];
            

        }
            break;
            
    }
}


#pragma mark - Lazy

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        //_tableView.showsVerticalScrollIndicator=NO;
        _tableView.backgroundColor=RGBA(247, 247, 247, 1);
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESMyOrderListCell class] forCellReuseIdentifier:kIDMyOrderListCell];
        [_tableView registerClass:[MyOrderHeaderView class] forHeaderFooterViewReuseIdentifier:kIDMyOrderHeader];
        [_tableView registerClass:[MyOrderFooterView class] forHeaderFooterViewReuseIdentifier:kIDMyOrderFooter];
    }
    return _tableView;
}
- (UICollectionView*)bottomCollectionView
{
    if(!_bottomCollectionView)
    {
        UICollectionViewFlowLayout *flowRight = [[UICollectionViewFlowLayout alloc] init];
        flowRight.scrollDirection = UICollectionViewScrollDirectionVertical;
        _bottomCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:flowRight];
        _bottomCollectionView.dataSource = self;
        _bottomCollectionView.delegate = self;
        _bottomCollectionView.scrollEnabled = YES;
        _bottomCollectionView.hidden=YES;
        [_bottomCollectionView registerClass:[ESCollectHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ESCollectHeaderView"];
        _bottomCollectionView.showsVerticalScrollIndicator = NO;
        _bottomCollectionView.showsHorizontalScrollIndicator = NO;
       [_bottomCollectionView setBackgroundColor:RGB(247, 247, 247)];
      //  _bottomCollectionView.backgroundColor=[UIColor yellowColor];
        [_bottomCollectionView registerClass:[ESProductViewCell class] forCellWithReuseIdentifier:@"ESProductViewCell"];
    }
    return _bottomCollectionView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth, 300);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
            if (kind == UICollectionElementKindSectionHeader) {
            ESCollectHeaderView*heardView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ESCollectHeaderView" forIndexPath:indexPath];
            return heardView;
//            ESShopSearchReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ESShopSearchReusableView" forIndexPath:indexPath];
//            reusableview.title = @"热搜" ;
//            return reusableview;
            
        }
    return nil;
        
}
    
#pragma mark - UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.relatItemArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESProductViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESProductViewCell" forIndexPath:indexPath];
    cell.goodsInfo = [self.relatItemArray objectAtIndex:indexPath.item];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth-3)/2.0,(ScreenWidth-3)/2.0+65) ;
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
//设置列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsInfo *info = [self.relatItemArray objectAtIndex:indexPath.item];
    ESHomeShopDetailController*detail=[[ESHomeShopDetailController alloc]init];
    detail.goods_id=info.gid;
    [self .navigationController pushViewController:detail animated:YES];
}

#pragma mark - Networking
//确认收货
- (void)comfirmOrderAtSection:(NSInteger)section
{
    OrderInfo *orderInfo    = [self.orderItems objectAtIndex:section];
    
    ComfirmOrderRequest *request = [ComfirmOrderRequest request];
    request.order_id = orderInfo.order_id;
    
    @weakify(self);
    [self.indicator startAnimationWithMessage:@"正在确认收货..."];
    [ESService comfirmOrderRequest:request success:^{
        @strongify(self);
        [self endGSNetworking];
        
        [ESToast showSuccess:@"确认收货成功！"];
        [[NSNotificationCenter defaultCenter]postNotificationName:KKUpdateAllOredrCountNotifacation object:nil];
        [self refreshList];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}
#pragma mark 请求推荐商品
-(void)getRelateGoodsList{
    self.relaPage = 1;
    [self fetchGoods];
}
-(void)moreRelateGoodsList{
    self.relaPage++;
    [self fetchGoods];
}
//请求底部的collection的数据
-(void)fetchGoods{
    GoodsRequest*request=[GoodsRequest request];
    request.page=[NSNumber numberWithInteger:self.relaPage];
    request.n=[NSNumber numberWithInt:10];
    request.orderBy=[NSNumber numberWithInt:2];
    @weakify(self);
    [ESService goodsRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        if (self.relaPage==1) {
            [self.relatItemArray removeAllObjects];
        }
        if (response.count < 7) {
            [self.bottomCollectionView.mj_footer endRefreshingWithNoMoreData];
        } else
        {
            [self.bottomCollectionView.mj_footer resetNoMoreData];
        }
        [self.relatItemArray addObjectsFromArray:response];
        [self.bottomCollectionView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
        
    }];
    
}

#pragma mark - 请求订单
- (void)refreshList
{
    self.page = 1;
    [self fetchOrder];
}
- (void)moreList
{
    self.page ++;
    [self fetchOrder];
}

- (void)fetchOrder
{
    OrderRequest *request = [OrderRequest request];
    request.type = [NSNumber numberWithInt:self.orderType];
    request.page = [NSNumber numberWithInteger:self.page];
    request.n    = @8;
    
    @weakify(self);
    [ESService orderRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        
        if (self.page == 1) {
            if (response.count==0) {
                self.bottomCollectionView.hidden=NO;
                self.tableView.hidden=YES;
                [self getRelateGoodsList];
                return ;
            }else{
                self.tableView.hidden=NO;
                self.bottomCollectionView.hidden=YES;
            }
            [self.orderItems removeAllObjects];
        }
        [self.orderItems addObjectsFromArray:response];
        [self.tableView reloadData];
        if (response.count < 7) {
            self.tableView.mj_footer.hidden=YES;
        }
//        else
//        {
//            [self.tableView.mj_footer resetNoMoreData];
//        }
        
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}

#pragma mark GSNetworking
#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.indicator stopAnimation];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.bottomCollectionView .mj_footer endRefreshing];
    [self.bottomCollectionView.mj_header endRefreshing];
}


@end
