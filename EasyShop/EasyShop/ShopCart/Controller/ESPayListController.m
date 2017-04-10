//
//  ESPayListController.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/4.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESPayListController.h"
#import "ESPayTool.h"
#import "ESIndicator.h"
#import "ESMyOrderPageController.h"
#import "ESOrderDetailController.h"
#import "ESTableViewCouponCell.h"
#import "ICCouponController.h"


#import "ESPayViewCell.h"
#import "AllInPayData.h"
#import "APay.h"
#import "ESPayListCell.h"
@interface ESPayListController()<UITableViewDataSource,UITableViewDelegate,APayDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int    selectIndex;
/** indicator */
@property (nonatomic,strong) ESIndicator *indicator;
@property (nonatomic, assign) BOOL isCounpon;
@property (nonatomic,assign) int payflag;//用来判断是否移除订单详情页面.
/** 优惠券信息 */
@property (nonatomic,strong) CouponInfo *couponInfo;

@property (nonatomic,strong) NSMutableArray*couponItems;
@end

@implementation ESPayListController
-(NSMutableArray *)couponItems{
    if (_couponInfo==nil) {
        _couponItems=[NSMutableArray array];
    }
    return _couponItems;
}
- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESPayViewCell class] forCellReuseIdentifier:@"ESPayViewCell"];
        [_tableView registerClass:[ESTableViewCouponCell class] forCellReuseIdentifier:@"ESTableViewCouponCell"];
        [_tableView registerClass:[ESPayListCell class] forCellReuseIdentifier:@"ESPayListCell"];

        
    }
    return _tableView;
}

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    
    [self addNotification];
    
    self.selectIndex=1;
    [[NSUserDefaults standardUserDefaults]setObject:self.total_fee forKey:@"total_fee"];
    self.view.backgroundColor = [UIColor whiteColor];
   self.navigationItem.title = @"支付订单";
    self.navigationController.navigationItem.title=@"购物车";
//    [self initalizedCumstomNav];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@64);
        make.height.equalTo(@400);
    }];
    self.payflag=0;
//    UIView *bgview  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
//    
//    self.tableView.tableFooterView = bgview;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 60, 60);
    [button setTitle:@"确认支付" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius=5;
    button.layer.masksToBounds=YES;
    button.backgroundColor = RGB(233, 40, 46);
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //[bgview addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.top.equalTo(self.tableView.mas_bottom).offset(20);
        make.right.equalTo(@-60);
        //make.centerY.equalTo(@(0));
        make.height.equalTo(@(44));
    }];
    [self fetchSelectCoupon];
}


- (void)dealloc
{
    [self removeNotification];
}

#pragma mark - Notification
- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didPaySuccessAction:) name:kDidPaySuccessNotification object:nil];
   // [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(didPaySuccessAction:) name:KClusterDidPaySuccessNotification object:nil];
}
- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//通联支付
-(void)didPaySuccessAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//支付成功返回 在appdelete中注册通知

- (void)didPaySuccessAction:(NSNotification*)noti
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kReloadOrderListNotification object:nil];
    ESOrderDetailController*vc=[[ESOrderDetailController alloc]init];
    vc.order_id=noti.userInfo[@"order_id"];
    [self.navigationController pushViewController:vc animated:YES];
    // 1. 如果是从订单详情页面进入，从堆栈删除
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
   ///这里的问题太深奥了????????
    
    [mArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      
        if ([obj isKindOfClass:[ESPayListController class]]) {
            
            [mArr removeObject:obj];
            
        }

        }];
    
    if (self.isComFromOrderDetail) {
        if (mArr.count!=0) {
              [mArr removeObjectAtIndex:mArr.count-2];
        }
      
        
    }
    self.navigationController.viewControllers = [mArr copy];

}

#pragma mark
#pragma mark - tableview代理方法;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 2;
    }
    if (section ==0) {
        return 1;
    }
    if (section==1) {
        return 1;
    }
    return 0;
    //return self.isCounpon?1:0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 0;
}

- (void)gesTap
{
    self.isCounpon = !self.isCounpon;
    [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2){
        return 44;
    }
    if (indexPath.section == 1) {
        return 44;
    }
    return 46.5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell0"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.textColor=AllTextColor;
        cell.textLabel.text = @"订单金额";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.textColor = RGB(233, 40, 46);
        cell.detailTextLabel.font=[UIFont systemFontOfSize:17];
        NSString*str=[NSString stringWithFormat:@"¥%.2f",self.total_fee.floatValue];
        NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc]initWithString:str];
        [muStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:14.5]} range:NSMakeRange(0, 1)];
        [muStr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46),NSFontAttributeName:[UIFont systemFontOfSize:14.5]} range:NSMakeRange(str.length-2, 2)];
        cell.detailTextLabel.attributedText=muStr;
        
        return cell;
    } else if (indexPath.section == 1) {
        ESPayListCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESPayListCell"];
        cell.countStr=[NSString stringWithFormat:@"%ld",self.couponItems.count];
        if (self.couponInfo!=nil) {
            cell.couponInfo=self.couponInfo;
        }
        return cell;
    } else if (indexPath.section == 2) {
                if (indexPath.row == 0) {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
                    if (cell == nil) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell2"];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    }

            cell.textLabel.text = @"选择支付方式";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
                    cell.textLabel.textColor=AllTextColor;
                    return cell;
        }
        //这里要改写
        else if (indexPath.row == 1) {
            ESPayViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESPayViewCell"];
            cell.titleStr=@"支付宝";
            cell.imageStr=@"payalipay";
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
        else if(indexPath.row==2){
            ESPayViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESPayViewCell"];
            cell.titleStr=@"微信";
            cell.imageStr=@"payweixin";
            cell.selectedBlock=^(){
                
                self.selectIndex= 2;
                [self.tableView reloadData];
            };
            if (self.selectIndex==indexPath.row) {
                cell.select=YES;
            }else{
                cell.select=NO;
            }
            return cell;
            
        }
        
   
        else if(indexPath.row==3){
        ESPayViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESPayViewCell"];
        cell.titleStr=@"通联支付";
        cell.imageStr=@"paytl";
        
        
        cell.selectedBlock=^(){
            self.selectIndex= 2;
            
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2 && indexPath.row > 0) {
        self.selectIndex = (int)indexPath.row;
        [self.tableView reloadData];
    }if (indexPath.section==1) {
        ICCouponController *vc=[[ICCouponController alloc ]init];
        vc.couponType=CouponType_Select;
        vc.order_id=self.order_id;
        vc.isComeFromUserCenter=NO;
        @weakify(self);//每次修改价格都要重新修改
        vc.couponBlock = ^(CouponInfo *info){
            @strongify(self);
            NSString*money=[[NSUserDefaults standardUserDefaults]objectForKey:@"total_fee"];
            self.couponInfo = info;
            self.total_fee=[NSNumber numberWithFloat:money.floatValue-[self.couponInfo.c_value floatValue ]];
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//            
//            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark  16.4 获取某个订单可以用到的优惠券
- (void)fetchSelectCoupon
{
    SelectCouponRequest *request=[SelectCouponRequest request];
    request.order_id=self.order_id;
    @weakify(self);
    [ESService selectCouponRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        
        [self.couponItems removeAllObjects];
        [self.couponItems addObjectsFromArray:response];
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
        
    }];
}

-(void)btnClick
{
    if (self.selectIndex == 1) {
        [self fetchPayMsgWithType:ESPayType_Ali];//支付宝
    }
    else if(self.selectIndex==2){
        [self fetchPayMsgWithType:ESPayType_Weixin];//微信
    }
    else{
        [self fetchPayMsgWithType:ESPayType_AllIn];//通联
    }
}


/**
 *  处理通联支付
 */
- (void)handleAllInPay
{
    AllInPayData *allInPay  = [[AllInPayData alloc] init];
    allInPay.orderNo        = self.order_id;
    allInPay.orderAmount    = [NSString stringWithFormat:@"%0.f",self.total_fee.doubleValue*100];//按分作为单位
    allInPay.productName    = @"测试商品1";
//    allInPay.ext1           = @"<USER>201410131001556</USER>";//暂时不传
    
    //@param mode
    //00 生产环境
    //01 测试环境
    
    //在测试与生产环境之间切换的时候请注意修改mode参数
    
    [APay startPay:allInPay.payData viewController:self delegate:self mode:@"01"];
    
}

#pragma mark - APayDelegate
//通联支付
- (void)APayResult:(NSString *)result {
    
    NSArray *parts = [result componentsSeparatedByString:@"="];
    NSError *error;
    NSData *data = [[parts lastObject] dataUsingEncoding:NSUTF8StringEncoding];
    //这里是解析数据返回数据
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSInteger payResult = [dic[@"payResult"] integerValue];
    NSString *format_string = @"支付结果::支付%@";
    if (payResult == APayResultSuccess) {
        NSLog(format_string,@"成功");
        [ESToast showSuccess:@"支付成功！"];
        [[NSNotificationCenter defaultCenter ]postNotificationName:KKUpdateAllOredrCountNotifacation object: nil];
        [self didPaySuccessAction];
    } else if (payResult == APayResultFail) {
        NSLog(format_string,@"失败");
        [ESToast showSuccess:@"支付失败！"];
    } else if (payResult == APayResultCancel) {
        NSLog(format_string,@"取消");
        [ESToast showSuccess:@"支付取消！"];
    }
}


#pragma mark - Networkings使用优惠卷
- (void)fetchPayMsgWithType:(ESPayType)type
{
    GetPayMsgRequest *request = [GetPayMsgRequest request];
    request.order_id = self.order_id;
    request.coupon_num  = self.couponInfo.c_num;//优惠券码
    switch (type) {
        case ESPayType_Weixin:
        {
            request.channel = @2;
            [self handleWeixinPayWithRequest:request];
        }
            break;
        case ESPayType_Ali:
        {
            request.channel = @1;
            [self handleAliPayWithReqeust:request];
        }
            break;
        case ESPayType_AllIn:
        {
            request.channel = @3;
            [self handleAllInPayWithReqeust:request];
        }
            break;
    }

}

- (void)handleWeixinPayWithRequest:(GetPayMsgRequest *)request
{
    @weakify(self);
    [self.indicator startAnimation];
    [ESService getWeixinPayMsgRequest:request success:^(WeixinPayAllInfo *response) {
       @strongify(self);
        [self endGSNetworking];
        [[NSUserDefaults standardUserDefaults]setObject:response.order_id forKey:@"order_id"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[ESPayTool payTool] handleWexinPayWithInfo:response.result];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}
//支付宝快捷支付
- (void)handleAliPayWithReqeust:(GetPayMsgRequest *)request
{
    @weakify(self);
    [self.indicator startAnimation];
    [ESService getAliPayMsgRequest:request success:^(NSString *response) {
        @strongify(self);
        [self endGSNetworking];
        
        [[ESPayTool payTool] handleAliPayWithOrder:response];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}

- (void)handleAllInPayWithReqeust:(GetPayMsgRequest *)request
{
    @weakify(self);
    [self.indicator startAnimation];
    [ESService getAllInPayMsgRequest:request success:^(NSString *response) {
        @strongify(self);
        [self endGSNetworking];
        
        //调起通联支付控件
        
        //@param mode
        //00 生产环境
        //01 测试环境
        NSLog(@"%@",response);
        //在测试与生产环境之间切换的时候请注意修改mode参数
        [APay startPay:response viewController:self delegate:self mode:@"01"];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}

#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.indicator stopAnimation];
}

@end
