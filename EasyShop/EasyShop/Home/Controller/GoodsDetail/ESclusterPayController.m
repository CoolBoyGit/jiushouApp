//
//  ESTogetherController.m
//  EasyShop
//
//  Created by jiushou on 16/10/9.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESclusterPayController.h"
#import "ESAddressListController.h"
#import "ICCouponController.h"
#import "ESClsterPayHearVIew.h"
#import "ESClsterPayBottomView.h"
#import "ClusterOrderDetailCon.h"
//展示商品的cell
#import "ESClsterPayShopNameCell.h"
#import "ESClsterPayGoodsDeCell.h"
#import "ESClsterPayNumberCell.h"
#import "ESClsterPayPrivilegeCell.h"
#import "ESClsterPayCountCell.h"
#import "ESPayViewCell.h"
#import "ESPayTool.h"
#import "ClusterPayMoneyItem.h"
@interface ESclusterPayController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ESClsterPayHearVIew*heardView;
@property (nonatomic,assign) NSInteger selectIndex;//用来标记支付方式
@property (nonatomic,strong) ESClsterPayBottomView*bottomView;
@property (nonatomic,strong) AddressInfo*info;//地址
@property (nonatomic,strong) GetSimpGoodsRespone*simpleRespone;
@property (nonatomic,assign) int count;
@property (nonatomic,strong) CouponInfo*couponInfo;
@property (nonatomic,strong) NSMutableArray*coponArray;
@property (nonatomic,assign) int page;

@end

@implementation ESclusterPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"拼团支付详情";
    self.page=1;
    self.count=1;
    self.selectIndex=0;
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@64);
        make.bottom.equalTo(@(-49));
    }];
    self.tableView.tableHeaderView=({
        self.heardView=[[ESClsterPayHearVIew alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [self.heardView addGestureRecognizer:tap];
        self.heardView;
    });
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.height.equalTo(@49);
        make.right.left.equalTo(@0);
    }];
    @weakify(self);
    self.bottomView.sureButtonBlock=^(){
        @strongify(self);
        switch (self.typeStaus) {
                
            case ClusterPayStaus_FromOrderJionCLuster:
                [self payClusterMoneyComeFromClusterOrderList];
                break;
            case ClusterPayStaus_FromHome:
                [self payClusterMoneyComeFromHomeDetail];//开团
                break;
            case ClusterPayStaus_FromHomeJionCLuster:
                [self payClusterMoneyComeFromJoinList];
                
                break;
            default:
                break;
        }
        
    };
    [self fetchDefaultAddress];
    [self getSimpGoodsMessage];
    [self fetchCoupon];
    [self addNitification];
    
}
-(void)addNitification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didPayApliySuccess:) name:kDidPaySuccessNotification object:nil];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)didPayApliySuccess:(NSNotification*)noti{
    ClusterOrderDetailCon*vc=[[ClusterOrderDetailCon alloc]init];
    vc.orderId=noti.userInfo[@"order_id"];
    sleep(0.4);
    [self.navigationController pushViewController:vc animated:YES];
    
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [mArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[self class]]) {
            [mArr removeObject:obj];
        }
    }];
    
    self.navigationController.viewControllers = [mArr copy];
    
    
}

-(NSMutableArray*)coponArray{
    if (_coponArray==nil) {
        _coponArray=[[NSMutableArray alloc]init];
    }
    return _coponArray;
}
-(void)tapAction{
    ESAddressListController*vc=[[ESAddressListController alloc]init];
    vc.isOrder=YES;
    @weakify(self);
    vc.addressBlock=^(AddressInfo*info){
        @strongify(self);
        self.heardView.info = info;
        self.info=info;
        NSString*str=[NSString stringWithFormat:@"%@%@",info.area,info.address];
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
        CGSize size = [str boundingRectWithSize:CGSizeMake(ScreenWidth-80, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        self.heardView.frame=CGRectMake(0, 0, ScreenWidth, size.height +90);
        self.tableView.tableHeaderView=self.heardView;
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(ESClsterPayBottomView *)bottomView{
    if (_bottomView==nil) {
        _bottomView=[[ESClsterPayBottomView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 49)];
    }
    return _bottomView;
}
#pragma mark tableView
-(UITableView*)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=RGBA(247, 247, 247, 1);
        //_tableView.backgroundColor=[UIColor whiteColor];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ESClsterPayShopNameCell class] forCellReuseIdentifier:@"ESClsterPayShopNameCell"];
        [_tableView registerClass:[ESClsterPayGoodsDeCell class] forCellReuseIdentifier:@"ESClsterPayGoodsDeCell"];
        [_tableView registerClass:[ESClsterPayNumberCell class] forCellReuseIdentifier:@"ESClsterPayNumberCell"];
        [_tableView registerClass:[ESClsterPayPrivilegeCell class] forCellReuseIdentifier:@"ESClsterPayPrivilegeCell"];
        [_tableView registerClass:[ESClsterPayCountCell class] forCellReuseIdentifier:@"ESClsterPayCountCell"];
        [_tableView registerClass:[ESPayViewCell class] forCellReuseIdentifier:@"ESPayViewCell"];
        
    }
    return _tableView;
}
#pragma mark tableView Delete Datasoure
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 5;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        if (indexPath.row==1) {
            return 100;
        }
        else{
            return 40;
        }
        
        
    }else{
        return 50;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==3) {
            ICCouponController*vc=[[ICCouponController alloc]init];//优惠卷
            switch (self.typeStaus) {
                case ClusterPayStaus_FromOrderJionCLuster:
                    vc.goodsId=self.clusterDetail.goods_id;
                    break;
                case ClusterPayStaus_FromHome:
                    vc.goodsId=self.goods_id;
                    break;
                case ClusterPayStaus_FromHomeJionCLuster:
                    vc.goodsId=self.clusterRespone.goods_id;
                    
                    break;
                default:
                    break;
            }
            
            vc.couponType=CouponType_selectCluster;
            vc.isComeFromUserCenter=NO;
            @weakify(self);//每次修改价格都要重新修改
            vc.couponBlock = ^(CouponInfo *info){
                @strongify(self);
                ClusterPayMoneyItem*item=[[ClusterPayMoneyItem alloc]init];
                self.couponInfo = info;
                item.price=self.simpleRespone.cluster_price;
                item.count=self.count;
                item.coupnonValue=self.couponInfo.c_value;
                [[NSNotificationCenter defaultCenter]postNotificationName:CountCLusterPriceChange object:nil userInfo:[NSDictionary dictionaryWithObject:item forKey:@"count"]];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                
            };
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section==1) {
        self.selectIndex=indexPath.row;
        [self.tableView reloadData];
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        view.backgroundColor=RGB(247, 247, 247);
        return view;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 10;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        switch (indexPath.row) {
            case 0:{
                ESClsterPayShopNameCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESClsterPayShopNameCell"];
                cell.simpleGoodsRespone=self.simpleRespone;
                return cell;
            }
                break;
                
            case 1:{
                ESClsterPayGoodsDeCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESClsterPayGoodsDeCell"];
                cell.simpleGoodsRespone=self.simpleRespone;
                return cell;
            }
                break;
            case 2:{
                ESClsterPayNumberCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESClsterPayNumberCell"];
                
                @weakify(self);
                cell.minuBlock=^(){
                    @strongify(self);
                    self.count--;
                    ClusterPayMoneyItem*item=[[ClusterPayMoneyItem alloc]init];
                    item.price=self.simpleRespone.cluster_price;
                    item.count=self.count;
                    item.coupnonValue=self.couponInfo.c_value;
                    [[NSNotificationCenter defaultCenter]postNotificationName:CountCLusterPriceChange object:nil userInfo:[NSDictionary dictionaryWithObject:item forKey:@"count"]];
                    [self.tableView reloadData];
                };
                cell.addBlock=^(){
                    @strongify(self);
                    
                    self.count++;
                    ClusterPayMoneyItem*item=[[ClusterPayMoneyItem alloc]init];
                    item.price=self.simpleRespone.cluster_price;
                    item.count=self.count;
                    item.coupnonValue=self.couponInfo.c_value;
                    [[NSNotificationCenter defaultCenter]postNotificationName:CountCLusterPriceChange object:nil userInfo:[NSDictionary dictionaryWithObject:item forKey:@"count"]];
                    [self.tableView reloadData];
                };
                cell.count=self.count;
                
                return cell;
            }
                break;
            case 3:{
                ESClsterPayPrivilegeCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESClsterPayPrivilegeCell"];
                cell.countStr=[NSString stringWithFormat:@"%ld",self.coponArray.count];
                if (self.couponInfo!=nil) {
                    cell.couponInfo=self.couponInfo;
                }
                
                
                
                return cell;
            }
                break;
            case 4:{
                ESClsterPayCountCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESClsterPayCountCell"];
                float mo=[self.simpleRespone.cluster_price floatValue];
                cell.count=self.count*mo;
                cell.respone=self.simpleRespone;
                return cell;
            }
                break;
            default:
                break;
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            
            ESPayViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESPayViewCell"];
            cell.titleStr=@"支付宝";
            cell.imageStr=@"payalipay";
            cell.selectedBlock=^(){
                // self.selFlag++;
                self.selectIndex= 0;
                [self.tableView reloadData];
            };
            if (self.selectIndex==indexPath.row) {
                cell.select=YES;
            }else{
                cell.select=NO;
            }
            return cell;
            
            
            
            
        }else{
            ESPayViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESPayViewCell"];
            cell.titleStr=@"微信";
            cell.imageStr=@"weixin";
            cell.selectedBlock=^(){
                self.selectIndex= 1;
                [self.tableView reloadData];
            };
            if (self.selectIndex==indexPath.row) {
                cell.select=YES;
            }else{
                cell.select=NO;
            }
            return cell;
            
            
        }
    }
    return nil;
}
#pragma mark 获取商品的信息
-(void)getSimpGoodsMessage{
    GetSimpGoodsRequest*request=[GetSimpGoodsRequest request];
    
    switch (self.typeStaus) {
            
        case ClusterPayStaus_FromOrderJionCLuster:
            request.goods_id=self.clusterDetail.goods_id;
            
            break;
        case ClusterPayStaus_FromHome:
            request.goods_id=self.goods_id;
            
            break;
        case ClusterPayStaus_FromHomeJionCLuster:
            request.goods_id=self.clusterDetail.goods_id;
            
            break;
        default:
            break;
    }
    [ESService getClusterSimpleGoodsRequest:request success:^(GetSimpGoodsRespone *respone) {
        self.simpleRespone=[[GetSimpGoodsRespone alloc]init];
        self.bottomView.simpleGoods=respone;
        self.simpleRespone=respone;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark 获取用户默认地址
- (void)fetchDefaultAddress
{
    AddressRequest *request = [AddressRequest request];
    
    @weakify(self);
    [ESService addressRequest:request success:^(AddressInfo *response) {
        @strongify(self);
        self.heardView.info=response;
        self.info=response;
        if (response==nil) {
            
        }else{
            NSString*str=[NSString stringWithFormat:@"%@%@",response.area,response.address];
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
            CGSize size = [str boundingRectWithSize:CGSizeMake(ScreenWidth-80, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
            self.heardView.frame=CGRectMake(0, 0, ScreenWidth, size.height +90);
            self.tableView.tableHeaderView=self.heardView;
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}


//微信这是参团
-(void)joinPayWeixin:(JoinClusterRequest*)request{
    [ESService joinWeixinClusterRequest:request success:^(WeixinPayAllInfo *response) {
        //保存order_id;
        [[NSUserDefaults  standardUserDefaults] setObject:response.order_id forKey:@"order_id"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[ESPayTool payTool]handleWexinPayWithInfo:response.result];
    } failure:^(NSError *error) {
        
    }];
    
}
//支付宝这个是参团
-(void)joinPayAliPay:(JoinClusterRequest*)request{
    [ESService joinClusterRequest:request success:^(NSString *response) {
        
        [[ESPayTool payTool]handleAliPayWithOrder:response];
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)createPayAlipy:(CreateClusterRequest*)request{
    [ESService createClusterRequest:request success:^(NSString *response) {
        
        [[ESPayTool payTool]handleAliPayWithOrder:response];
    } failure:^(NSError *error) {
        
        
    }];

}
-(void)createPayWeixin:(CreateClusterRequest*)request{
    [ESService createWeixinClusterRequest:request success:^(WeixinPayAllInfo *response) {
        //保存order_id;
        [[NSUserDefaults  standardUserDefaults] setObject:response.order_id forKey:@"order_id"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[ESPayTool payTool]handleWexinPayWithInfo:response.result];
    } failure:^(NSError *error) {
        
    }];
}
///点击来自拼团订单的拼团详情的参团显示进入的 支付宝支付
-(void)payClusterMoneyComeFromClusterOrderList{
    JoinClusterRequest*request=[JoinClusterRequest request];
    request.cluster_id=self.clusterId;
    request.goods_id=self.clusterDetail.goods_id;
    request.goods_num=[NSNumber numberWithShort:self.count];
    request.addr_id=self.info.aid;
    request.coupon_num=self.couponInfo.c_num;
    if (self.selectIndex==0) {
        request.pay_channel=@1;
        [self joinPayAliPay:request];
    }else{
        request.pay_channel=@2;
        [self joinPayWeixin:request];
    }
    
    
    
    
}
//点击拼团详情的参团显示进入的 支付宝支付
-(void)payClusterMoneyComeFromJoinList{
    JoinClusterRequest*request=[JoinClusterRequest request];
    request.cluster_id=self.clusterRespone.cid;
    request.goods_id=self.clusterRespone.goods_id;
    request.goods_num=[NSNumber numberWithShort:self.count];
    request.addr_id=self.info.aid;
    request.coupon_num=self.couponInfo.c_num;
    if (self.selectIndex==0) {
        request.pay_channel=@1;
        [self joinPayAliPay:request];
    }else{
        request.pay_channel=@2;
        [self joinPayWeixin:request];
    }
    
    
}
//来自详情页直接点击2人团创团
-(void)payClusterMoneyComeFromHomeDetail{
    
    CreateClusterRequest *request=[CreateClusterRequest request];
    request.goods_id=self.goods_id;
    request.goods_num=[NSNumber numberWithShort:self.count];
    request.addr_id=self.info.aid;
    request.coupon_num=self.couponInfo.c_num;
    if (self.selectIndex==0) {
        request.pay_channel=@1;
        [self createPayAlipy:request];
    }else{
        request.pay_channel=@2;
        [self createPayWeixin:request];
    }
    
    
   }
#pragma mark - 请求个人中心页的优惠券
- (void)fetchCoupon
{
    GetclusterCouponRequest*request=[GetclusterCouponRequest request];
    switch (self.typeStaus) {
        case ClusterPayStaus_FromOrderJionCLuster:
            request.goods_id=self.clusterDetail.goods_id;
            break;
        case ClusterPayStaus_FromHome:
            request.goods_id=self.goods_id;
            break;
        case ClusterPayStaus_FromHomeJionCLuster:
            request.goods_id=self.clusterRespone.goods_id;
            break;
        default:
            break;
    }
    
    
    
    @weakify(self);
    [ESService GetclusterCouponRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self.coponArray removeAllObjects];
        [self.coponArray addObjectsFromArray:response];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];}
@end
