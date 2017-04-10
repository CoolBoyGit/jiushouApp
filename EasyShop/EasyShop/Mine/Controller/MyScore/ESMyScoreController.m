//
//  ESMyScoreController.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/21.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESMyScoreController.h"
#import "ESMyScoreListCell.h"
#import "ESScoreHeaderView.h"

@interface ESMyScoreController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ESScoreHeaderView *scoreHeaderView;

@end

@implementation ESMyScoreController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   self.navigationItem.title = @"我的积分";
//    [self initalizedCumstomNav];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.scoreHeaderView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@-44);
    }];
}

#pragma mark
#pragma mark - tableview代理方法;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //            NormalWebViewController *vc = [[NormalWebViewController alloc] init];
    //            vc.hidesBottomBarWhenPushed = YES;
    //            [self.navigationController pushViewController:vc animated:NO];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESMyScoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESMyScoreListCell"];
    return cell;
}

#pragma mark
#pragma mark lazy init
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESMyScoreListCell class] forCellReuseIdentifier:@"ESMyScoreListCell"];
    }
    return _tableView;
}
-(ESScoreHeaderView *)scoreHeaderView
{
    if (_scoreHeaderView == nil) {
        _scoreHeaderView = [[ESScoreHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250)];
    }
    return _scoreHeaderView;
}

@end
