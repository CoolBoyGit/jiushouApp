//
//  ESHomeController.m
//  EasyShop
//
//  Created by wcz on 16/3/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESHomeController.h"
#import "ESHomeSearchView.h"
#import "ESBannerScrollview.h"
#import "ESHomeProductCell.h"
#import "ESSingleTableViewCell.h"
#import "ESHomeCategaryView.h"
#import "ESHomeCategoryTitleView.h"
#import "ESRootViewController.h"
#import "ESHomeShopDetailController.h"
#import "ESKIDSController.h"
#import "GoodsListViewController.h"


@interface ESHomeController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

/** banner */
@property (nonatomic,weak) ESBannerScrollview *bannerView;

/** 悬浮按钮 */
@property (nonatomic,strong) UIButton *suspendButton;

/** 活动专场列表 （item ：ActivityInfo ） */
@property (nonatomic,strong) NSMutableArray *activityItems;
/** 商品列表 （item：GoodsInfo ） */
@property (nonatomic,strong) NSMutableArray *goodsItems;
@property (nonatomic,assign) int page;
@end

@implementation ESHomeController

-(NSMutableArray *)activityItems{
    if (_activityItems==nil) {
        _activityItems=[[NSMutableArray alloc]init];
    }
    return _activityItems;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESHomeProductCell class] forCellReuseIdentifier:kIDESHomeProductCell];
        [_tableView registerClass:[ESSingleTableViewCell class] forCellReuseIdentifier:@"ESSingleTableViewCell"];
    }
    return _tableView;
}
-(NSMutableArray *)goodsItems{
    if (_goodsItems==nil) {
        _goodsItems=[NSMutableArray array];
        
    }
    return _goodsItems;
}
- (UIButton *)suspendButton
{
    if (!_suspendButton) {
         _suspendButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 80, 31, 31)];
       
        [_suspendButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",@"newTopBtn"]] forState:UIControlStateNormal];

        [_suspendButton addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _suspendButton;
}

- (void)scrollToTop
{
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offy=scrollView.contentOffset.y;
    if (offy>ScreenHeight*1.3) {
        self.suspendButton.hidden=NO;
    }else{
        self.suspendButton.hidden=YES;
    }
    
}
#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = ({
        ESBannerScrollview *bannerView =   [[ESBannerScrollview alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*408/617.0+10)];
        bannerView.navInfo      = self.navInfo;
        self.bannerView = bannerView;
        
        bannerView;
    });
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self fetchActivityList];
        [self refreshList];
    }];
    MJRefreshAutoNormalFooter*footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self moreList];
    }];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    self.tableView.mj_footer=footer;

    [self.view addSubview:self.suspendButton];
    self.suspendButton.hidden=YES;
    [self.suspendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@31);
        make.right.equalTo(@(-30));
        make.height.equalTo(@31);
        make.bottom.equalTo(self.view.mas_bottom).offset(-25);
    }];
    
    if (self.navInfo) {
        [self fetchActivityList];
        
    }
}
-(void)  refreshList{
    self.page=1;
    [self fetchGoodsInfo];
}
-(void)moreList{
    self.page++;
    [self fetchGoodsInfo];
}
#pragma mark - tableview代理方法;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {//活动专场
        return self.activityItems.count;
    }else{//精品推荐
        return self.goodsItems.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }else
    {
        return 45;
    }
}
-(void)tapAction{
    self.tabBarController.selectedIndex=1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==0) {//活动专场
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        label.text=@"今日上新  快来抢购";
        label.textAlignment=NSTextAlignmentCenter;
        
        label.userInteractionEnabled=YES;
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [label addGestureRecognizer:tap];
        return nil;
    }
    
      else {//精品推荐
        ESHomeCategoryTitleView *titleView = [[ESHomeCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
        return titleView;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
//       ActivityInfo *info = [self.activityItems objectAtIndex:indexPath.row];
//        return info.cellHeight;
        return ScreenWidth*(408/617.0)+225.0;
    } else
    {
        return 150;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {//活动专场
        ActivityInfo *info = [self.activityItems objectAtIndex:indexPath.row];
        
        GoodsListViewController *list = [[GoodsListViewController alloc] init];
        list.listType = GoodsListType_Activity;
        list.activity_id = info.aid;
        list.activity_name = info.name;
        [self.navigationController pushViewController:list animated:YES];
    }else{//精品
        ESHomeShopDetailController *shopDetailVc = [[ESHomeShopDetailController alloc] init];
        shopDetailVc.hidesBottomBarWhenPushed = YES;
        GoodsInfo *info = [self.goodsItems objectAtIndex:indexPath.row];
        shopDetailVc.goods_id = info.gid;
        [self.navigationController pushViewController:shopDetailVc animated:YES];
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {//活动专场
        ESHomeProductCell *cell = [tableView dequeueReusableCellWithIdentifier:kIDESHomeProductCell forIndexPath:indexPath];
        cell.activityInfo   = [self.activityItems objectAtIndex:indexPath.row];
        return cell;
    } else {//精品
        ESSingleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESSingleTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        GoodsInfo*goodsInfo = [self.goodsItems objectAtIndex:indexPath.row];
        cell.goodsInfo=goodsInfo;
        if ([goodsInfo.stock intValue]==0) {
            cell.isHidden=NO;
        }else{
            cell.isHidden=YES;
        }
        return cell;
    }
}

#pragma mark - Networking
/** 获取活动专场 */
- (void)fetchActivityList
{
    GetActivityListRequest *request = [GetActivityListRequest request];
    request.nav_id = self.navInfo.nid;
    
    @weakify(self);
    [ESService getActivityListRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
         [self.activityItems removeAllObjects];
        for (ActivityInfo*activituInfo in response) {
            if (activituInfo.goods_list.count==0 ) {
                
            }else{
               
                [self.activityItems addObject:activituInfo];
            }
        }
        [self.tableView reloadData];
        [self fetchGoodsInfo];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
    
}
//获取精品推荐
- (void)fetchGoodsInfo
{
    GoodsRequest *request = [GoodsRequest request];
    request.n=@10;
    request.page=[NSNumber numberWithShort:self.page];
    @weakify(self);
    
    [ESService goodsRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        if (self.page==1) {
            [self.goodsItems removeAllObjects];
        }
        [self.goodsItems addObjectsFromArray:response];
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
