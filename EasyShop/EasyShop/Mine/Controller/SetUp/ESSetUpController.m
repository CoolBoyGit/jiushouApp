//
//  ESSetUpController.m
//  EasyShop
//
//  Created by 就手国际 on 17/3/8.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import "ESSetUpController.h"
#import "ESSetUpViewCell.h"
#import "ESThemeController.h"

#import "NormalWebViewController.h"
@interface ESSetUpController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView*tableView;

@property (nonatomic,strong) NSArray*firstArray;

@property (nonatomic,strong) NSArray*secondArray;
@property (nonatomic,copy) NSString* endSize;
@end

@implementation ESSetUpController
-(NSArray *)firstArray{
    if (_firstArray==nil) {
        _firstArray=@[@"切换主题颜色",@"清除缓存",@"关于就手"];
    }
    return _firstArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //计算检查缓存大小

      //NSString*endSize=[sizeStr substringToIndex:4];

    //self.clearCacheName = tmpSize >= 1 ? [NSString stringWithFormat:@"%.ldfM",tmpSize] : [NSString stringWithFormat:@"%.1ldK",tmpSize * 1024];
    [self.view addSubview:self.tableView];
    
    self.navigationItem.title=@"设置";
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.right.left.bottom.equalTo(@0);
    }];
}
-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        [_tableView registerClass:[ESSetUpViewCell class] forCellReuseIdentifier:@"ESSetUpViewCell"];
    }
    return _tableView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:{
            ESThemeController*vc=[[ESThemeController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            
            }
                break;
            case 1:
                [[SDImageCache sharedImageCache] clearDisk];
                [ESToast showMessage:[NSString stringWithFormat:@"清理完成%@",self.endSize]];
                [self.tableView reloadData];
                break;
            case 2:{
                NormalWebViewController *vc = [[NormalWebViewController alloc] init];
                vc.url = @"http://api.jiushouguoji.hk/app/Guider/aboutUs";
                vc.title = @"关于就手";
                vc.hidesBottomBarWhenPushed = YES;
                [[AppDelegate shared] pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }else{
        UIActionSheet *sheet = [[UIActionSheet alloc] init];
        [sheet bk_addButtonWithTitle:@"退出登录" handler:^{
            
            [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
                [kUserManager doUserLogout];
                ESLoginViewController *login = [[ESLoginViewController alloc] init];
                [[AppDelegate shared] pushViewController:login animated:YES];
                
            } onQueue:nil];
            
        }];
        [sheet bk_addButtonWithTitle:@"取消" handler:nil];
        [sheet showInView:kKeyWindow];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 15;
    }
    return 8;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    

    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    view.backgroundColor=[UIColor clearColor];
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ESSetUpViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESSetUpViewCell" ];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    if (indexPath.section==0) {
        
        
        cell.leftString=self.firstArray[indexPath.row];
        if (indexPath.row==1) {
            NSInteger tmpSize= (NSInteger)[[SDImageCache sharedImageCache]getSize];
            
            NSNumber*number=[NSNumber numberWithInteger:tmpSize];
            float f=[number floatValue];
            self.endSize=[NSString stringWithFormat:@"%.1fM",f/1024/1024];
            cell.rightString=self.endSize;
        }
         return cell;
    }
        cell.leftString=@"退出登录";
        return cell;
    
    
   
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
@end
