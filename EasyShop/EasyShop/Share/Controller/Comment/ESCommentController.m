//
//  ESCommentController.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/4/29.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESCommentController.h"
#import "ESBannerScrollview.h"
#import "ESCommentInfoCell.h"
#import "ESComShopListCell.h"
#import "ESComFunctionCell.h"
#import "ESComUserInfoCell.h"
#import "ESComPraiseCell.h"
#import "ESCommentListCell.h"
#import "ESComBottonView.h"

@interface ESCommentController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ESComBottonView *comBottonView;

@end

@implementation ESCommentController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"牛爷爷";
    self.tableView.tableHeaderView = [[ESBannerScrollview alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@(-30));
    }];
    
//    [self initalizedCumstomNav];

    [self.view addSubview:self.comBottonView];
    [self.comBottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@30);
    }];
}

#pragma mark
#pragma mark - tableview代理方法;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 8;
    }
    if (section == 2) {
        return 3;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 110;
        }
        else if (indexPath.row == 7) {
            return 44;
        }
        return 60;
    }
    if (indexPath.section == 1) {
        return 80;
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        return 60;
    }
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 5;
    }
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //    ESHomeShopDetailController *shopDetailVc = [[ESHomeShopDetailController alloc] init];
    //    shopDetailVc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:shopDetailVc animated:NO];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ESCommentInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESCommentInfoCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else if (indexPath.row == 7) {
            ESComFunctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESComFunctionCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        ESComShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESComShopListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else  if (indexPath.section == 1) {
        ESComUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESComUserInfoCell"];
        return cell;
    } else {
        if (indexPath.row == 0) {
            ESComPraiseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESComPraiseCell"];
            return cell;
        }
        ESCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESCommentListCell"];
        return cell;
    }
}


#pragma mark
#pragma mark - lazy init
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESCommentInfoCell  class] forCellReuseIdentifier:@"ESCommentInfoCell"];
        [_tableView registerClass:[ESComShopListCell class] forCellReuseIdentifier:@"ESComShopListCell"];
        [_tableView registerClass:[ESCommentListCell class] forCellReuseIdentifier:@"ESCommentListCell"];
        [_tableView registerClass:[ESComFunctionCell class] forCellReuseIdentifier:@"ESComFunctionCell"];
        [_tableView registerClass:[ESComUserInfoCell class] forCellReuseIdentifier:@"ESComUserInfoCell"];
        [_tableView registerClass:[ESComPraiseCell class] forCellReuseIdentifier:@"ESComPraiseCell"];
    }
    return _tableView;
}
-(ESComBottonView *)comBottonView
{
    if (!_comBottonView) {
        _comBottonView = [[ESComBottonView alloc] initWithFrame:CGRectMake(0, ScreenHeight -30, ScreenWidth, 30)];
    }
    return _comBottonView;
}

@end
