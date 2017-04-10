//
//  ESDistrictPickerView.m
//  EasyShop
//
//  Created by guojian on 16/5/18.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESDistrictPickerView.h"

@interface ESDistrictPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    CGFloat left,top,width,height;
    CGFloat margin;
}

/** topView */
@property (nonatomic,strong) UIView *topView;
/** pickerView */
@property (nonatomic,strong) UIPickerView *pickerView;

/** 省 */
@property (nonatomic,strong) NSArray *provinceItems;
@property (nonatomic,strong) DistrictInfo *provinceInfo;
/** 市 */
@property (nonatomic,strong) NSArray *cityItems;
@property (nonatomic,strong) DistrictInfo *cityInfo;
/** 区 */
@property (nonatomic,strong) NSArray *areaItems;
@property (nonatomic,strong) DistrictInfo *areaInfo;

@end

@implementation ESDistrictPickerView

- (void)setProvinceInfo:(DistrictInfo *)provinceInfo
{
    _provinceInfo = provinceInfo;
    
    [self fetchWithType:DistrictType_City];
}
- (void)setCityInfo:(DistrictInfo *)cityInfo
{
    _cityInfo = cityInfo;
    
    [self fetchWithType:DistrictType_Area];
}

- (UIView *)topView
{
    if (!_topView) {
        left = 0;
        top  = 0;
        CGFloat topH = 44;
        CGFloat topW = kKeyWindow.width;
        _topView = [[UIView alloc] initWithFrame:CGRectMake(left, top, topW, topH)];
        //取消按钮
        CGFloat buttonW = 60;
        CGFloat buttonH = topH;
        left = 0;
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(left, top, buttonW, buttonH)];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:RGBA(233, 40, 46, 1) forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_topView addSubview:cancelButton];
        _topView.backgroundColor=RGBA(246, 246, 246, 1);
        //添加按钮
        left = topW - buttonW;
        UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(left, top, buttonW, buttonH)];
        [sureButton setTitle:@"确认" forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [sureButton setTitleColor:RGBA(233, 40, 46, 1) forState:UIControlStateNormal];
        [_topView addSubview:sureButton];
    }
    return _topView;
}

- (void)cancleAction
{
    [self hidePickerView];
}
- (void)sureAction
{
    if (self.sureBlock) {
        self.sureBlock(self.provinceInfo,self.cityInfo,self.areaInfo);
    }
    [self hidePickerView];
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

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        UIControl *control = [[UIControl alloc] initWithFrame:self.bounds];
        [self addSubview:control];
        [control addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.topView];
        [self addSubview:self.pickerView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    width = self.width;
    height = self.height;
    
    self.topView.top = height - self.topView.height - self.pickerView.height;
    self.pickerView.top = height - self.pickerView.height;
}

#pragma mark -
- (void)showPickerView
{
    [kKeyWindow addSubview:self];
    
    [self fetchWithType:DistrictType_Province];
}
- (void)hidePickerView
{
    [self removeFromSuperview];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {//省
        return self.provinceItems.count;
    }else if (component == 1){//市
        return self.cityItems.count;
    }else{//区
        return self.areaItems.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    DistrictInfo *info = nil;
    if (component == 0) {//省
        info =   [self.provinceItems objectAtIndex:row];
    }else if (component == 1){//市
        info = [self.cityItems objectAtIndex:row];
    }else{//区
        info = [self.areaItems objectAtIndex:row];
    }
    return info.name;
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {//省
        self.provinceInfo =   [self.provinceItems objectAtIndex:row];
    }else if (component == 1){//市
        self.cityInfo = [self.cityItems objectAtIndex:row];
        
    }else{//区
        self.areaInfo = [self.areaItems objectAtIndex:row];
    }
}


#pragma mark - Networking
- (void)fetchWithType:(DistrictType)type
{
    GetDistrictRequest *request = [GetDistrictRequest request];
    switch (type) {
        case DistrictType_Province: request.did = @"0";                     break;
        case DistrictType_City:     request.did = self.provinceInfo.did;    break;
        case DistrictType_Area:     request.did = self.cityInfo.did;        break;
    }
    @weakify(self);
    [ESService getDistrictRequest:request success:^(NSArray *response) {
        @strongify(self);
        
        switch (type) {
            case DistrictType_Province:
            {
                self.provinceItems = response;
                if (self.provinceItems.count > 0) {
                    self.provinceInfo = self.provinceItems.firstObject;
                    [self.pickerView reloadComponent:0];
                }
                
            }
                break;
            case DistrictType_City:
            {
                self.cityItems = response;
                if (self.cityItems.count > 0) {
                    self.cityInfo = self.cityItems.firstObject;
                    [self.pickerView reloadComponent:1];
                }
            }
                break;
            case DistrictType_Area:
            {
                self.areaItems = response;
                if (self.areaItems.count > 0) {
                    self.areaInfo = self.areaItems.firstObject;
                    [self.pickerView reloadComponent:2];
                }
                
            }
                break;
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

@end
