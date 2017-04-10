


//
//  UIHomeSelectView.m
//  EasyShop
//
//  Created by wcz on 16/6/12.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "UIHomeSelectView.h"
#import "ESMyOrderPageController.h"

@interface UIHomeSelectView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray*dataArray;

@end

@implementation UIHomeSelectView

- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = @[@"我的订单",@"现金券",@"消息"];
    }
    return _dataArray;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    cell.backgroundColor = [UIColor redColor];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    self.hidden = YES;
    
    switch (indexPath.row) {
        case 0://我的订单
        {
            ESLoginVerify
            
            ESMyOrderPageController *controller = [[ESMyOrderPageController alloc]init];
            [[AppDelegate shared] pushViewController:controller animated:NO];
        }
            break;
        case 1://现金券
            break;
        case 2://消息
            break;
    }
    
    
}

@end
