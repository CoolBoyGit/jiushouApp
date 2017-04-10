//
//  ESShareCategoryController.m
//  EasyShop
//
//  Created by wcz on 16/5/26.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShareCategoryController.h"
#import "ESBannerScrollview.h"
#import "ESShareListCell.h"
#import "ESShareFunctionCell.h"
#import "NJShareView.h"
#import "ESForumPageController.h"
#import "ESImagePickerController.h"
#import "CreateCommentViewController.h"
#import "ESShareHeaderView.h"

@interface ESShareCategoryController()<UITableViewDelegate,UITableViewDataSource,ESShareListCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

/** 分享items （item : ShareFeedInfo ） */
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic,strong) NSMutableArray *feedItems;
/** page */
@property (nonatomic,assign) NSInteger page;

@end

@implementation ESShareCategoryController

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESShareListCell  class] forCellReuseIdentifier:@"ESShareListCell"];
    }
    return _tableView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"分享";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
}

#pragma mark
#pragma mark - tableview代理方法;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 360;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESShareListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESShareListCell"];
    cell.delegate = self;
    cell.feedInfo  = [self.feedItems objectAtIndex:indexPath.row];
    return cell;
}

@end
