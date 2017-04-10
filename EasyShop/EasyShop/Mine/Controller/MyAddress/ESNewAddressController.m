//
//  ESNewAddressController.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/11.
//  Copyright © 2016年 wcz. All rights reserved.
//
///此页面用来做为新增收获地址或者是修改收货地址
#import "ESNewAddressController.h"
#import "NewAddressCell.h"
#import "ESIndicator.h"
#import "ESDistrictPickerView.h"
#import "ESNewAddressFooterView.h"
#import "JKAssets.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+Extend.h"
#import "JKAssets.h"
#import <ImageIO/ImageIO.h>
#import "DZPhotoBrowser.h"
#import "NSString+Extension.h"
@interface ESNewAddressController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

/** 输入item */
@property (nonatomic,strong) NSArray *infoItems;

@property (nonatomic,strong) DistrictInfo *provinceInfo;
@property (nonatomic,strong) DistrictInfo *cityInfo;
@property (nonatomic,strong) DistrictInfo *areaInfo;
@property (nonatomic,copy) NSString*tipStr;
/** indicator */
@property (nonatomic,strong) ESIndicator *indicator;
@property (nonatomic,assign) CGFloat h;
@property (nonatomic,strong) ESDistrictPickerView *pickerView;

@property (nonatomic,strong) ESNewAddressFooterView*footerView;


@property (nonatomic,strong)PersonImageModel*frontUploadModel;
@property (nonatomic,strong)PersonImageModel*backUploadModel;

@property (copy,nonatomic)NSString*froontImageStr;
@property (copy,nonatomic)NSString*backImageStr;

@property (nonatomic,copy) NSMutableArray*imageItems;
@end


@implementation ESNewAddressController
-(NSMutableArray *)imageItems{
    if (_imageItems==nil) {
        _imageItems=[[NSMutableArray alloc]init];
    }
    return _imageItems;
}
-(NSString *)tipStr{
    if (_tipStr==nil) {
        _tipStr=@"海关需要对海外购物检查身份，请填写正确的身份证信息，身份证信息会加密报关，就手国际确保你的信息安全，请放心购买!";
    }
    return _tipStr;
}
- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}

- (NSArray *)infoItems
{
    if (!_infoItems) {
        NSMutableArray *mArr = [NSMutableArray array];
        [mArr addObject:[NewAddressItem itemWithPlaceholder:@"收货人" andText:self.info.name]];
        [mArr addObject:[NewAddressItem itemWithPlaceholder:@"手机号" andText:self.info.mobile]];
        [mArr addObject:[NewAddressItem itemWithPlaceholder:@"身份证" andText:self.info.personid]];
        [mArr addObject:[NewAddressItem itemWithPlaceholder:@"123" andText:@"23567"]];
        NewAddressItem *areaItem =  [NewAddressItem itemWithPlaceholder:@"省市区" andText:self.info.area];
        @weakify(self);
        areaItem.tapBlock  = ^{//处理省市区
            @strongify(self);
            [self hanldeArea];
        };
        [mArr addObject:areaItem];
        
        [mArr addObject:[NewAddressItem itemWithPlaceholder:@"详细地址" andText:self.info.address]];
        
        _infoItems = [mArr copy];
    }
    return _infoItems;
}

- (void)hanldeArea
{
    [self.view endEditing:YES];
    
    self.pickerView = [[ESDistrictPickerView alloc] init];
    [self.pickerView showPickerView];
    @weakify(self);
    self.pickerView.sureBlock             = ^(DistrictInfo *province,DistrictInfo *city,DistrictInfo *area){
        @strongify(self);
        self.provinceInfo   = province;
        self.cityInfo       = city;
        self.areaInfo       = area;
        NewAddressItem *areaItem = [self.infoItems objectAtIndex:4];
        areaItem.text       = [NSString stringWithFormat:@"%@ %@ %@",province.name,city.name,area.name];
        
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
}

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"收货地址管理";
    
    [self.view addSubview:self.tableView];
    self.tableView.scrollEnabled=YES;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@64);
        make.bottom.equalTo(@0);
    }];
    NSString*str=@"温馨提示: 请上传原始比例的身份证正反面照片,请不要裁剪修改,保证身份信息显示清晰,否则无法通过海关审刻,以免给您带来不便";
    NSTextAttachment*ach=[[NSTextAttachment alloc]init];
    ach.image=[UIImage imageNamed:@"mine_address_plaint"];
    ach.bounds=CGRectMake(0, 5, 15, 15);
    
    NSAttributedString*aStr=[NSAttributedString attributedStringWithAttachment:ach];
    NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc]initWithString:str];
    [muStr insertAttributedString:aStr atIndex:0];
  //CGRect  rect=  [muStr boundingRectWithSize:CGSizeMake(ScreenWidth-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
  NSString*tstr=  @".根据海关规定,购买跨境商品需要办理清关手续,请您配合进行实名认证,以确保您购买的商品顺利通过海关检查.(就手国际承诺您所上传的身份正品只用于办理跨境商品的清关手续,不作其他使用,其他人无法查看)\n.实名认证的规则:购买跨境商品需要填写收货人的真实姓名以及身份证号码,部分商品需要提供收货人的实名信息(包括身份证照片),具体以下单时候的提示为准";
    CGFloat h=[tstr heightOfFont:[UIFont systemFontOfSize:15] andWidth:(ScreenWidth-20)];
    self.footerView=[[ESNewAddressFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, (200+((ScreenWidth-40)/2.0*(212/335.0)))+h+138)];
    self.tableView.tableFooterView=self.footerView;
    @weakify(self);
//    self.footerView.backBlock=^(PersonImageModel*model){
//        @strongify(self);
//        self.footerView.backModel=model;
//        
//        [self.tableView reloadData];
//    };
    self.footerView.frontBlock=^(PersonImageModel*model){
        @strongify(self);
        if (model.flag==1) {
            self.footerView.frontModel=model;
            self.frontUploadModel=[[PersonImageModel alloc]init];
            self.frontUploadModel=model;
            [self uploadGoodsImages:model];
            
        }else{
            self.backUploadModel=[[PersonImageModel alloc]init];
            self.backUploadModel=model;
            self.footerView.backModel=model;
            [self uploadGoodsImages:model];
        }
        
        
        [self.tableView reloadData];
        
    };
    
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 40, 25);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:AllTextColor forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:15];
    
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItemButton=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=rightItemButton;
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.pickerView hidePickerView];
}
-(void)btnClick
{
  //  [self.tableView reloadData];
    
    [self addAddress];
}

#pragma mark
#pragma mark - tableview代理方法;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoItems.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==3) {
        
        /*自动计算Label的高度*/
        CGRect rect=[self.tipStr boundingRectWithSize:CGSizeMake(ScreenWidth-50, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        self.h=rect.size.height;
        return rect.size.height+6;
    }else{
        return 40;
    };
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
        
        UITableViewCell*cell=[[UITableViewCell alloc]init];
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, self.h+6)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        view.backgroundColor=RGBA(233, 40, 46, 0.3);
        view.layer.cornerRadius=5;
        view.layer.masksToBounds=YES;
        UILabel*label=[[UILabel alloc]init];
        label.font=[UIFont fontWithName:@"Arial-BoldMT" size:15];
        label.textColor=RGBA(233, 40, 46, 0.6);
        label.numberOfLines=0;
        label.text=self.tipStr;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@3);
            make.left.equalTo(@10);
            make.right.equalTo(@(-5));
        }];
        [cell.contentView addSubview:view];
        // cell.detailTextLabel.text=@"1234";
        return cell;
    }else{
        
        NewAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdNewAddressCell forIndexPath:indexPath];
        cell.info=self.info;
        cell.item       = [self.infoItems objectAtIndex:indexPath.row];
        if (self.isChangeAddress) {
            cell.isChangAddress=YES;
        }else{
            cell.row=indexPath.row;
            cell.isChangAddress=NO;
        }
            return cell;
    }
    return nil;
}

#pragma mark
#pragma mark lazy init
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.backgroundColor=RGBA(247, 247, 247, 1);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[NewAddressCell class] forCellReuseIdentifier:kIdNewAddressCell];
    }
    return _tableView;
}
//第一次上传的是正面  第二次是反面
- (void)uploadGoodsImages:(PersonImageModel *)model
{
    
    FileUploadRequest *request = [FileUploadRequest request];
        DZLog(@"上传商品%d图片....",model.flag);
    
   NSMutableArray*image= [[NSMutableArray alloc]init];
    [image addObject:model.image];
    request.imageItems=image;
    @weakify(self);
    [self.indicator startAnimation];
    [ESService fileUploadRequest:request success:^(NSArray *response) {
        [self endGSNetworking];
        if (model.flag==1) {
            self.froontImageStr=[response objectAtIndex:0];
        }else if(model.flag==2){
            self.backImageStr=[response objectAtIndex:0];
        }
        
        
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}

#pragma mark 判断输入框的内容是否符合格式
/**判断是不是手机号码**/
-(BOOL)isMobileNumberClassification:(NSString*)mobile{
    NSString * MOBIL = @"^\\d{11}$";//11位数字正则
    NSPredicate *regextestmobil = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    return [regextestmobil evaluateWithObject:mobile];
}
#pragma mark - Networking
- (void)addAddress
{
    //添加一些逻辑判断
    if (((NewAddressItem *)self.infoItems[0]).text.length == 0) {
        TipViewAnimation*view=[[TipViewAnimation alloc]initWithFrame:CGRectMake(0, 0, 0, 0) andTip:@"请填写收货人"];
        [view show];
        return;
    }
    else{
        
    }
    
    
    if ([self isMobileNumberClassification:((NewAddressItem *)self.infoItems[1]).text]) {
        
    }else{
        CGFloat width= [@"请输入正确的手机号码" widthOfFont:[UIFont systemFontOfSize:15]];
        TipViewAnimation*view=[[TipViewAnimation alloc]initWithFrame:CGRectMake((ScreenWidth-width-20)/2.0, kKeyWindow.centerY-20, width+20, 40) andTip:@"请输入正确的手机号码"];
        [view show];
        return;
    }
    if ([((NewAddressItem *)self.infoItems[2]).text isEqualToString:@""]) {
        
        //return;
    }
    if(((NewAddressItem *)self.infoItems[2]).text.length==18){
        
    }else{
        
        TipViewAnimation*view=[[TipViewAnimation alloc]initWithFrame:self.view.bounds andTip:@"请输入正确的身份证"];
        [view show];
        return;
    }
    
    
    if (((NewAddressItem *)self.infoItems[4]).text.length == 0) {
        
        TipViewAnimation*view=[[TipViewAnimation alloc]initWithFrame:self.view.bounds andTip:@"请选择省市区"];
        [view show];
        return;
    }
    if (((NewAddressItem *)self.infoItems[5]).text.length == 0) {
        
        TipViewAnimation*view=[[TipViewAnimation alloc]initWithFrame:self.view.bounds andTip:@"请输入您的具体地址信息"];
        [view show];
        return;
    }
    
    if (self.isChangeAddress==YES) {
        EditAddressRequest *request = [EditAddressRequest request];
        request.aid =self.info.aid;
        request.name        = ((NewAddressItem *)self.infoItems[0]).text;
        request.mobile      = ((NewAddressItem *)self.infoItems[1]).text;
        request.personid    = ((NewAddressItem *)self.infoItems[2]).text;
        request.address     = ((NewAddressItem *)self.infoItems[5]).text;
        request.provinceid  = self.provinceInfo.did;
        request.cityid      = self.cityInfo.did;
        request.areaid      = self.areaInfo.did;
        [self.indicator startAnimationWithMessage:@"正在修改..."];
        @weakify(self);
        [ESService editAddressRequest:request success:^(AddressInfo *respone) {
            @strongify(self);
            [self endGSNetworking];
            
            [ESToast showSuccess:@"修改成功！"];
            
            if (self.addressBlock ) {
                self.addressBlock(respone);
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error) {
            [self endGSNetworking];
        }];
        
    }else{
        AddAddressRequest *request = [AddAddressRequest request];
        request.name        = ((NewAddressItem *)self.infoItems[0]).text;
        request.mobile      = ((NewAddressItem *)self.infoItems[1]).text;
        request.personid    = ((NewAddressItem *)self.infoItems[2]).text;
        request.address     = ((NewAddressItem *)self.infoItems[5]).text;
        request.provinceid  = self.provinceInfo.did;
        request.cityid      = self.cityInfo.did;
        request.areaid      = self.areaInfo.did;
        request.personid_front=self.froontImageStr;
        request.personid_back=self.backImageStr;
        [self.indicator startAnimationWithMessage:@"正在添加..."];
        @weakify(self);
        [ESService addAddressRequest:request success:^(StatusResponse *respone) {
            @strongify(self);
            [self endGSNetworking];
            NSString*str=[NSString stringWithFormat:@"%@",respone.data];
            if ([str isEqualToString:@"-10"]) {
                UIAlertController*con=[UIAlertController alertControllerWithTitle:@"超过10个有效地址" message:@"请删除不需要地址" preferredStyle:UIAlertControllerStyleAlert];
                [con addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }]];
                [self presentViewController:con animated:YES completion:^{
                    
                }];
            }else{
                if (self.successBlock) {
                    self.successBlock();
                }
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.indicator stopAnimation];
}


@end
