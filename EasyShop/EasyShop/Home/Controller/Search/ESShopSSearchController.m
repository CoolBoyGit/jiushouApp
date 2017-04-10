//
//  ESShopSearchController.m
//  EasyShop
//
//  Created by wcz on 16/6/9.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShopSSearchController.h"
#import "ESShopSearchCell.h"
#import "ESShopSearchReusableView.h"
#import "SearchTwoReusableView.h"
#import "ESSearchGoodsCell.h"
#import "ESHomeShopDetailController.h"
#import "ESSearchResultCell.h"
#import "SHDropDown.h"
#import "HomeTitleView.h"
#import "ESSearchShopListController.h"
static NSString *const kHisoryKeywordKey    = @"ESHistoryKeywordKey";//历史搜索关键字key
//#import "HomeTitleView.h"
NSString *const PYHotSearchText = @"热门搜索";
#define  PYColor RGB(113,113,113)  // 文本字体颜色
#define PYMargin 10 // 默认边距
#import "ESHomeSearchView.h"

@interface ESShopSearchController ()<ESHomeSearchViewDelegate,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITextField *searchTextField;

/** 自动关键字 （item ： Keyword ） */
@property (nonatomic,strong) NSArray *autoItems;
/** 热搜关键字 (item : KeyWord ) */
@property (nonatomic,strong) NSArray *hotItems;
/** 历史关键字 */
@property (nonatomic,copy) NSMutableArray *historyItems;

/** 页码 */
@property (nonatomic,assign) NSInteger page;
/** 搜索商品item (item: GoodsInfo ) */
@property (nonatomic,strong) NSMutableArray *goodsItems;
@property (nonatomic,strong) UITableView *  tableView;
@property (nonatomic,copy) NSString*autStr;
@property (nonatomic,assign) NSUInteger flag;

@property (nonatomic, weak)ESHomeSearchView *searchView;

/** 热门标签头部 */
@property (nonatomic, weak) UILabel *hotSearchHeader;
/** 热门标签容器 */
@property (nonatomic, weak) UIView *hotSearchTagsContentView;

/** 基本搜索TableView(显示历史搜索和搜索记录) */
@property (nonatomic, strong) UITableView *baseSearchTableView;
/** 头部内容view */
@property (nonatomic, weak) UIView *headerContentView;

@property (nonatomic,strong)UIView*sentionHeView;

@end

@implementation ESShopSearchController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.flag=0;
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    [self.navigationController.navigationItem.leftBarButtonItem setWidth:25];
    UIButton*rightBUtton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBUtton setTitle:@"取消" forState:UIControlStateNormal];
    rightBUtton.titleLabel.font=[UIFont systemFontOfSize:15];
    [rightBUtton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [rightBUtton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightBarItem=[[UIBarButtonItem alloc]initWithCustomView:rightBUtton];
    UIBarButtonItem*negativew=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativew.width=-10;
    self.navigationItem.rightBarButtonItems = @[negativew,rightBarItem];
    ESHomeSearchView *titleView = [[ESHomeSearchView alloc] initWithFrame:CGRectMake(0, 30, 300, 30)];
    titleView.isAllowToPush = NO;
    titleView.placeholder=@"在千万海外商品中搜索";
    titleView.delegate = self;
    self.searchView = titleView;
    titleView.textColor=[UIColor colorWithRed:(142.0/255) green:(142.0/255) blue:(147.0/255) alpha:1];
    ;
    titleView.placeholderColor=[UIColor colorWithRed:(142.0/255) green:(142.0/255) blue:(147.0/255) alpha:1];
    self.navigationItem.titleView = titleView;
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    [self addNotification];
    
    [self.view addSubview:self.baseSearchTableView];
    [self.baseSearchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@64);
        
    }];
    [self setUpUI];
    [self fetchHotWord];
    [self.view addSubview:self.tableView];
    self.tableView.hidden = YES;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@64);
    }];
}
-(void)setUpUI{
    // 设置头部（热门搜索）
    UIView *headerView = [[UIView alloc] init];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.py_y = PYMargin * 2;
    contentView.py_x = PYMargin * 1.5;
    contentView.py_width = ScreenWidth - contentView.py_x * 2;
    [headerView addSubview:contentView];
    UILabel *titleLabel = [self setupTitleLabel:PYHotSearchText];
    self.hotSearchHeader = titleLabel;
    [contentView addSubview:titleLabel];
    // 创建热门搜索标签容器
    UIView *hotSearchTagsContentView = [[UIView alloc] init];
    hotSearchTagsContentView.py_width = contentView.py_width;
    hotSearchTagsContentView.py_y = CGRectGetMaxY(titleLabel.frame) + PYMargin;
    [contentView addSubview:hotSearchTagsContentView];
    self.hotSearchTagsContentView = hotSearchTagsContentView;
    self.headerContentView = contentView;
    self.baseSearchTableView.tableHeaderView = headerView;
    
    UIView *footerView = [[UIView alloc] init];
    footerView.py_width = ScreenWidth;
    UILabel *emptySearchHistoryLabel = [[UILabel alloc] init];
    emptySearchHistoryLabel.textColor = [UIColor darkGrayColor];
    emptySearchHistoryLabel.font = [UIFont systemFontOfSize:13];
    emptySearchHistoryLabel.userInteractionEnabled = YES;
    emptySearchHistoryLabel.text = @"清空历史";
    emptySearchHistoryLabel.textAlignment = NSTextAlignmentCenter;
    emptySearchHistoryLabel.py_height = 30;
    [emptySearchHistoryLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptySearchHistoryDidClick)]];
    emptySearchHistoryLabel.py_width = ScreenWidth;
    [footerView addSubview:emptySearchHistoryLabel];
    footerView.py_height = 30;
    self.baseSearchTableView.tableFooterView = footerView;
    

}

- (NSMutableArray *)historyItems
{
    
   _historyItems=[NSMutableArray arrayWithArray:kUserManager.historyItems];

    return _historyItems;
}
//这个是显示搜索结果的tableview
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerClass:[ESSearchResultCell class] forCellReuseIdentifier:@"ESSearchResultCell"];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
-(UIView *)sentionHeView{
    if (_sentionHeView==nil) {
        _sentionHeView=[[UIView alloc]init];
        _sentionHeView.backgroundColor=[UIColor clearColor];
    }
    return _sentionHeView;
}
- (NSMutableArray *)goodsItems
{
    if (!_goodsItems) {
        _goodsItems = [NSMutableArray array];
    }
    return _goodsItems;
}

#pragma mark - LifeCycle
- (UITableView *)baseSearchTableView
{
    if (!_baseSearchTableView) {
        UITableView *baseSearchTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        baseSearchTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        baseSearchTableView.backgroundColor = [UIColor clearColor];
        baseSearchTableView.delegate = self;
        baseSearchTableView.dataSource = self;
        _baseSearchTableView = baseSearchTableView;
    }
    return _baseSearchTableView;
}

/** 创建并设置标题 */
- (UILabel *)setupTitleLabel:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.tag = 1;
    titleLabel.textColor = PYColor;
    [titleLabel sizeToFit];
    titleLabel.py_x = 0;
    titleLabel.py_y = 0;
    return titleLabel;
}
/** 添加标签 */
- (UILabel *)labelWithTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    label.userInteractionEnabled = YES;
    label.font = [UIFont systemFontOfSize:12];
    label.text = title;
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [@"#fafafa" colorWithHexlpha:1];
    label.layer.cornerRadius = 3;
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.py_width += 20;
    label.py_height += 14;
    return label;
}
- (void)tagDidCLick:(UITapGestureRecognizer *)gr{
    UILabel *label = (UILabel *)gr.view;
    [kUserManager addHistoryKeyword:label.text];
    [self.baseSearchTableView reloadData];
    ESSearchShopListController*searchShopListVC=[[ESSearchShopListController alloc]init];
    [self.navigationController pushViewController:searchShopListVC animated:YES];
    searchShopListVC.keyWordStr=label.text;
}
-(void)emptySearchHistoryDidClick{
    [kUserManager clearHistoryKeyword];
    [self.baseSearchTableView reloadData];
}
- (NSArray *)addAndLayoutTagsWithTagsContentView:(UIView *)contentView tagTexts:(NSArray<KeyWord *> *)tagTexts;
{
    // 清空标签容器的子控件
    [contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 添加热门搜索标签
    NSMutableArray *tagsM = [NSMutableArray array];
    for (int i = 0; i < tagTexts.count; i++) {
        //  UILabel *label = [self labelWithTitle:tagTexts[i]];
        KeyWord*item=tagTexts[i];
        UILabel*label=[self labelWithTitle:item.keyword];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        [contentView addSubview:label];
        [tagsM addObject:label];
    }
    
    // 计算位置
    CGFloat currentX = 0;
    CGFloat currentY = 0;
    CGFloat countRow = 0;
    CGFloat countCol = 0;
    
    // 调整布局
    for (int i = 0; i < contentView.subviews.count; i++) {
        UILabel *subView = contentView.subviews[i];
        // 当搜索字数过多，宽度为contentView的宽度
        if (subView.py_width > contentView.py_width)
            subView.py_width = contentView.py_width;
        if (currentX + subView.py_width + PYMargin * countRow > contentView.py_width) { // 得换行
            subView.py_x = 0;
            subView.py_y = (currentY += subView.py_height) + PYMargin * ++countCol;
            currentX = subView.py_width;
            countRow = 1;
        } else { // 不换行
            subView.py_x = (currentX += subView.py_width) - subView.py_width + PYMargin * countRow;
            subView.py_y = currentY + PYMargin * countCol;
            countRow ++;
        }
    }
    // 设置contentView高度
    contentView.py_height = CGRectGetMaxY(contentView.subviews.lastObject.frame);
    // 设置头部高度
    self.baseSearchTableView.tableHeaderView.py_height = self.headerContentView.py_height = CGRectGetMaxY(contentView.frame) + PYMargin * 2+20;
    // 取消隐藏
    self.baseSearchTableView.tableHeaderView.hidden = NO;
    // 重新赋值, 注意：当操作系统为iOS 9.x系列的tableHeaderView高度设置失效，需要重新设置tableHeaderView
    [self.baseSearchTableView setTableHeaderView:self.baseSearchTableView.tableHeaderView];
    return tagsM;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tableView) {
        return [self.autoItems count];
    }
    self.baseSearchTableView.tableFooterView.hidden=self.historyItems.count==0;
    return self.historyItems.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableView) {
        ESSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESSearchResultCell"];
        cell.key=[self.autoItems objectAtIndex:indexPath.row];
        return cell;
    }
    static NSString *cellID = @"PYSearchHistoryCellID";
    // 创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.textColor = PYColor;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.backgroundColor = [UIColor clearColor];
        // 添加关闭按钮
        UIButton *closetButton = [[UIButton alloc] init];
        // 设置图片容器大小、图片原图居中
        closetButton.py_size = CGSizeMake(cell.py_height, cell.py_height);
        [closetButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        //UIImageView *closeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PYSearch.bundle/close"]];
        [closetButton addTarget:self action:@selector(closeDidClick:) forControlEvents:UIControlEventTouchUpInside];
        //closeView.contentMode = UIViewContentModeCenter;
        cell.accessoryView = closetButton;
        // 添加分割线
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-content-line"]];
        line.py_height = 0.5;
        line.alpha = 0.7;
        line.py_x = PYMargin;
        line.py_y = 42.5;
        line.py_width = ScreenWidth;
        [cell.contentView addSubview:line];
        
    }
    // 设置数据
    cell.imageView.image = [UIImage imageNamed:@"search_history"];
    //KeyWord*key=[self.autoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = self.historyItems[indexPath.row];
    return cell;
}

-(void)closeDidClick:(UIButton*)btn{
    
    UITableViewCell*cell=(UITableViewCell*)btn.superview;
    NSString*keyWord=cell.textLabel.text;
    [kUserManager delectHistoryKey:keyWord];
    [self.baseSearchTableView reloadData];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==self.baseSearchTableView) {
        [self.searchView endEditing:YES];
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView==self.baseSearchTableView) {
        if (self.historyItems.count>0) {
            UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth, 30)];
            lab.textColor=PYColor;
            lab.font=[UIFont systemFontOfSize:13];
            lab.text=@"搜索历史";
            self.sentionHeView.frame=CGRectMake(0, 0, ScreenWidth, 30);
            [self.sentionHeView addSubview:lab];
            return self.sentionHeView;
            
        }return nil;
    }return nil;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==self.baseSearchTableView) {
        if (self.historyItems.count>0) {
            return 30;
        }
        return 0;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableView) {
        ESSearchShopListController *controller = [[ESSearchShopListController alloc] init];
        KeyWord*key=[self.autoItems objectAtIndex:indexPath.row];
        [kUserManager addHistoryKeyword:key.keyword];
        controller.keyWordStr=key.keyword;
        self.searchView.text=key.keyword;
        self.searchView.isEditing=YES;
        [self.baseSearchTableView reloadData];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        ESSearchShopListController *controller = [[ESSearchShopListController alloc] init];
        controller.keyWordStr=self.historyItems[indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}

-(void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc
{
    [self removeNotification];
}

- (void)leftBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
//点击查询
- (void)handleSearch
{
    if ([NSString isEmptyString:self.autStr]) {//keywor为
        [ESToast showError:@"请输入关键字"];
        return;
    }
    [self.searchView endEditing:YES];
    ESSearchShopListController *controller = [[ESSearchShopListController alloc] init];
    controller.keyWordStr=self.autStr;
    [self.navigationController pushViewController:controller animated:YES];
    
}


#pragma mark 编辑搜索框的协议方法
- (void)textFieldDidChange:(NSString *)keyWord
{
    if ([NSString isEmptyString:keyWord]) {//keywor为空 return
        self.autStr=keyWord;
        self.baseSearchTableView.hidden = NO;
        self.tableView.hidden = YES;
    } else
    {
        self.baseSearchTableView.hidden = YES;
        self.tableView.hidden = NO;
        self.autStr=keyWord;
        [self fetchAutoWord];
        
    }
}
#pragma mark - NSNotification

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeIn:) name:UITextFieldTextDidChangeNotification object:self.searchTextField];
}
- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textDidChangeIn:(NSNotification *)notification
{
    UITextField *textField = notification.object;
    if (textField == self.searchTextField) {
        [self fetchAutoWord];
    }
}
#pragma mark -- ESHomeSearchViewDelegate
- (void)addHistoryKeyword:(NSString *)keyword{
    [kUserManager addHistoryKeyword:keyword];
    self.tableView.hidden = NO;
}
#pragma mark - Networkinge
#pragma mark - 自动关键字
- (void)fetchAutoWord
{
    AutoWordListRequest *request = [AutoWordListRequest request];
    request.word = self.autStr;
    @weakify(self);
    [ESService autoWordListRequest:request success:^(NSArray *response) {
        @strongify(self);
        self.autoItems=[[NSArray alloc]init];
        self.autoItems = response;
        NSMutableArray *mArr = [NSMutableArray array];
        for (KeyWord *item in response) {
            [mArr addObject:item.keyword];
        }
        if (mArr.count > 0) {
            //显示下拉框
            self.tableView.hidden = NO;
            [self.tableView reloadData];
        }else{
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark 搜索关键字
- (void)fetchHotWord
{
    GetSearchHotWordRequest *request = [GetSearchHotWordRequest request];
    request.n = @20;
    
    @weakify(self);
    [ESService getSearchHotWordRequest:request success:^(NSArray *response) {
        @strongify(self);

        
        self.hotItems = response;
        
        [self addAndLayoutTagsWithTagsContentView:self.hotSearchTagsContentView tagTexts:response];
        [self.baseSearchTableView reloadData];
        
        //[self.hotCollectView reloadData];
        
    } failure:^(NSError *error) {
        
        
    }];
}
@end
