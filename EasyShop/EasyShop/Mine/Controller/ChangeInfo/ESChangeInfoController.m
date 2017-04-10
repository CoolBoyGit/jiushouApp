//
//  ESChangeInfoController.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/11.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESChangeInfoController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ESScoreHeaderView.h"
#import "ESChangeInfoCell.h"
#import "ZHPickView.h"
#import "GSTimeTool.h"
#import <UIActionSheet+BlocksKit.h>
#import "ESMyFootController.h"
#import "ESForgetPasswordController.h"
#import "ESChangeNikeNameController.h"
#import "ESSignatureController.h"
#import "ESAddressListController.h"

@interface ESChangeInfoController()<UITableViewDataSource,UITableViewDelegate,ZHPickViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ESScoreHeaderView *scoreHeaderView;
@property(nonatomic, strong) ZHPickView *pickview;
@property(nonatomic, strong) ZHPickView *sexPickview;

@property(nonatomic, copy) NSString *userSex;
@property(nonatomic, copy) NSString *userSexBirth;

/** 拍照控制器 */
@property (nonatomic,strong) UIImagePickerController *imagePicker;

/** indicator */
@property (nonatomic,strong) ESIndicator *indicator;

@end

@implementation ESChangeInfoController

- (UIImagePickerController *)imagePicker
{
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.allowsEditing = YES;
    }
    return _imagePicker;
}

- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}

#pragma mark - LifeCycle
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.pickview removeFromSuperview];
    [self.sexPickview removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated{
    self.scoreHeaderView.imageStr=kUserManager.userInfo.logo;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeNikeNsme) name:kUserNikeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSinature) name:kUserSignatureNotification object:nil];
}
-(void)changeSinature{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}
-(void)changeNikeNsme{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    /*解决title不居中的问题*/
    self.navigationItem.title=@"个人中心";
    [self addNotification];
    self.navigationItem.leftBarButtonItem.customView.frame=CGRectMake(0, 0, 30, 30);
//    [self initalizedCumstomNav];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.scoreHeaderView;
    @weakify(self);
    self.scoreHeaderView.tapBlock=^(){
        @strongify(self);
        UIActionSheet *sheet = [[UIActionSheet alloc] init];
        
        [sheet bk_addButtonWithTitle:@"拍照" handler:^{
            @strongify(self);
            self.imagePicker.sourceType= UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }];
        [sheet bk_addButtonWithTitle:@"从手机相册选择" handler:^{
            @strongify(self);
            self.imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }];
        [sheet bk_setCancelButtonWithTitle:@"取消" handler:nil];
        [sheet showInView:self.view];

    };
    self.scoreHeaderView.imageStr=kUserManager.userInfo.logo;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@64);
        make.bottom.equalTo(@(-44));
    }];
}

#pragma mark
#pragma mark - tableview代理方法;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }
    
    return 3;
    
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 20;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    view.backgroundColor=[UIColor clearColor];
    return view;

}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==0) {
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        view.backgroundColor=RGB(247, 247, 247);
        return view;
    }return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section==0) {
        switch (indexPath.row) {
                
            case 0://昵称
            {
                ESChangeNikeNameController *nikeNameVc=[[ESChangeNikeNameController alloc]init];
                [self.navigationController pushViewController:nikeNameVc animated:YES];
                
            }
                break;
            case 1://签名
            {
                ESSignatureController*signatureVc=[[ESSignatureController alloc]init];
                [self.navigationController pushViewController:signatureVc animated:YES];
            }
                break;
            case 2://性别
            {
                [self.pickview removeFromSuperview];
                [_sexPickview removeFromSuperview];
                NSArray *array=@[@"女",@"男"];
                _sexPickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
                _sexPickview.delegate=self;
                //[self.view addSubview: _sexPickview];
                [_sexPickview show];
            }
                break;
            case 3://生日
            {
                [self.sexPickview removeFromSuperview];
                [_pickview removeFromSuperview];
                NSDate *date = [GSTimeTool dateFromBirthday:kUserManager.userInfo.birthday];
                _pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
                _pickview.delegate=self;
                //[self.view addSubview:_pickview];
                [_pickview show];
            }
                break;
                
                
            default:
                break;
        }
    }
    else{
        switch (indexPath.row) {
            case 0:{
                ESForgetPasswordController * password = [[ESForgetPasswordController alloc] init];
                [self.navigationController pushViewController:password animated:YES];
                
            }
                break;
             case 1:
            {
                ESAddressListController *vc = [[ESAddressListController alloc] init];
                
                [[AppDelegate shared] pushViewController:vc animated:YES];

            }
                break;
            case 2:{
                ESMyFootController *vc = [[ESMyFootController alloc]init];
                vc.flag=3;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
        
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESChangeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESChangeInfoCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        switch (indexPath.row) {
                
            case 0:
                cell.titleLab.text = @"昵称";
                cell.userInfoLab.text=kUserManager.userInfo.nickname;
                break;
            case 1:
                cell.titleLab.text = @"签名";
                cell.userInfoLab.text=kUserManager.userInfo.signature;
                break;
            case 2:
                cell.titleLab.text = @"性别";
                cell.userInfoLab.text = kUserManager.userInfo.displaySex;
                break;
            case 3://生日
                cell.titleLab.text = @"生日";
                cell.userInfoLab.text = kUserManager.userInfo.birthday;
                break;
                        default: break;
        }

    }else{
        switch (indexPath.row) {
            case 0:
                cell.titleLab.text=@"重置密码";
                break;

                break;
            case 1:
                 cell.titleLab.text=@"管理收货地址";
                break;
            case 2:
                 cell.titleLab.text=@"我的足迹";
                break;
            default:
                break;
        }
    }
        return cell;
}

#pragma mark
#pragma mark lazy init
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.delegate = self;
        _tableView.backgroundColor=[UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESChangeInfoCell class] forCellReuseIdentifier:@"ESChangeInfoCell"];
    }
    return _tableView;
}
-(ESScoreHeaderView *)scoreHeaderView
{
    if (_scoreHeaderView == nil) {
        _scoreHeaderView = [[ESScoreHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 165)];
        _scoreHeaderView.scoreRecordLab.hidden = YES;
    }
    return _scoreHeaderView;
}

#pragma mark ZhpickVIewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString
{
    if ([pickView isEqual:_sexPickview]) {//性别
        
        [self editSex:resultString];
        
    } else {
        
        NSDate*nowDate=[NSDate date];
        NSDateFormatter *dateformatter =[[NSDateFormatter alloc]init];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *dateB=[dateformatter dateFromString:[resultString  substringToIndex:18]];
        
       
        
        NSComparisonResult result =[nowDate compare:dateB];
        
        if (result==NSOrderedDescending) {
            [self editBirthday:[resultString  substringToIndex:10]];
        }else {
            UIAlertController*com=[UIAlertController alertControllerWithTitle:nil message:@"你的生日太超前了" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*cancelActio=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            [com addAction:cancelActio];
            [com addAction:okAction];
            [self presentViewController:com animated:YES completion:nil];
        }
        
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//   UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
//    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera)
//    {
//        //如果是 来自照相机的image，那么先保存
//        UIImage* original_image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//        UIImageWriteToSavedPhotosAlbum(original_image, self,
//                                       @selector(image:didFinishSavingWithError:contextInfo:),
//                                       nil);
//    }
//    
    //获得编辑过的图片
    UIImage* image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
//    NSData*data=UIImagePNGRepresentation(image);

    [self dismissViewControllerAnimated:YES completion:nil];
//    CGSize ddsize =originalImage.size;
//    //处理一下图片
//
//    CGSize size = CGSizeMake(200, 200);
//    UIGraphicsBeginImageContext(size);
//    [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    //修改头像
    [self uploadImage:image];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Networking
/*修改头像*/
- (void)editLogo:(NSString *)logo
{
    UserEditRequest *request = [UserEditRequest request];
    request.logo = logo;
    
    [self editUserInfoWithRequest:request success:^{
        kUserManager.userInfo.logo = request.logo;
        self.scoreHeaderView.imageStr=request.logo;
    }];
}
/*修改性别*/
- (void)editSex:(NSString *)sex
{
    UserEditRequest *request = [UserEditRequest request];
    request.sex = [sex isEqualToString:@"男"] ? @0 : @1;
    
    @weakify(self);
    [self editUserInfoWithRequest:request success:^{
        @strongify(self);
        
        //刷新用户性别
        kUserManager.userInfo.sex = request.sex;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
    }];
}

- (void)editBirthday:(NSString *)birthday
{
    UserEditRequest *request = [UserEditRequest request];
    request.birthday = birthday;
    
    @weakify(self);
    [self editUserInfoWithRequest:request success:^{
        @strongify(self);
        
        kUserManager.userInfo.birthday = request.birthday;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
    }];
}

#pragma mark 修改用户信息
- (void)editUserInfoWithRequest:(UserEditRequest *)request
                        success:(OkBlock)success
{
    @weakify(self);
    [self.indicator startAnimationWithMessage:@"正在修改用户资料..."];
    [ESService userEditRequest:request success:^{
        @strongify(self);
        [self endGSNetworking];
    
        [ESToast showSuccess:@"修改用户资料成功！"];
        
        success();
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}

- (void)uploadImage:(UIImage *)image
{
    FileUploadRequest *request = [FileUploadRequest request];
    request.imageItems = @[image];
    
    @weakify(self);
    [self.indicator startAnimation];
    [ESService fileUploadRequest:request success:^(NSArray *response) {
        @strongify(self);
        //上传成功
        if (response&&response.count == 1) {
            
            [self editLogo:response.firstObject];
            
        }else{
            [self endGSNetworking];
        }
        
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
