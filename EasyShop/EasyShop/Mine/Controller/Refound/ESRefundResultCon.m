//
//  ESRefundResultCon.m
//  EasyShop
//
//  Created by jiushou on 16/7/4.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESRefundResultCon.h"
#import "ESESRefoundController.h"
#import "ESMyOrderListController.h"
#import "ESMyOrderPageController.h"
#import "ESESRefoundController.h"
#import "GSTimeTool.h"
#import "OrderFooterView.h"
#import "ESRefundResultListCell.h"
#import "ESRefundListHeardView.h"
#import "ESRefundResultFootView.h"
@interface ESRefundResultCon ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) ESIndicator *indicator;
@property (nonatomic,strong) OrderFooterView*footerView;
@property (nonatomic,strong) ESRefundListHeardView*headerView;
@property (nonatomic,strong)RefundResultRespone*refundRespone;
@property (nonatomic,strong) UITableView*tableView;
@end

@implementation ESRefundResultCon
- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.navigationItem.title=@"退款/退货";
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(@0);
        make.top.equalTo(@64);
    }];
    self.tableView.tableHeaderView=({
        self.headerView=[[ESRefundListHeardView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, (ScreenWidth *(205/617.0))+10)];
        self.headerView;
    });
    self.tableView.tableFooterView=({
        self.footerView=[[OrderFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ((ScreenWidth-3)/2.0 +50)*6+15+64)];
        self.footerView;
    });
    [self fetchOrderDetail];
    [self fetchGoodsInfo];
    [self push];
    
}
-(void)push{
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [mArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[ESESRefoundController class]]) {
            [mArr removeObject:obj];
        }
    }];
    self.navigationController.viewControllers=mArr;

}
-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=[UIColor whiteColor];
        [_tableView registerClass:[ESRefundResultListCell class] forCellReuseIdentifier:@"ESRefundResultListCell"];
    }
    return _tableView;
}
#pragma mark tableView deletage datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.refundRespone.refund_status intValue]==5) {
        return 8;
    }else{
        return 6;
        
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ESRefundResultListCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESRefundResultListCell"];
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                cell.label.text=@"退款金额:";
                if (self.refundRespone.apply_rmb_amount.length==0) {
                    cell.messageLabel.text=self.refundRespone.apply_amount;
                }else{
                     cell.messageLabel.text=[NSString stringWithFormat:@"¥%@(≈$%.2f)",self.refundRespone.apply_amount,[self.refundRespone.refund_rmb_amount floatValue]];
                }
                
                break;
            case 1:
                cell.label.text=@"退款原因:";
                cell.messageLabel.text=self.refundRespone.refund_reason;
                break;
            case 2:
                cell.label.text=@"退款说明:";
                if (self.refundRespone.refund_message.length==0) {
                    cell.messageLabel.text=@"--";
                }else{
                    cell.messageLabel.text=self.refundRespone.refund_message;
                }
                
                break;
            
            case 3:
                cell.label.text=@"订单号:";
                cell.messageLabel.text=self.refundRespone.order_id;
                break;
            case 4:
                cell.label.text=@"支付方式:";
                cell.messageLabel.text=self.refundRespone.payment_name;
                break;
            case 5:
                cell.label.text=@"申请时间:";
                cell.messageLabel.text=[NSString stringWithFormat:@"%@",[GSTimeTool formatterNumber:self.refundRespone.apply_time toType:GSTimeType_YYYYMMddHHmm]];
                break;
            case 6:
                cell.label.text=@"退款时间:";
                
                cell.messageLabel.text=[NSString stringWithFormat:@"%@",[GSTimeTool formatterNumber:self.refundRespone.refund_time toType:GSTimeType_YYYYMMddHHmm]];
                break;
            case 7:
                cell.label.text=@"退款编号:";
                cell.messageLabel.text=self.refundRespone.refund_no;
                break;
                default:
                break;
        }
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    ESRefundResultFootView*footView=[[ESRefundResultFootView alloc]init];
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (void)fetchOrderDetail
{
    GetRefundResultRequest *request = [[GetRefundResultRequest alloc] init];
    request.order_id = self.order_id;
    
    @weakify(self);
    [self.indicator startAnimation];
    [ESService GetRefundResultRequest:request success:^(RefundResultRespone *refund) {
        @strongify(self);
        [self endGSNetworking];
        self.refundRespone=refund;
        self.headerView.refundRespone=refund;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];

}
- (void)fetchGoodsInfo
{
    GoodsRequest *request = [GoodsRequest request];
    request.n=@12;
    request.page=@1;
    @weakify(self);
    
    [ESService goodsRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        self.footerView.relateArray=response;
        
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
    //[self.tableView.mj_header endRefreshing];
}


@end
