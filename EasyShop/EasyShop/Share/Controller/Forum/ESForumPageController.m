//
//  ESForumPageController.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/3.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESForumPageController.h"
#import "ESForumTopView.h"
#import "ESForumPushCell.h"
#import "ESBannerScrollview.h"
#import "ESForumListCell.h"
#import "ESCommentController.h"

@interface ESForumPageController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ESForumPageController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableHeaderView = [[ESBannerScrollview alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 200)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@0);
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
    if (section == 0) {
        return 1;
    }
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 170;
    }
    return 170;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 20;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headView = [[UIView alloc] init];
        headView.backgroundColor = ADeanHEXCOLOR(0xf8f8f8);
        UILabel *typeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 18)];
        typeLab.textAlignment = NSTextAlignmentCenter;
        typeLab.text = @"热门评论";
        typeLab.font = [UIFont systemFontOfSize:13];
        typeLab.textColor = ADeanHEXCOLOR(0x279ace);
        [headView addSubview:typeLab];
        UIView *typeView = [[UIView alloc] initWithFrame:CGRectMake(10, 19, 70, 1)];
        typeView.backgroundColor = ADeanHEXCOLOR(0x5eb6df);
        [headView addSubview:typeView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(ScreenWidth-80, 0, 70, 18);
        [button setTitle:@"热门评论" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:ADeanHEXCOLOR(0xb1b1b1) forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:button];
        
        UIView *midLine = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth-81, 0, 1, 20)];
        midLine.backgroundColor = ADeanHEXCOLOR(0xcccccc);
        [headView addSubview:midLine];
        return headView;
    }
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ESCommentController *vc = [[ESCommentController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ESForumPushCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESForumPushCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        ESForumListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESForumListCell"];
        return cell;
    }
}


#pragma
#pragma mark - lazy init
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESForumPushCell  class] forCellReuseIdentifier:@"ESForumPushCell"];
        [_tableView registerClass:[ESForumListCell class] forCellReuseIdentifier:@"ESForumListCell"];
    }
    return _tableView;
}


@end
