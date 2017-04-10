

//
//  ESESRefoundController.m
//  EasyShop
//
//  Created by wcz on 16/6/23.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESESRefoundController.h"
#import "ESRefoundTexdField.h"
#import "ESRefoundPickerView.h"
#import "ICAlert.h"
#import "ESRefundResultCon.h"
#import "ESRefoundCell.h"
#import "ESRefoundResonModel.h"
#import "ESRefoundFooterView.h"
@interface ESESRefoundController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ESRefoundTexdField *applySericeField;
@property (nonatomic, strong) ESRefoundTexdField *drawbackReasonField;
@property (nonatomic, strong) ESRefoundTexdField *drawbackMoneyField;
@property (nonatomic, strong) ESRefoundTexdField *explainField;
//@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic ,strong) UITableView*tableView;
/** indicator */
@property (nonatomic,strong) ESIndicator *indicator;
/** 退款数组*/
@property (nonatomic,strong) NSArray*refoundMoArray;
/** 退货数组*/
@property (nonatomic,strong) NSArray*refoundArray;

@property (nonatomic,strong) ESRefoundPickerView*pickerView;
@end

@implementation ESESRefoundController

-(NSArray *)refoundMoArray{
    if (_refoundMoArray==nil) {
        NSMutableArray*array=[NSMutableArray array];
        [array addObject:[ESRefoundResonModel refoundResonModel:@"申请服务" andresonStr:@"我要退款"]];
        ESRefoundResonModel*model=[ESRefoundResonModel refoundResonModel:@"退款原因" andresonStr:@"退款原因"];
        model.tapBlaock=^(){
            [self showPickerView:YES];
        };
        [array addObject:model];
        [array addObject:[ESRefoundResonModel refoundResonModel:@"退款金额" andresonStr:[NSString stringWithFormat:@"¥%@",self.orderInfo.total_fee]]];
        [array addObject:[ESRefoundResonModel refoundResonModel:@"退款说明" andresonStr:@""]];
        _refoundMoArray=[array copy];
    }
    
    return _refoundMoArray;
}
-(NSArray *)refoundArray{
    if (_refoundArray==nil) {
         NSMutableArray*array=[NSMutableArray array];
        [array addObject:[ESRefoundResonModel refoundResonModel:@"申请服务" andresonStr:@"我要退货"]];
        ESRefoundResonModel*model=[ESRefoundResonModel refoundResonModel:@"退货原因" andresonStr:@"退货原因"];
        model.tapBlaock=^(){
            [self showPickerView:NO];
        };
        [array addObject:model];
        [array addObject:[ESRefoundResonModel refoundResonModel:@"退款金额" andresonStr:[NSString stringWithFormat:@"¥%@",self.orderInfo.total_fee]]];
         [array addObject:[ESRefoundResonModel refoundResonModel:@"退货说明" andresonStr:@""]];
        _refoundArray=[array copy];
    }
    return _refoundArray;
}
-(void)showPickerView:(BOOL)isRefoundMoney{
    self.pickerView=[[ESRefoundPickerView alloc]initWithFrame:kKeyWindow.bounds andRefoundViewIsRemoney:isRefoundMoney];
    @weakify(self);
    self.pickerView. sussceBlock=^(NSString *str){
        @strongify(self);
        if (isRefoundMoney) {
            
            ESRefoundResonModel*model=[self.refoundMoArray objectAtIndex:1];
            model.resonStr=str;
            
        }else{
            ESRefoundResonModel*model=[self.refoundArray objectAtIndex:1];
            model.resonStr=str;
            
        }
        [self.tableView reloadData];
    };
    [self.pickerView showPickerView];
    
}
- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}


- (ESRefoundTexdField *)applySericeField
{
    if (_applySericeField == nil) {
        _applySericeField = [[ESRefoundTexdField alloc] initWithLeftTitleName:@"申请服务" andBOOL:NO];
        _applySericeField.enabled=NO;
        _applySericeField.layer.cornerRadius=5;
        _applySericeField.layer.masksToBounds=YES;
        _applySericeField.delegate=self;
        _applySericeField.text = self.isRefound ? @"退款":@"退货"; //@"仅退款";
    }
    return _applySericeField;
}

- (ESRefoundTexdField *)drawbackReasonField
{
    if (_drawbackReasonField == nil) {
        if (self.isRefound) {
            _drawbackReasonField = [[ESRefoundTexdField alloc] initWithLeftTitleName:@"退款原因"andBOOL:NO];
            _drawbackReasonField.text = @"请选择退款原因";
        }else{
            _drawbackReasonField = [[ESRefoundTexdField alloc] initWithLeftTitleName:@"退货原因"andBOOL:NO];
            _drawbackReasonField.text = @"请选择退货原因";
        }
        
        _drawbackReasonField.layer.cornerRadius=5;
        _drawbackReasonField.layer.masksToBounds=YES;
        _drawbackReasonField.delegate=self;
        
    }
    return _drawbackReasonField;
}

- (ESRefoundTexdField *)drawbackMoneyField
{
    if (_drawbackMoneyField == nil) {
        _drawbackMoneyField = [[ESRefoundTexdField alloc] initWithLeftTitleName:@"退款金额" andBOOL:NO];
        _drawbackMoneyField.enabled=NO;
        _drawbackMoneyField.layer.cornerRadius=5;
        _drawbackMoneyField.layer.masksToBounds=YES;
        _drawbackMoneyField.delegate=self;
        _drawbackMoneyField.text = [NSString stringWithFormat:@"¥%@",self.orderInfo.total_fee];// @"¥6";
    }
    return _drawbackMoneyField;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (ESRefoundTexdField *)explainField
{
    if (_explainField == nil) {
        if (self.isRefound) {
            _explainField = [[ESRefoundTexdField alloc] initWithLeftTitleName:@"退款说明" andBOOL:NO];
        }else{
            _explainField = [[ESRefoundTexdField alloc] initWithLeftTitleName:@"退货说明" andBOOL:NO];
        }
        
        _explainField.layer.cornerRadius=5;
        _explainField.layer.masksToBounds=YES;
        _explainField.placeholder = @"最多200字";
        _explainField.delegate=self;
    }
    return _explainField;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.pickerView hidePickerView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //TitleCenter;
    if (self.isRefound) {
       self.navigationItem.title =@"退款理由";
    }else{
        self.navigationItem.title=@"退货理由";
    }
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@64);
        make.bottom.equalTo(@-44);
    }];
    
   ESRefoundFooterView*footerView =[[ESRefoundFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 250)];
    self.tableView.tableFooterView=footerView;
    if (self.isRefound) {
        footerView.model=[self.refoundMoArray objectAtIndex:3];
    }else{
         footerView.model=[self.refoundArray objectAtIndex:3];
    }
//    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.applySericeField];
//    self.applySericeField.backgroundColor = RGB(240, 240, 240);
//    [self.applySericeField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@12);
//        make.top.equalTo(@84);
//        make.right.equalTo(@(-12));
//        make.height.equalTo(@49);
//    }];
//    [self.view addSubview:self.drawbackReasonField];
//    self.drawbackReasonField.backgroundColor = RGB(240, 240, 240);
//    [self.drawbackReasonField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@12);
//        make.top.equalTo(self.applySericeField.mas_bottom).offset(20);
//        make.right.equalTo(@(-12));
//        make.height.equalTo(@49);
//    }];
////
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button addTarget:self action:@selector(selectResion) forControlEvents:UIControlEventTouchUpInside];
//     [self.view addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@12);
//        make.top.equalTo(self.applySericeField.mas_bottom).offset(20);
//        make.right.equalTo(@(-12));
//        make.height.equalTo(@49);
//    }];
//
//    [self.view addSubview:self.drawbackMoneyField];
//    self.drawbackMoneyField.backgroundColor = RGB(240, 240, 240);
//    [self.drawbackMoneyField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@12);
//        make.top.equalTo(self.drawbackReasonField.mas_bottom).offset(20);
//        make.right.equalTo(@(-12));
//        make.height.equalTo(@49);
//    }];
//    [self.view addSubview:self.explainField];
//    self.explainField.backgroundColor = RGB(240, 240, 240);
//    [self.explainField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@12);
//        make.top.equalTo(self.drawbackMoneyField.mas_bottom).offset(20);
//        make.right.equalTo(@(-12));
//        make.height.equalTo(@49);
//    }];
//    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    loginButton.layer.cornerRadius = 5;
//    loginButton.layer.masksToBounds = YES;
    [loginButton setTitle:@"提交申请" forState:UIControlStateNormal];
    loginButton.backgroundColor = AllButtonBackColor;
    [loginButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    loginButton.titleLabel.font = ADeanFONT15;
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right. equalTo(@0);
        make.height.equalTo(@44);
        make.bottom.equalTo(@0);
    }];

}
-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=RGBA(237, 237, 237, 1);
        [_tableView registerClass:[ESRefoundCell class] forCellReuseIdentifier:@"ESRefoundCell"];
    }
    return _tableView;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ESRefoundCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESRefoundCell"];
    if (self.isRefound) {
        cell.model=[self.refoundMoArray objectAtIndex:indexPath.row];
    }else{
        cell.model=[self.refoundArray objectAtIndex:indexPath.row];
    }
    if (indexPath.row==1) {
        cell.isHidden=NO;
    }
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isRefound) {
        return self.refoundMoArray.count-1;
    }
    return self.refoundArray.count-1;
}
//这里是显示原因
- (void)selectResion
{
    if (self.isRefound) {
        [[ICAlert alert]showPickerVieTextField:self.drawbackReasonField andComFromRefound:YES];
    }else{
        [[ICAlert alert]showPickerVieTextField:self.drawbackReasonField andComFromRefound:NO];
    }
    
  

}

- (void)sureAction
{
    [self applyOrder];
}

#pragma mark - Networking
/** 申请退款 */
- (void)applyOrder
{
    ApplyOrderRequest *request = [ApplyOrderRequest request];
    request.type        = self.isRefound ? @1 : @2; // 退款 : 退货
    request.order_id    = self.orderInfo.order_id;
    if (self.isRefound) {
        request.reason=((ESRefoundResonModel*)self.refoundMoArray[1]).resonStr;
        request.message     =((ESRefoundResonModel*)self.refoundMoArray[3]).resonStr;
    }else{
        request.reason=((ESRefoundResonModel*)self.refoundArray[1]).resonStr;
        request.message     =((ESRefoundResonModel*)self.refoundArray[3]).resonStr;
    }
    
    
    
    @weakify(self);
    [self.indicator startAnimation];
    [ESService  applyOrderRequest:request success:^{
        @strongify(self);
        [self endGSNetworking];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kReloadRefoundOrderListNotification object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:KKUpdateAllOredrCountNotifacation object:nil];
        ESRefundResultCon *vc=[[ESRefundResultCon alloc]init];
        if (request.type.intValue==1) {
            vc.reasonStr=@"退款";
        }else{
            vc.reasonStr=@"退货";
        }
        vc.order_id=request.order_id;
        vc.isFromRefund=YES;
        [self.navigationController pushViewController:vc animated:YES];
        
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
