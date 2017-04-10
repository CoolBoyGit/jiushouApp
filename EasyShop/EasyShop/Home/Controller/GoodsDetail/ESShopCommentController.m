//
//  ESShopCommentController.m
//  EasyShop
//
//  Created by wcz on 16/6/5.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShopCommentController.h"
#import "ESShopCommentCell.h"
#import "ESShopCommentReusableView.h"

@interface ESShopCommentController ()<UITableViewDelegate  ,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

/** 评论统计信息 */
@property (nonatomic,strong) EvaluationInfo *evaluationInfo;
/** 评价信息 （item : GoodsEvaluationInfo ） */
@property (nonatomic,strong) NSMutableArray *evaluationItems;
/** from */
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong) ESShopCommentReusableView *reusableView;
@end

@implementation ESShopCommentController

- (NSMutableArray *)evaluationItems
{
    if (!_evaluationItems) {
        _evaluationItems = [NSMutableArray array];
    }
    return _evaluationItems;
}

- (UITableView *)tableview
{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tableview registerClass:[ESShopCommentCell class] forCellReuseIdentifier:@"ESShopCommentCell"];
        _tableview.tableFooterView = [[UIView alloc]init];
    }
    return _tableview;
}
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//     [[NSNotificationCenter defaultCenter]postNotificationName:LoginViewwillDiddisAppear object:nil];
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
   
    
    self.navigationItem.title = @"商品评论";
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.right.bottom.equalTo(@0);
    }];
    self.reusableView=[[ESShopCommentReusableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    self.tableview.tableHeaderView=self.reusableView;
    @weakify(self);
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshList];
    }];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self moreList];
    }];
    
    
    [self refreshList];
}
#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.evaluationItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESShopCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESShopCommentCell"];
    cell.item = [self.evaluationItems objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodEvaluationItem *item =   [self.evaluationItems objectAtIndex:indexPath.row];
    return  item.cellHeight;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 90;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
////    ESShopCommentReusableView *reusableView = [[ESShopCommentReusableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
////    reusableView.backgroundColor = [UIColor whiteColor];
////    reusableView.evluationInfo = self.evaluationInfo;
////    return reusableView;
//}

#pragma mark - Networking

#pragma mark - 请求商品统计信息
- (void)fetchEvaluation
{
    GetEvaluationInfoRequest *request = [GetEvaluationInfoRequest request];
    request.goods_id = self.goods_id;
    
    @weakify(self);
    [ESService getEvaluationInfoRequest:request success:^(EvaluationInfo *response) {
      @strongify(self);
        
        self.evaluationInfo = response;
        self.reusableView.evluationInfo=self.evaluationInfo;
        [self.tableview reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - 请求商品评论

- (void)refreshList
{
    [self fetchEvaluation];
    
    self.page = 1;
    [self fetchGoodsEvaluation];
}
- (void)moreList
{
    self.page ++ ;
    [self fetchGoodsEvaluation];
}

/** 请求商品评价 */
- (void)fetchGoodsEvaluation
{
    GetGoodsEvaluationRequest *request = [GetGoodsEvaluationRequest request];
    request.goods_id = self.goods_id;
    request.page = [NSNumber numberWithInteger:self.page];
    request.n   = @10;
    
    @weakify(self);
    [ESService getGoodsEvaluationRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        
        if (self.page == 1) {
            [self.evaluationItems removeAllObjects];
        }
//        self.tableview.mj_footer.hidden = response.count < 20;
        if (response.count < 10) {
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        } else
        {
            [self.tableview.mj_footer resetNoMoreData];
        }
        
        NSMutableArray *mArr = [NSMutableArray array];
        for (GoodsEvaluationInfo *info in response) {
            [mArr addObject:[GoodEvaluationItem itemWithInfo:info]];
        }
        
        [self.evaluationItems addObjectsFromArray:[mArr copy]];
        [self.tableview reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
    
}

#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
}

@end
