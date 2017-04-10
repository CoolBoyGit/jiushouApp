//
//  ESJoinListViewController.m
//  EasyShop
//
//  Created by jiushou on 16/10/12.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterDetailController.h"
#import "ESclusterPayController.h"
#import "ESHomeShopDetailController.h"
#import "ESClusterDetailHeardView.h"
#import "ESclusterPayController.h"
#import "ESMyCLusterrPageCon.h"
#import "ESClusterIntroduceCon.h"
#import "ESClusterDetailFooterView.h"
#import "ESClusterDetailPeopleCell.h"
#import "ESClusterDetailTimeCell.h"
#import "ESClusterDetailPeCell.h"
#import "ESClusterDetailButtonCell.h"
#import "ESClusterDetailBottomView.h"
#import "NormalWebViewController.h"
@interface ESClusterDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView*tableView;
@property (nonatomic,strong)ESClusterDetailHeardView*heardView;
@property (nonatomic,strong)ESClusterDetailFooterView*footerView;
@property (nonatomic,assign) BOOL isHidden;//用来标记是否显示参团人数列表.
@property (nonatomic,strong)ESClusterDetailBottomView*cluBottomView;

@property (nonatomic,strong) ESIndicator *indicator;
@property (nonatomic,strong) GetClusterDetailRespone*clusterDetail;

@property (nonatomic,strong) NSArray*relationItemArray;//存放的是关联商品
@end

@implementation ESClusterDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    //是点击了参团或者直接开团跳转进来的界面.
    self.view.backgroundColor=[UIColor whiteColor];
    self.isHidden=YES;
    self.navigationItem.title=@"拼团";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@64);
    }];
    [self.view addSubview:self.cluBottomView];
    [self.cluBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@70);
    }];
    @weakify(self);
    self.cluBottomView.moreButtonBlock=^(){
        @strongify(self);
        [[NSNotificationCenter defaultCenter]postNotificationName:TapClusterPopCluster object:nil];
        self.navigationController.tabBarController.selectedIndex=1;
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    
    self.cluBottomView.joinButtonActionBlock=^(){//开团中,点击我要参团
        @strongify(self);
        ESclusterPayController*vc=[[ESclusterPayController alloc]init];
        vc.clusterRespone=self.clusterRespone;
        vc.clusterId=self.clusterId;
        vc.clusterDetail=self.clusterDetail;
        if (self.isComeClusterOrder) {
            vc.typeStaus=ClusterPayStaus_FromOrderJionCLuster;
        }else{
            vc.typeStaus=ClusterPayStaus_FromHomeJionCLuster;
        }
        [self.navigationController pushViewController:vc animated:YES];
    };
    self.cluBottomView.createClusterBlock=^(){//我要开团
         @strongify(self);
         ESclusterPayController*vc=[[ESclusterPayController alloc]init];
        vc.goods_id=self.clusterDetail.goods_id;
        
        vc.typeStaus=ClusterPayStaus_FromHome;
        [self.navigationController pushViewController:vc animated:YES];
    };
    self.tableView.tableHeaderView=({
        self.heardView=[[ESClusterDetailHeardView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
        self.heardView.tapBlock=^(){
             @strongify(self);
            ESHomeShopDetailController*vc=[[ESHomeShopDetailController alloc]init];
            vc.goods_id=self.clusterDetail.goods_id;
            [self.navigationController pushViewController:vc animated:YES];
        };
        self.heardView;
        
        
    });
    
    self.tableView.tableFooterView=({
        self.footerView=[[ESClusterDetailFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ((ScreenWidth-3)/2.0 +50)*6+290)];
        @weakify(self);
        self.footerView.seeButtonBlock=^(){
            @strongify(self);
//            NormalWebViewController*vc=[[NormalWebViewController alloc]init];
//            vc.url=@"http://api.jiushouguoji.hk/app/Guider/clusterBuyGuilder";
            ESClusterIntroduceCon*vc=[[ESClusterIntroduceCon alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        self.footerView.leftTapBlock=^(){
            @strongify(self);
            [[NSNotificationCenter defaultCenter]postNotificationName:TapClusterPopCluster object:nil];
            self.navigationController.tabBarController.selectedIndex=1;
            [self.navigationController popToRootViewControllerAnimated:YES];
        };
        self.footerView.rightTapBlock=^(){
            @strongify(self);
            ESMyCLusterrPageCon*vc=[[ESMyCLusterrPageCon alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        self.footerView;
    });
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getClusterDetailMessage];
    }];
    [self getClusterDetailMessage];
    [self getRelationGoods];
    
    [self addNotification];
    
}
-(void)refreshList{
    
}
-(void)moreList{
    
}

-(void)getRelationGoods{
    
}
-(void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getClusterDetailMessage) name:KClusterDidPaySuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getClusterDetailMessage) name:ESClusterTimeZero object:nil];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(ESClusterDetailBottomView *)cluBottomView{
    if (_cluBottomView==nil) {
        _cluBottomView=[[ESClusterDetailBottomView alloc]init];
    }
    return _cluBottomView;
}
#pragma mark TableView DelegateAND Datasource
-(UITableView *)tableView{
    if (_tableView ==nil) {
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[ESClusterDetailPeopleCell class] forCellReuseIdentifier:@"ESClusterDetailPeopleCell"];
        [_tableView registerClass:[ESClusterDetailTimeCell class] forCellReuseIdentifier:@"ESClusterDetailTimeCell"];
        [_tableView registerClass:[ESClusterDetailPeCell class] forCellReuseIdentifier:@"ESClusterDetailPeCell"];
        [_tableView registerClass:[ESClusterDetailButtonCell class] forCellReuseIdentifier:@"ESClusterDetailButtonCell"];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        if ([self.clusterDetail.gap_time intValue]<=0) {
            return 2;
        }else{
            return 3;
        }
        
    }
    if (section==1) {
        if (self.isHidden) {
            return 0;
            
        }else{
            return self.clusterDetail.member.count;
        }
    }
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if ([self.clusterDetail.gap_time intValue]<=0) {
            if (indexPath.row==0) {
                if ([self.clusterDetail.status isEqualToString:@"2"]) {
                    
                    return 60;
                    
                    
                } else if ([self.clusterDetail.status isEqualToString:@"3"]||[self.clusterDetail.status isEqualToString:@"4"]){
                    return 105;
                    
                }
                
            }
            if (indexPath.row==1) {
                 return 30;
            }
            
        }else{
            if (indexPath.row==0) {
                if ([self.clusterDetail.status isEqualToString:@"2"]) {
                    
                    return 60;
                    
                    
                } else if ([self.clusterDetail.status isEqualToString:@"3"]||[self.clusterDetail.status isEqualToString:@"4"]){
                    return 105;
                    
                }
                
            }
            if (indexPath.row==1) {
                return 100;
            }else if (indexPath.row==2){
                return 30;
            }

            
        }

}
    
    
    
    
    if (indexPath.section==1) {
        
        if (self.isHidden==YES) {
            
            return 0;
            
        }
        else{
            return 60;
        }
    }
    return 0;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if ([self.clusterDetail.gap_time intValue]<=0) {
            if (indexPath.row==0) {
                
                
                ESClusterDetailPeopleCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESClusterDetailPeopleCell"];
                cell.isHidenLable=YES;
                cell.clusterDetail=self.clusterDetail;
                
                return cell;
                
            }
            else if (indexPath.row==1) {
                ESClusterDetailButtonCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESClusterDetailButtonCell"];
                @weakify(self);
                cell.buttoonBlock=^(BOOL hidden){
                    @strongify(self);
                    self.isHidden=!hidden;
                    NSIndexSet*set=[[NSIndexSet alloc]initWithIndex:1];
                    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
                    // [self.tableView reloadData];
                    
                    
                };
                return cell;
            }

            
        }else{
            if (indexPath.row==0) {
                
                
                ESClusterDetailPeopleCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESClusterDetailPeopleCell"];
                cell.isHidenLable=YES;
                cell.clusterDetail=self.clusterDetail;
                
                return cell;
                
            }else if (indexPath.row==1) {
                ESClusterDetailTimeCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESClusterDetailTimeCell"];
                cell.clusterdetaliRespone=self.clusterDetail;
                
                return cell;
            }
            else if (indexPath.row==2) {
                ESClusterDetailButtonCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESClusterDetailButtonCell"];
                @weakify(self);
                cell.buttoonBlock=^(BOOL hidden){
                    @strongify(self);
                    self.isHidden=!hidden;
                    NSIndexSet*set=[[NSIndexSet alloc]initWithIndex:1];
                    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
                };
                return cell;
            }

        }
    }
    else if(indexPath.section==1){
        ESClusterDetailPeCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESClusterDetailPeCell"];
        cell.isHidden=self.isHidden;
        ClusterDetailMemberRespone*respone=[[ClusterDetailMemberRespone alloc]init];
        respone=[self.clusterDetail.member objectAtIndex:indexPath.row];
        cell.memberDetailInfo=respone;
        return cell;
    }
    return nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 获取商品拼团的详细信息
-(void)getClusterDetailMessage{
    GetClusterDetailRequest*request=[GetClusterDetailRequest request];
    if (self.flag==2) {
        request.cluser_id=self.clusterId;
    }else{
        request.cluser_id=self.clusterRespone.cid;
    }
    
    [self.indicator startAnimation];
    [ESService getClusterDetailRequest:request success:^(GetClusterDetailRespone *response) {
        self.clusterDetail=[[GetClusterDetailRespone alloc]init];
        self.clusterDetail=response;
        self.cluBottomView.clusterDetailRespone=response;
        self.footerView.detailInfo=response;
        self.heardView.detailInfo=response;
        [self fetchRelatedGoodsGoods_id:response.goods_id];
        
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - 推荐商品
- (void)fetchRelatedGoodsGoods_id:(NSString*)string
{
    GetRelatedGoodsRequest *request = [GetRelatedGoodsRequest request];
    request.goods_id = string;
    request.n        = @12;
    
    @weakify(self);
    [ESService getRelatedGoodsRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        self.footerView.relationArray=response;
        [self .tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}
#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.indicator stopAnimation];
    [self.tableView.mj_header endRefreshing];
    
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
