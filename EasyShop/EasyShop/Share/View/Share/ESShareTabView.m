//
//  ESShareTabView.m
//  EasyShop
//
//  Created by wcz on 16/6/8.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShareTabView.h"
#import "ESShareListCell.h"

@interface ESShareTabView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ESShareTabView

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESShareListCell  class] forCellReuseIdentifier:@"ESShareListCell"];
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 360;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        ESShareListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESShareListCell"];
//        cell.delegate = self;
//        cell.feedInfo  = [self.feedItems objectAtIndex:indexPath.row];
    return cell;
}


@end
