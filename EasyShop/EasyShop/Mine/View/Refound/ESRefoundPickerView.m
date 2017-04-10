//
//  ESRefoundPickerView.m
//  EasyShop
//
//  Created by jiushou on 16/6/23.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESRefoundPickerView.h"
@interface ESRefoundPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    CGFloat left,top,width,height;
    CGFloat margin;
}
@property (nonatomic,strong)UIView* topView;
@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,strong)NSArray*arryStr;
@property (nonatomic,strong)NSString*rowStr;
@property (nonatomic,strong)NSArray*dataArray;
@property (nonatomic,strong)NSArray*refoundMoney;
@property (nonatomic,assign) BOOL isComfromRefoundMoney;
@end
@implementation ESRefoundPickerView
-(NSArray *)arryStr{
    if (_arryStr==nil) {
        _arryStr=@[@"不喜欢",@"不合适"];
    }
    return _arryStr;
}

//这里是退货,
- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = @[
                       @"商品质量问题",
                       @"商品与描述不符合",
                       @"商品错发/漏发",
                       @"包装/商品破损/有污迹",
                       @"商品假冒"
                       ];
    }
    return _dataArray;
}
//这里是退款
-(NSArray*)refoundMoney{
    if (_refoundMoney==nil  ) {
        _refoundMoney=@[@"我不想买了",@"订单信息有误",@"未按规定时间发货",@"拍错,重新下单"];
    }
    return _refoundMoney;
}

- (UIView *)topView
{
    if (!_topView) {
        left = 0;
        top  = 0;
        CGFloat topH = 44;
        CGFloat topW = kKeyWindow.width;
        _topView = [[UIView alloc] initWithFrame:CGRectMake(left, top, topW, topH)];
        _topView.backgroundColor = RGB(247, 247, 247);
        //取消按钮
        CGFloat buttonW = 60;
        CGFloat buttonH = topH;
        left = 0;
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(left, top, buttonW, buttonH)];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setTitleColor:RGB(233, 40, 46) forState:UIControlStateNormal];
        [_topView addSubview:cancelButton];
        //添加按钮
        left = topW - buttonW;
        UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(left, top, buttonW, buttonH)];
        [sureButton setTitle:@"确认" forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [sureButton setTitleColor:RGB(233, 40, 46) forState:UIControlStateNormal];
        [_topView addSubview:sureButton];
    }
    return _topView;
}
- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        CGFloat pickerH = 200;
        CGFloat pickerW = kKeyWindow.width;
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, pickerW, pickerH)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
-(instancetype)initWithFrame:(CGRect)frame andRefoundViewIsRemoney:(BOOL)isComfromRefoundMoney{
    if (self=[super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        UIControl *control = [[UIControl alloc] initWithFrame:self.bounds];
        [self addSubview:control];
        [control addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.topView];
        [self addSubview:self.pickerView];
        if (isComfromRefoundMoney) {
            self.rowStr=[self.refoundMoney objectAtIndex:0];
        }else{
            self.rowStr=[self.dataArray objectAtIndex:0];
        }
    }
    return self;
}
- (void)showPickerView
{
    [kKeyWindow addSubview:self];
    
    
}
- (void)hidePickerView
{
    [self removeFromSuperview];
}

-(void)cancleAction{
    [self hidePickerView];
}
-(void)sureAction{
    if (self.sussceBlock) {
        self.sussceBlock(self.rowStr);
    }
    [self hidePickerView];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    width = self.width;
    height = self.height;
    
    self.topView.top = height - self.topView.height - self.pickerView.height;
    self.pickerView.top = height - self.pickerView.height;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.isComfromRefoundMoney) {
        return self.refoundMoney.count;
    }
    return self.dataArray.count;
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.isComfromRefoundMoney) {
        return [self.refoundMoney objectAtIndex:row];
    }
    return [self.dataArray objectAtIndex:row];
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.isComfromRefoundMoney) {
        self.rowStr=[self.refoundMoney objectAtIndex:row];
    }
    else{
        self.rowStr=[self.dataArray objectAtIndex:row];
    }
    
}




@end
