//
//  ESHomePopView.m
//  EasyShop
//
//  Created by guojian on 16/7/6.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESHomePopView.h"

static NSString *const kESHomePopCellID = @"kESHomePopCellID";
static const CGFloat   kESHomePopHeight = 40;

@interface ESHomePopView()<UITableViewDelegate,UITableViewDataSource>

/** table */
@property (nonatomic,weak) UITableView *tableView;
/** Control */
@property (nonatomic,weak) UIControl *control;
/** 数据 */
@property (nonatomic,strong) NSArray *popItems;

@property (nonatomic, strong)UIView *circleView;


@end

@implementation ESHomePopView

- (UIView *)circleView
{
    if (_circleView == nil) {
        _circleView = [[UIView alloc] init];
        _circleView.layer.cornerRadius = 5;
        _circleView.backgroundColor = [UIColor redColor];
        _circleView.layer.masksToBounds = YES;
    }
    return _circleView;
}

- (NSArray *)popItems
{
    return @[@"我的订单",@"现金券",@"消息"];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.frame              = kKeyWindow.bounds;
        self.backgroundColor    = [UIColor clearColor];
        self.hidden             = YES;
        
        UIControl *control = [[UIControl alloc] initWithFrame:self.bounds];
        [control addTarget:self action:@selector(hidePopView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kESHomePopCellID];
        tableView.layer.borderColor=RGB(205, 205, 205).CGColor;
        tableView.layer.borderWidth=0.5;
        tableView.layer.cornerRadius=8;
        tableView.layer.masksToBounds=YES;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = [[UIView alloc]init];
        tableView.frame = CGRectMake(15, 64, 100, self.popItems.count * kESHomePopHeight);
        [self addSubview:tableView];
        self.tableView = tableView;
    }
    return self;
}

- (void)showPopView
{
    self.hidden = NO;
    [kKeyWindow addSubview:self];
}

- (void)hidePopView
{
    self.hidden = YES;
    [self removeFromSuperview];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.popItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kESHomePopCellID forIndexPath:indexPath];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    view.backgroundColor=RGB(205, 205, 205);
    if (indexPath.row!=0) {
        [cell addSubview:view];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.contentView. backgroundColor = RGB(253, 253, 253);
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15.5];
    cell.textLabel.text = [self.popItems objectAtIndex:indexPath.row];
    if (self.isShow && indexPath.row == 2) {
        [cell addSubview:self.circleView];
        [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-5));
            make.centerY.equalTo(@0);
            make.width.height.equalTo(@10);
        }];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kESHomePopHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.selectedBlock) {
        self.selectedBlock(indexPath.row);
    }
    [self hidePopView];
}


@end
