//
//  TogetherDetailController.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ClusterOrderDetailCon.h"
#import "ESLogisticsController.h"
#import "ESHomeShopDetailController.h"

#import "ESClusterOrderDetailHeardView.h"
#import "ESClusterDetailBottomView.h"
#import "ESClusterOrderDetailFooterView.h"
#import "ESClusterOrderDetailGoodsCell.h"
#import "ESClusterOrderDetailOtherCell.h"
#import "ESClusteOrderrDetailBottomView.h"

@interface ClusterOrderDetailCon ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView*tableView;
@property (nonatomic,strong) ESClusterOrderDetailHeardView*heardView;
@property (nonatomic,strong) ESClusterOrderDetailFooterView*footerView;
@property (nonatomic,strong) ESClusteOrderrDetailBottomView*bottomView;
@property (nonatomic,strong) GetClusterOrderDetailRespone*clusterOrederDetail;

@end

@implementation ClusterOrderDetailCon

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"拼团订单详情";
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right. equalTo(@0);
        make.bottom.equalTo(@(0));
        make.top.equalTo(@64);
    }];
    
    @weakify(self);
    self.bottomView.seeLogiticsBlock=^(){
        @strongify(self);
        ESLogisticsController*vc=[[ESLogisticsController alloc]init];
        vc.isComfromClusterDetail=YES;
        vc.logisticsStr=self.clusterOrederDetail.order_id;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    self.tableView.tableHeaderView=({
        self.heardView= [[ESClusterOrderDetailHeardView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth  , (ScreenWidth *(205/617.0))+20)];
        self.heardView;
    });
   
    
    
    self.tableView.tableFooterView=({
        self.footerView=[[ESClusterOrderDetailFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, (((ScreenWidth-3)/2.0 +50)*4+9+54))];
    });
    // Do any additional setup after loading the view.
   
    [self getClusterOrderDetail];
}
-(ESClusteOrderrDetailBottomView *)bottomView{
    if (_bottomView==nil) {
        _bottomView=[[ESClusteOrderrDetailBottomView alloc]init];
        
    }
    return _bottomView;
}
#pragma  mark tableViewDelegate
-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ESClusterOrderDetailGoodsCell class] forCellReuseIdentifier:@"ESClusterOrderDetailGoodsCell"];
        [_tableView registerClass:[ESClusterOrderDetailOtherCell class] forCellReuseIdentifier:@"ESClusterOrderDetailOtherCell"];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        if ([self.clusterOrederDetail.status isEqualToString:@"3"]) {
            return 5;
        }else{
             return 4;
        }
        
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 190;
    }else{
        return 40;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        ESClusterOrderDetailGoodsCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESClusterOrderDetailGoodsCell"];
        cell.clusterOrederRespone=self.clusterOrederDetail;
        cell.seeButtonBlock=^(){
            
        };
        cell.tapBlock=^(){
            ESHomeShopDetailController*vc=[[ESHomeShopDetailController alloc]init];
            vc.goods_id=self.clusterOrederDetail.goods_id;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        };
        
        return cell;
    }
    ESClusterOrderDetailOtherCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESClusterOrderDetailOtherCell"];
    
    if (indexPath.row==0) {
        cell.typeStr=[NSString stringWithFormat:@"订单编号:  %@",self.clusterOrederDetail.order_id];
        
        
    }else if(indexPath.row==1){
        cell.typeStr=[NSString stringWithFormat:@"支付方式:  %@",self.clusterOrederDetail.pay_name];
       
    }else if (indexPath.row==2){
         cell.typeStr=[NSString stringWithFormat:@"收件人:  %@",self.clusterOrederDetail.name];
    }
    else if(indexPath.row==3){
        cell.typeStr=[NSString stringWithFormat:@"下单时间:  %@",[GSTimeTool formatterNumber:self.clusterOrederDetail.pay_time toType:GSTimeType_YYYYMMddHHmm]];
    }else if(indexPath.row==4){
        cell.typeStr=[NSString stringWithFormat:@"成团时间:  %@",[GSTimeTool formatterNumber:self.clusterOrederDetail.order_create_time toType:GSTimeType_YYYYMMddHHmm]];
        
    }
    return cell;
}
-(void)getClusterOrderDetail{
    GetClusterOrderDetailRequest*request=[GetClusterOrderDetailRequest request];
    request.orderDid=self.clusterListRespone.cid;
    request.order_id=self.orderId;
    [ESService getClusterOrderDetailRequest:request success:^(GetClusterOrderDetailRespone *respone) {
       
        self.clusterOrederDetail=respone;
        self.heardView.clusterOrederRespone=respone;
        NSString*str=[NSString stringWithFormat:@"%@",respone.address];
        //设置行距
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paraStyle.alignment = NSTextAlignmentLeft;
        paraStyle.lineSpacing = 5;//设置高度
        paraStyle.hyphenationFactor = 1.0;
        paraStyle.firstLineHeadIndent = 0.0;
        paraStyle.paragraphSpacingBefore = 0.0;
        paraStyle.headIndent = 0;
        paraStyle.tailIndent = 0;
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paraStyle};
        CGSize size = [str boundingRectWithSize:CGSizeMake(ScreenWidth-83, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        self.heardView.frame=CGRectMake(0, 0, ScreenWidth, size.height +(ScreenWidth *(205/617.0))+90);
        self.tableView.tableHeaderView=self.heardView;
        if (respone.clusterOrderStatus==ClusterOrderStatus_WaitReply||respone.clusterOrderStatus==ClusterOrderStatus_WaitSure) {
             self.footerView=[[ESClusterOrderDetailFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, (((ScreenWidth-3)/2.0 +50)*4+9+74+49))];
            self.tableView.tableFooterView=self.footerView;
            [self.view addSubview:self.bottomView];
            self.bottomView.respone=respone;
            [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@49);
                make.right.bottom.left.equalTo(@0);
            }];
        }else{
            
           
        }
         [self fetchRelatedGoodsGoods_id:respone.goods_id];
        
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
        
        self.footerView.relationArray=response;
        [self .tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
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
