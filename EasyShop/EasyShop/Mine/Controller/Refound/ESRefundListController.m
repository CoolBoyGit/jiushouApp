//
//  ESRefundListController.m
//  EasyShop
//
//  Created by jiushou on 16/7/5.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESRefundListController.h"
#import "ESRefundListCell.h"
@interface ESRefundListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView*tableView;
@property (nonatomic,strong)NSMutableArray*refundItemArray;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong) ESIndicator *indicator;
@end

@implementation ESRefundListController
- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}
-(NSMutableArray *)refundItemArray{
    if (_refundItemArray==nil) {
        _refundItemArray=[[NSMutableArray alloc]init];
        
    }
    return _refundItemArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataRefund];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getDataRefund];
    }];
    MJRefreshAutoNormalFooter*footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self getRefundMoreData];
    }];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    self.tableView.mj_footer=footer;       [self requestData];
    // Do any additional setup after loading the view.
}
-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[ESRefundListCell class] forCellReuseIdentifier:@"ESRefundListCell"];
    }
    return _tableView;
}
-(void)getDataRefund{
    self.page=1;
    [self requestData];
}
-(void)getRefundMoreData{
    self.page++;
    [self requestData];
}
-(void)requestData{
    GetReturnListRequest*request=[GetReturnListRequest request];
    request.status = [NSNumber numberWithInt:4];
    request.page = [NSNumber numberWithInteger:self.page];
    request.n    = @20;
    ///** 状态（0：所有；1：申请中；2：通过；3：拒绝;4：完成） */
     [self.indicator startAnimationWithMessage:@"请稍等"];
    [ESService getReturnListRequest:request success:^(NSArray *response) {
         [self endGSNetworking];
        if (self.page==1) {
            [self.refundItemArray removeAllObjects];
        }
//        self.tableView.mj_footer.hidden=response.count<20;
        if (response.count < 20) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else
        {
            [self.tableView.mj_footer resetNoMoreData];
        }
        [self.refundItemArray addObjectsFromArray:response];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (void)endGSNetworking
{
    [self.indicator stopAnimation];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.refundItemArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ESRefundListCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESRefundListCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
