//
//  ESOrderDetailController.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/11.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESOrderDetailController.h"
#import "ESOrderStateView.h"
#import "ESOrderAddressCell.h"
#import "ESOrderShopCell.h"
#import "ESOrderPriceCell.h"
#import "ESLogisticsCell.h"
#import "ESOrderTimeCell.h"
#import "ESOrderBottonCell.h"
#import "ESHomeShopDetailController.h"
#import "OrderDetailBottomView.h"
#import "OrderFooterView.h"
#import "ESESRefoundController.h"
#import "ESHomeShopDetailController.h"
#import "ESPayListController.h"
#import "ESFootViewGray.h"
#import "ESLogisticsController.h"
#import "ESRefundResultCon.h"
#import "PostCommentViewController.h"
#import "ESPayListController.h"

@interface ESOrderDetailController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ESOrderStateView *headerView;
/** footer */
@property (nonatomic,strong) OrderFooterView *footerView;
/** BottomView */
@property (nonatomic,strong) ESFootViewGray *footView;
@property (nonatomic,strong) OrderDetailBottomView *bottomView;

/** 订单详情信息 */
@property (nonatomic,strong) OrderDetailInfo *detailInfo;
/** indicator */
@property (nonatomic,strong) ESIndicator *indicator;

@end

@implementation ESOrderDetailController

- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}

- (OrderDetailBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[OrderDetailBottomView alloc] init];
        @weakify(self);
        _bottomView.RefoundBlock=^{//申请退货 
            @strongify(self);
            ESESRefoundController *esRefound=[[ESESRefoundController alloc]init];
            esRefound.orderInfo=self.detailInfo;
            esRefound.isRefound=NO;
            
            [self.navigationController pushViewController:esRefound animated:YES];
        };
        _bottomView.leftBlock = ^{//
            @strongify(self);
            switch (self.detailInfo.orderStatus) {
                case OrderStatus_WaitSend://退款
                {
                    @strongify(self);
                    ESESRefoundController *esRefound=[[ESESRefoundController alloc]init];
                    esRefound.orderInfo=self.detailInfo;
                    esRefound.isRefound=YES;
                    [self.navigationController pushViewController:esRefound animated:YES];
                }
                    break;
                case OrderStatus_WaitSure://查看物流
                {
                    ESLogisticsController*esLogitic=[[ESLogisticsController alloc]init];
                    esLogitic.orderId=self.detailInfo.order_id;
                    [self.navigationController pushViewController:esLogitic animated:YES];
                }
                    break;
                    case OrderStatus_WaitReply://等待评价->查看物流
                {
                    ESLogisticsController*esLogitic=[[ESLogisticsController alloc]init];
                    esLogitic.orderId=self.detailInfo.order_id;
                    [self.navigationController pushViewController:esLogitic animated:YES];
                    
                }
                    break;
                default: break;
            }
        };
        _bottomView.rightBlock = ^{
            @strongify(self);
            switch (self.detailInfo.orderStatus) {
                case OrderStatus_WaitPay://去支付
                {
                    ESPayListController *pay = [[ESPayListController alloc] init];
                    pay.order_id = self.order_id;
                    pay.total_fee = self.detailInfo.total_fee;
                    pay.isComFromOrderDetail=YES;
                    [self.navigationController pushViewController:pay animated:YES];
                }
                    break;
                case OrderStatus_WaitSend://申请退款
                {
                    if (self.detailInfo.refund_status.intValue==0) {
                        ESESRefoundController *esRefound=[[ESESRefoundController alloc]init];
                        esRefound.orderInfo=self.detailInfo;
                        esRefound.isRefound=YES;
                        [self.navigationController pushViewController:esRefound animated:YES];
                    }else{
                        ESRefundResultCon *vc=[[ESRefundResultCon alloc]init];
                        vc.isFromDetailOrder=YES;
                        vc.order_id=self.detailInfo.order_id;
                        vc.reasonStr=@"退款";
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }
                    break;
                case OrderStatus_WaitReply://评价
                {
                    PostCommentViewController *vc=[[PostCommentViewController alloc]init];
                    vc.orderInfo = self.detailInfo;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case OrderStatus_WaitSure://确认收货
                {
                    UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:@"确认收货" message:@"您确认收货吗？"];
                    [alertView bk_addButtonWithTitle:@"取消" handler:nil];
                    // @weakify(self);
                    [alertView bk_addButtonWithTitle:@"确认收货" handler:^{//进入评论页面
                        // @strongify(self);
                        //            [self handleAtSection:section];
                        
                    }];
                    [alertView show];
                    
                }
                    break;
                default: break;
            }
        };
    }
    return _bottomView;
}

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = KCommontTableViewBagroudColor;
   self.navigationItem.title = @"订单详情";
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = ({
        ESOrderStateView *headerView = [[ESOrderStateView alloc] init];
        headerView.frame    = CGRectMake(0, 0, ScreenWidth, (ScreenWidth *(205/617.0))+20);
        self.headerView     = headerView;
        
        headerView;
    });
    self.tableView.tableFooterView = ({
        OrderFooterView *footerView = [[OrderFooterView alloc] init];
        footerView.frame = CGRectMake(0, 0, ScreenWidth, 100+((ScreenWidth-3)/2.0 +60)*6+15);
//        footerView.pasteButtonBlock=^(){
//            UIPasteboard*paste=[UIPasteboard generalPasteboard];
//            paste.string=self.detailInfo.order_id;
//            [ESToast showSuccess:@"成功复制"];
//        };
        self.footerView = footerView;
        footerView;
    });
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@64);
        make.bottom.equalTo(@(0));
    }];
    [self.view addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@70);
    }];
    
    [self fetchOrderDetail];
}

- (void)handleNavigation
{

    
}

#pragma mark
#pragma mark - tableview代理方法;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.detailInfo) {
        if (self.detailInfo.orderStatus == OrderStatus_WaitReply || self.detailInfo.orderStatus == OrderStatus_WaitSure) {//待评价 || 待收货  -> 有物流信息
            return 2;
        }else{
            return 2;
        }
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {//订单商品
        return self.detailInfo.order_goods.count;
    }else if (section == 1) {//价格相关
        if (self.detailInfo.orderStatus==OrderStatus_WaitPay) {
            return 8;
        }else if (self.detailInfo.orderStatus==OrderStatus_Cancel){
            return 8;
        }
        return 9;
   }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {//订单商品
        return 90;
    }else if (indexPath.section == 1) {//价格相关
        return 40;
    }

    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 50;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==0) {
        ESFootViewGray *view=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ESFootViewGray"];
        view.detailInfo=self.detailInfo;
        return view;
    }
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section == 0) {//商品信息
        ESOrderShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESOrderShopCell"];
        cell.goodsInfo = [self.detailInfo.order_goods objectAtIndex:indexPath.row];
        return cell;
    }else if (indexPath.section == 1) {//价格信息
        ESOrderPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESOrderPriceCell"];
        switch (indexPath.row) {
            case 0:
                cell.titleLab.text = @"应付总额:";
                cell.titleLab.textColor = AllTextColor;
                cell.priceNumLab.text = [NSString stringWithFormat:@"¥%.2f",[self.detailInfo.total_fee floatValue]];
                cell.priceNumLab.textColor = RGB(233, 40, 46);
                break;
            case 1:
                cell.titleLab.text = @"商品总价:";
                float f=[self.detailInfo.total_fee  floatValue]-[self.detailInfo.tax_fee floatValue];
                cell.priceNumLab.text = [NSString stringWithFormat:@"¥%.2f",f];
                
                break;
            case 2:
                cell.titleLab.text = @"首单优惠:";
                cell.priceNumLab.text = [NSString stringWithFormat:@"¥%.2f",[self.detailInfo.coupon_fee floatValue]];
                break;
            case 3:
                cell.titleLab.text = @"运费:";
                cell.priceNumLab.text = [NSString stringWithFormat:@"¥%.2f",[self.detailInfo.shipping_fee floatValue]];
                break;
            case 4:
                cell.titleLab.text = @"税费:";
                cell.priceNumLab.text = [NSString stringWithFormat:@"¥%.2f",[self.detailInfo.tax_fee floatValue]];
                break;
                
            case 5: cell.titleLab.text=@"订单编号:";
                cell.priceNumLab.text=[NSString stringWithFormat:@"%@",self.detailInfo.order_id];
                break;
                
            case 6:
                cell.titleLab.text=@"下单时间:";
                cell.priceNumLab.text=[NSString stringWithFormat:@"%@",[GSTimeTool formatterNumber:self. detailInfo.create_time toType:GSTimeType_YYYYMMddHHmm]];
                break;
            case 7:
                cell.titleLab.text=@"收件人:";
                cell.priceNumLab.text=[NSString stringWithFormat:@"%@",self.detailInfo.receiver_name];
                break;
            case 8:
                cell.titleLab.text=@"支付方式:";
                cell.priceNumLab.text=[NSString stringWithFormat:@"%@",self.detailInfo.payment_name];
                break;
                
            default:
                break;
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {//商品信息
        
        OrderGoodsInfo *info = [self.detailInfo.order_goods objectAtIndex:indexPath.row];
        ESHomeShopDetailController*detail=[[ESHomeShopDetailController alloc]init];
        detail.goods_id=info.goods_id;
        [self .navigationController pushViewController:detail animated:YES];

    }
}
#pragma mark 显示cell的线不完全的解决方法
-(void)viewDidLayoutSubviews{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

#pragma mark
#pragma mark lazy init
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor=RGBA(247, 247, 247, 1);
        _tableView.dataSource = self;
          _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator=NO;
        [_tableView registerClass:[ESFootViewGray class] forHeaderFooterViewReuseIdentifier:@"ESFootViewGray"];
        [_tableView registerClass:[ESOrderAddressCell class] forCellReuseIdentifier:@"ESOrderAddressCell"];
        [_tableView registerClass:[ESOrderShopCell class] forCellReuseIdentifier:@"ESOrderShopCell"];
        [_tableView registerClass:[ESOrderPriceCell class] forCellReuseIdentifier:@"ESOrderPriceCell"];
        [_tableView registerClass:[ESLogisticsCell class] forCellReuseIdentifier:@"ESLogisticsCell"];
        [_tableView registerClass:[ESOrderTimeCell class] forCellReuseIdentifier:@"ESOrderTimeCell"];
        [_tableView registerClass:[ESOrderBottonCell class] forCellReuseIdentifier:@"ESOrderBottonCell"];
        @weakify(self);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           @strongify(self);
            [self fetchOrderDetail];
        }];
    }
    return _tableView;
}

#pragma mark - Networking

#pragma mark - 确认收货
- (void)comfrimOrder
{
    ComfirmOrderRequest *request = [ComfirmOrderRequest request];
    request.order_id = self.order_id;
    
    @weakify(self);
    [self.indicator startAnimation];
    [ESService comfirmOrderRequest:request success:^{
        @strongify(self);
        [self endGSNetworking];
        
        [ESToast showSuccess:@"确认收货成功!"];
        [[NSNotificationCenter defaultCenter] postNotificationName:kReloadOrderListNotification object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
       @strongify(self);
        [self endGSNetworking];
    }];
}

#pragma mark 请求订单详情
- (void)fetchOrderDetail
{
    GetOrderDetailRequest *request = [[GetOrderDetailRequest alloc] init];
    request.order_id = self.order_id;
    
    @weakify(self);
    [self.indicator startAnimation];
    [ESService getOrderDetailRequest:request success:^(OrderDetailInfo *response) {
        @strongify(self);

        self.headerView.orderInfo = response;
        self.footerView.orderInfo = response;
        self.bottomView.orderInfo = response;
        self.footView.detailInfo=response;
        self.detailInfo = response;
        [self fetchRelatedGoodsGoods_id:nil];
        NSString*str=[NSString stringWithFormat:@"%@%@",response.receiver_address,response.receiver_area];
        CGSize size=[str strParaStyleheightOfLineSpacing:4 andFont:[UIFont systemFontOfSize:14] andHeight:1000 andwidth:ScreenWidth-83];
         self.headerView.frame=CGRectMake(0, 0, ScreenWidth, size.height +(ScreenWidth *(205/617.0))+70);
         self.tableView.tableHeaderView=self.headerView;
        
        
        
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}
#pragma mark - 推荐商品
- (void)fetchRelatedGoodsGoods_id:(NSString*)string
{
    GetRelatedGoodsRequest *request = [GetRelatedGoodsRequest request];
    request.goods_id = @"949";
    request.n        = @12;
    
    @weakify(self);
    [ESService getRelatedGoodsRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        self.footerView.relateArray=response;
        [self .tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.indicator stopAnimation];
    [self.tableView.mj_header endRefreshing];
}

@end
