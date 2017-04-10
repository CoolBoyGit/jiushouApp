//
//  ICCardTypePickerView.m
//  iCarePregnant
//
//  Created by wcz on 16/6/28.
//  Copyright © 2016年 oenius. All rights reserved.
//

#import "ICCardTypePickerView.h"

@interface ICCardTypePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic,strong) NSArray*refoundMoney;
@property (nonatomic,assign) BOOL isRefoundMoney;
@end

@implementation ICCardTypePickerView

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
- (UIPickerView *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickerView.backgroundColor=[UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
-(instancetype)initWithFrame:(CGRect)frame andIsComFromRefound:(BOOL)isComRefound{
    
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = RGBA(241, 241, 241, 0.5);
        
        self.isRefoundMoney=isComRefound;
        [self addSubview:self.pickerView];
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(@0);
            make.height.equalTo(@160);
        }];
        
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.isRefoundMoney) {
        return self.refoundMoney.count;
    }else{
        return self.dataArray.count;
        
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.isRefoundMoney) {
        return self.refoundMoney[row];
        
    }
    else{
        return self.dataArray[row];
        
    }
    
}

- (NSString *)pickInfo
{
    if (self.isRefoundMoney) {
        return self.refoundMoney[[self.pickerView selectedRowInComponent:0]];
    }else{
        return self.dataArray[[self.pickerView selectedRowInComponent:0]];
    }
    
}


@end
