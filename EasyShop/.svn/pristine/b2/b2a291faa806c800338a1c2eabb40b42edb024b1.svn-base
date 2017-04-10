//
//  SHDropDown.m
//  ScanHouse
//
//  Created by guojian on 16/3/2.
//  Copyright © 2016年 Boole. All rights reserved.
//

#import "SHDropDown.h"

@interface SHDropDown()<UITableViewDataSource,UITableViewDelegate>

/** point */
@property (nonatomic,assign) CGPoint point;
/** 宽度 */
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,copy) void (^selectedBlock)(NSInteger selectedIndex);
/** items数组 (item: string ) */
@property (nonatomic,strong) NSArray *items;


/** table */
@property (nonatomic,weak) UITableView *tableView;

@end

#define kCodeCell @"kCodeCell"

@implementation SHDropDown

+ (void)dropdownWithItems:(NSArray *)items
                  atPoint:(CGPoint)point
                    width:(CGFloat)width
            selectedBlock:(void (^)(NSInteger))selectedBlock
{
    
    SHDropDown *dropdown = [[self alloc] init];
    dropdown.width = width;
    dropdown.point = point;
    dropdown.items = items;
    dropdown.selectedBlock = selectedBlock;
    
    [dropdown show];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.frame = window.bounds;
//        self.backgroundColor = RGBAColor(0, 0, 0, 0.3);
        self.hidden = YES;
        [window addSubview:self];
        
        UIControl *control = [[UIControl alloc] initWithFrame:self.bounds];
        [control addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
        
        UITableView *tableView = [[UITableView alloc] init];
        tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        tableView.layer.borderWidth = 1;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCodeCell];
        tableView.delegate = self;
        tableView.dataSource = self;
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
        self.tableView = tableView;
        
    }
    return self;
}

- (void)show
{
    self.hidden = NO;
    
    
    //计算高度 50 + count*CellH
    CGFloat tableW = self.width;
    CGFloat left = self.point.x;//(kScreenWidth - tableW)/2;
    CGFloat tableH = self.items.count * 30;
    CGFloat top = self.point.y;//(kScreenHeight - tableH)/2;
    CGFloat tableMaxH = ScreenHeight - top - 30; //kScreenHeight - 2*50;
    if (tableH>tableMaxH) {//大于最大高度
        tableH = tableMaxH;
    }
    
    self.tableView.frame = CGRectMake(left, top, tableW, tableH);
    [self.tableView reloadData];
    
}

- (void)hide
{
    self.hidden = YES;
    [self removeFromSuperview];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCodeCell forIndexPath:indexPath];
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedBlock(indexPath.row);
    
    [self hide];
}

@end
