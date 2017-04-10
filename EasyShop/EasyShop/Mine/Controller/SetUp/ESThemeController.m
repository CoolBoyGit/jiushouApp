

//
//  ESThemeController.m
//  EasyShop
//
//  Created by 就手国际 on 17/3/9.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import "ESThemeController.h"
#import "ESThemeViewCell.h"
@interface ESThemeController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView*tableView;
@property (nonatomic,strong)NSArray*array;
@property (nonatomic,copy) NSString*str;
@end

@implementation ESThemeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.navigationItem.title=@"切换主题颜色";
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.bottom.left.right.equalTo(@0);
    }];
    
}
-(NSArray *)array{
    if (_array==nil) {
        _array=@[@{@"color":@"0xFFFFFF",@"text":@"白色"},@{@"color":@"0xfa0000",@"text":@"红色"},@{@"color":@"0xA67D3D",@"text":@"棕色"},@{@"color":@"0xFF2400",@"text":@"橙红色"},@{@"color":@"0x9370DB",@"text":@"中兰花色"},@{@"color":@"0x8E2323",@"text":@"火砖色"},@{@"color":@"0x5C4033",@"text":@"深棕色"},@{@"color":@"0xBC1717",@"text":@"猩红色"},];
    }
    return _array;
}
-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        [_tableView registerClass:[ESThemeViewCell class] forCellReuseIdentifier:@"ESThemeViewCell"];
        
    }
    return _tableView;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
//        case 0:
//            self.dk_manager.themeVersion = DKThemeVersionNight;
//            break;
        case 0:
            self.dk_manager.themeVersion = DKThemeVersionNormal;
            break;
        case 1:
            self.dk_manager.themeVersion = @"RED";
            break;
        case 2:
            self.dk_manager.themeVersion = @"BROWN";
            break;
        case 3:
            self.dk_manager.themeVersion = @"BLUSH";
            break;
        case 4:
            self.dk_manager.themeVersion = @"ORCHID";
            break;
        case 5:
            self.dk_manager.themeVersion = @"FIREBRICK";
            break;
        case 6:
            self.dk_manager.themeVersion = @"DEEPBROWN";
            break;
        case 7:
            self.dk_manager.themeVersion = @"OTHERRED";
            break;
        default:
            break;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ESThemeViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESThemeViewCell"];
    NSDictionary*dic=self.array[indexPath.row];
    NSString* i=dic[@"color"];
//    cell.color=[self colorWithHexString:i alpha:1];
    cell.color=[i colorWithHexlpha:1];
    cell.labelText=dic[@"text"];
    return cell;
}
@end
