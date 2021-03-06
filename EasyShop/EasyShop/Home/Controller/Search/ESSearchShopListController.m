//
//  ESSearchShopListController.m
//  EasyShop
//
//  Created by wcz on 16/6/28.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESSearchShopListController.h"
#import "ESMyFootListCell.h"
#import "ESHomeShopDetailController.h"
#import "ESSearchGoodsCell.h"
@interface ESSearchShopListController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
/** 页码 */
@property (nonatomic,assign) NSInteger page;
/** 搜索商品item (item: GoodsInfo ) */
@property (nonatomic,strong) NSMutableArray *goodsItems;
/**用来判断请求的是关键字数据还是热销的数据**/
@property (nonatomic,assign) int flag ;//1 表示关键字 0 表示热销数据
@property (nonatomic,strong) UIView*heardView;//没有数据的时候的头部视图
@property (nonatomic,strong) UILabel*firstLbel;//
@property (nonatomic,strong) UILabel*seconLable;
@end

@implementation ESSearchShopListController

#pragma mark
#pragma mark lazy init
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.backgroundColor=RGB(247, 247, 247) ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESSearchGoodsCell class] forCellReuseIdentifier:@"ESSearchGoodsCell"];
        
    }
    return _tableView;
}
-(UILabel *)firstLbel{
    if (_firstLbel==nil) {
        _firstLbel=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, 20)];
        _firstLbel.text=@"没有发现亲需要的商品";
        _firstLbel.textAlignment=NSTextAlignmentCenter;
        
    }
    return _firstLbel;
}
-(UILabel*)seconLable{
    if (_seconLable==nil) {
        _seconLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, ScreenWidth, 20)];
        _seconLable.textAlignment=NSTextAlignmentCenter;
        _seconLable.text=@"就手推荐";
    }
    return _seconLable;
}
-(UIView *)heardView{
    if (_heardView==nil) {
        _heardView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
        _heardView.backgroundColor=[UIColor whiteColor];
        
    }
    return _heardView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.flag=1;
    self.navigationItem.title=self.keyWordStr;
    self .view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@64);
    }];
    [self refrshList];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self refrshList];
    }];
    MJRefreshAutoNormalFooter*footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self moreList];
    }];
    [footer setTitle:@"已经到底了" forState:MJRefreshStateNoMoreData];
    self.tableView.mj_footer=footer;
}
-(void)refrshList{
    self.page=1;
    if (self.flag==1) {
        [self searchGoods];
    }else{
        [self fetchGoods];
    }
    
}

-(void)moreList{
    self.page++;
    if (self.flag==1) {
        [self searchGoods];
    }else{
        [self fetchGoods];
    }
    
}
- (void)searchGoods
{
    
    SearchRequest *request = [SearchRequest request];
    request.key = self.keyWordStr;
    request.page = [NSNumber numberWithInteger:self.page];
    request.n    = @20;
    
    @weakify(self);
    [ESService searchRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
//                   self.tableView.mj_footer.hidden = response.count < 20;
        if (response.count < 20) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else
        {
            [self.tableView.mj_footer resetNoMoreData];
        }
            if (self.page == 1) {
                if (response.count==0) {
                    self.flag=0;
                    [self fetchGoods];
                }
                [self.goodsItems removeAllObjects];
            }
            
            [self.goodsItems addObjectsFromArray:response];
            
            [self.tableView reloadData];
        
       
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}
-(void)fetchGoods{
    GoodsRequest*request=[GoodsRequest request];
    request.page=[NSNumber numberWithInteger:self.page];
    request.n=[NSNumber numberWithInt:10];
    request.orderBy=[NSNumber numberWithInt:2];
     @weakify(self);
    [ESService goodsRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        
//        self.tableView.mj_footer.hidden = response.count < 20;
        if (response.count < 20) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else
        {
            [self.tableView.mj_footer resetNoMoreData];
        }
        if (self.page == 1) {
            [self.goodsItems removeAllObjects];
        }
        
        [self.goodsItems addObjectsFromArray:response];
        [self.heardView addSubview:self.firstLbel];
        [self.heardView addSubview:self.seconLable];
        self.tableView.tableHeaderView=self.heardView;
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];

    }];
    
}
-(NSMutableArray *)goodsItems{
    if (_goodsItems==nil) {
        _goodsItems=[NSMutableArray array];
    }
    return _goodsItems;
}
- (void)endGSNetworking
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.goodsItems.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    ESHomeShopDetailController *detail = [[ESHomeShopDetailController alloc] init];
    GoodsInfo*info=[self.goodsItems objectAtIndex:indexPath.row];
    detail.goods_id=info.gid;
    [self.navigationController pushViewController:detail animated:YES];
    
//    ESRootViewController*rootvc=[[ESRootViewController alloc]init];
//    rootvc.hidesBottomBarWhenPushed=YES;
//   // GoodsInfo *info = [self.goodsItems objectAtIndex:indexPath.row];
//    rootvc.goods_id=info.gid;
//    [self.navigationController pushViewController:rootvc animated:YES];
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ESSearchGoodsCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESSearchGoodsCell"];
    cell.goodsInfo=[self.goodsItems objectAtIndex:indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


@end
