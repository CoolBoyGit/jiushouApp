//
//  ESMyFootController.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESMyFootController.h"
#import "ESMyFootListCell.h"
#import "ESSpecialSaleView.h"//表尾
#import "ESProductViewCell.h"
#import "ESHomeShopDetailController.h"
#import <math.h>
@interface ESMyFootController()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) UICollectionView                      *bottomCollectionView;//biaowei
/** from */
@property (strong,nonatomic) ESSpecialSaleView*speciaSaleView;
@property (nonatomic,assign) NSInteger page;
/** 足迹item （item ：FootprintInfo ） */
@property (nonatomic,strong) NSMutableArray *footItems;
@property (nonatomic,strong) UILabel*tipLabel;
@property (nonatomic,strong) NSString *tipStr;
@property (nonatomic,copy)  NSString*string;
@property (nonatomic,strong) UIView*tipsView;

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,assign) CGFloat witdh;
@property (nonatomic,strong) UIButton*rightButton;
//用来判断是否显示左边的打勾的按钮
@property (nonatomic,assign) BOOL isShowButton;
@property (nonatomic,strong) UIButton*delectButton;
@property (nonatomic,strong) UIView *bgView;//背景view
@property (nonatomic,strong) UIView* selectView;//两个按钮的view
@property (nonatomic,strong) UIButton*delectSelectButon;//删除选中的宝贝的时候的Button
@property (nonatomic,strong) UIButton*cancelButton;//取消的按钮
@property (nonatomic,strong) UIView*mengView;//按钮的view
@property (nonatomic,strong) NSMutableArray*delectArray;//用来存放多算删除收藏的商品Id;
@property (nonatomic,strong)NSIndexPath*index;
/**存放的是底部的collect数据**/
@property (nonatomic,strong)NSMutableArray*relatItemArray;
@property (nonatomic,strong)CancelFavoritesGoodsRequest*favoriRequest;
@property (nonatomic,strong) FavoritesGoodsInfo*favoritesInfo;
@property (nonatomic,strong) FootprintInfo*footInfo;
@property (nonatomic,strong) DelFootprintRequest*deleFootREquest;


@property (nonatomic,strong) UIView*heardView;//没有数据的时候的头部视图
@property (nonatomic,strong) UILabel*firstLbel;//
@property (nonatomic,strong) UILabel*seconLable;
@end

@implementation ESMyFootController
-(UILabel *)firstLbel{
    if (_firstLbel==nil) {
        _firstLbel=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, 20)];
        _firstLbel.text=@"空空如也";
        _firstLbel.textColor=AllTextColor;
        _firstLbel.textAlignment=NSTextAlignmentCenter;
        
    }
    return _firstLbel;
}

-(UILabel*)seconLable{
    if (_seconLable==nil) {
        _seconLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, ScreenWidth, 20)];
        _seconLable.textAlignment=NSTextAlignmentCenter;
        _seconLable.textColor=AllTextColor;
        _seconLable.text=@"就手推荐";
    }
    return _seconLable;
}
-(UIView *)heardView{
    if (_heardView==nil) {
        _heardView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
        _heardView.backgroundColor=[UIColor whiteColor];
    }
    return _heardView;
}

-(NSMutableArray *)relatItemArray{
    if (_relatItemArray==nil) {
        _relatItemArray=[[NSMutableArray alloc]init];
    }
    return _relatItemArray;
}
-(ESSpecialSaleView *)speciaSaleView{
    if (_speciaSaleView==nil) {
        _speciaSaleView=[[ESSpecialSaleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, (((ScreenWidth-3)/2.0+65)*15+40+14*3))];
    }
    return _speciaSaleView;
}
-(NSMutableArray *)delectArray{
    if (!_delectArray) {
        _delectArray=[[NSMutableArray alloc]init];
        
    }
    return _delectArray;
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth  , ScreenHeight-118)];
        //_bgView.backgroundColor=[UIColor clearColor];
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideBgView)];
        [_bgView addGestureRecognizer:tap];
        _bgView.backgroundColor=RGB(76, 76, 76);
        _bgView.alpha=0.4;
    }
    return _bgView;
}

-(void)hideBgView{
    [UIView animateWithDuration:0.5 animations:^{
        self.selectView.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 118);
        self.bgView.frame=CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight-118);
    }];
}
-(UIView *)selectView{
    if (_selectView==nil) {
        _selectView=[[UIView alloc]init];
        _selectView.frame=CGRectMake(0, ScreenHeight, ScreenHeight, 118);
        _selectView.backgroundColor=RGB(237, 237, 237);
    }
    return _selectView;
}
-(UIButton *)delectSelectButon{
    if (_delectSelectButon==nil) {
        _delectSelectButon=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 49)];
        [_delectSelectButon setTitle:@"删除" forState:UIControlStateNormal];
//        _delectSelectButon.titleLabel.font=[UIFont systemFontOfSize:15];
        [_delectSelectButon setTitleColor:RGB(233, 40, 46) forState:UIControlStateNormal];
        _delectSelectButon.backgroundColor=[UIColor whiteColor];
        [_delectSelectButon addTarget:self action:@selector(delectSelectButonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delectSelectButon;
}
-(void)delectSelectButonAction{
    [self deleteCollectionAtGoods_id:self.delectArray andFlag:1];
}
-(UIButton *)cancelButton{
    if (_cancelButton==nil) {
        _cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 118-49, ScreenWidth, 49)];
        _cancelButton.backgroundColor=[UIColor whiteColor];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//        _cancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_cancelButton setTitleColor:RGB(70, 70, 70) forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cancelButton;
}
-(void)cancelButtonAction{
    [UIView animateWithDuration:0.5 animations:^{
        self.selectView.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 118);
        self.bgView.frame=CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight-118);
    }];
    
}
-(UIButton *)delectButton{
    if (_delectButton==nil) {
        _delectButton=[[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 49)];
        [_delectButton setTitle:@"删除" forState:UIControlStateNormal];
        [_delectButton setBackgroundColor:RGB(233, 40, 46)];
        [_delectButton addTarget:self action:@selector(delectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delectButton;
}
-(void)delectButtonAction{
    if (self.delectArray.count==0) {
        TipViewAnimation*view=[[TipViewAnimation alloc]initWithFrame:self.view.bounds andTip:@"至少选择一个宝贝"];
        [view show];
        return;
        
        
    }else{
        [self.delectSelectButon setTitle:[NSString stringWithFormat:@"删除%zd个宝贝",self.delectArray.count]forState:UIControlStateNormal];
        [kKeyWindow addSubview:self.bgView];
        //[self.bgView addSubview:self.selectView];
        [kKeyWindow addSubview:self.selectView];
        [UIView animateWithDuration:0.6 animations:^{
            self.selectView.frame=CGRectMake(0, ScreenHeight-118, ScreenWidth, 118);
            self.bgView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-118);
        }];
    }
    
    
}
-(UIButton*)rightButton{
    if (_rightButton==nil) {
        _rightButton.backgroundColor=[UIColor yellowColor];
        _rightButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_rightButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_rightButton setTitleColor:AllTextColor forState:UIControlStateNormal];
        [_rightButton setTitle:@"完成" forState:UIControlStateSelected];
        [_rightButton setTitleColor:RGB(233, 40, 46) forState:UIControlStateSelected];
        [_rightButton setTitleColor:AllTextColor forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
- (NSMutableArray *)footItems
{
    if (!_footItems) {
        _footItems = [NSMutableArray array];
    }
    return _footItems;
}
-(UILabel *)label{
    if (_label==nil) {
        _label=[[UILabel alloc]init];
        _label.text=@"就手猜你喜欢";
        self. witdh =[_label.text widthOfFont:[UIFont systemFontOfSize:15]];
        _label.textAlignment=NSTextAlignmentCenter;
        _label.font=[UIFont systemFontOfSize:15];
    }
    return _label;
}
-(UILabel *)tipLabel{
    if (_tipLabel==nil) {
        _tipLabel=[[UILabel alloc]init];
        _tipLabel.text=self.tipStr;
        _tipLabel.font=[UIFont systemFontOfSize:17];
        _tipLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _tipLabel;
}
-(UIView *)tipsView{
    if (_tipsView==nil) {
        _tipsView=[[UIView alloc]init];
        _tipsView.backgroundColor=[UIColor whiteColor];
    }
    return _tipsView;
}
-(void)rightButtonAction{
    //[self.view addSubview:self.delectButton];
    
    self.rightButton.selected=!self.rightButton.selected;
    self.isShowButton=self.rightButton.selected;
    if (self.rightButton.selected) {
        [UIView animateWithDuration:0.6 animations:^{
            
            
            self.delectButton.frame=CGRectMake(0, ScreenHeight-49, ScreenWidth, 49);
            
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.delectButton.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 49);
        }];
        
    }
    
    [self.tableView reloadData];
}
#pragma mark - LifeCycle
- (void)viewDidLoad
{
    
//    self.navigationController.navigationBar.translucent=NO;
    //self.navigationController.navigationBar.alpha=1.0f;
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    TitleCenter;
    switch (self.flag) {
        case 0:
            self.navigationItem.title=@"我的收藏";
            self.tipStr=@"收藏夹猜你喜欢";
            break;
        case 1:
            self.navigationItem.title=@"心愿单";
            self.tipStr=@"心愿单猜你喜欢";
            
            break;
        case 2:
            self.navigationItem.title=@"到货提醒";
            self.tipStr=@"就手猜你喜欢";
            break;
        case 3:
            self.navigationItem.title=@"我的足迹";
            self.tipStr=@"小就猜你喜欢";
            break;
        default:
            break;
    }
    [self fetchGoods];
    [self.selectView addSubview:self.delectSelectButon];
    [self.selectView addSubview:self.cancelButton];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@64);
        make.bottom.equalTo(@0);
    }];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshList];
    }];
    MJRefreshAutoNormalFooter*footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self moreList];
    }];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    self.tableView.mj_footer=footer;
    [self refreshList];
    [self.view addSubview:self.delectButton];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=NO;
    [self fetchFootprint];
    
}
#pragma mark
#pragma mark - tableview代理方法;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.footItems.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isShowButton) {
        
        
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
            if (self.flag==3) {
                FootprintInfo *info = [self.footItems objectAtIndex:indexPath.row];
                ESHomeShopDetailController *detail = [[ESHomeShopDetailController alloc] init];
                //    detail.isNavHidden = YES;
              
                detail.goods_id = info.goods_id;
                [self.navigationController pushViewController:detail animated:YES];
//                ESRootViewController*rootvc=[[ESRootViewController alloc]init];
//                rootvc.hidesBottomBarWhenPushed=YES;
//                //GoodsInfo *info = [self.goodsItems objectAtIndex:indexPath.row];
//                rootvc.goods_id=info.goods_id;
//                [self.navigationController pushViewController:rootvc animated:YES];
                
            }else{
                FavoritesGoodsInfo*info=[self.footItems objectAtIndex:indexPath.row];
                ESHomeShopDetailController *detail = [[ESHomeShopDetailController alloc] init];
                detail.goods_id = info.goods_id;
                [self.navigationController pushViewController:detail animated:YES];
            }
            
        
        
    }
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        if (editingStyle == UITableViewCellEditingStyleDelete) {//删除
            NSMutableArray*array=[[NSMutableArray alloc]initWithObjects:indexPath, nil];
            [self deleteCollectionAtGoods_id:array andFlag:0];
            
        }
    
    
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        return UITableViewCellEditingStyleDelete & UITableViewCellEditingStyleInsert;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView*view=[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    view.frame=CGRectMake(0, 0, ScreenWidth, 30);
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESMyFootListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESMyFootListCell"];
    cell.index=indexPath;
    if (self.isShowButton) {
        
            if (self.flag==3) {//足迹
                cell.footInfo = [self.footItems objectAtIndex:indexPath.row];
                cell.flag=1;
                cell.isShowButton=YES;
                @weakify(self);
                cell.selectBlock=^(BOOL isDelect, NSIndexPath*index){
                    @strongify(self);
                    if (isDelect) {
                        [self.delectArray addObject:index];
                    }else{
                        [self.delectArray removeObject:index];
                    }
                    
                };
                
            }
            else{//正常情况的model //这个是收藏
                cell.favoritesInfo = [self.footItems objectAtIndex:indexPath.row];
                cell.flag=0;
                cell.isShowButton=YES;
                @weakify(self);
                cell.selectBlock=^(BOOL isDelect,  NSIndexPath* row){
                    @strongify(self);
                    if (isDelect) {
                        [self.delectArray addObject:row];
                    }else{
                        [self.delectArray removeObject:row];
                    }
                    
                    
                };
                
            }
            
        
        return cell;
    }
    else{
            if (self.flag==3) {
                cell.footInfo=[self.footItems objectAtIndex:indexPath.row];
                cell.isShowButton=NO;
            }
            else{
                cell.favoritesInfo = [self.footItems objectAtIndex:indexPath.row];
                cell.isShowButton=NO;
                
            }
            
        
        
        return cell;
    }
    
    
}
//这个方法是cell即将显示的时候 调用的 可以解决cell的重用机制带来的问题.
-(void)tableView:(UITableView *)tableView willDisplayCell:(ESMyFootListCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delectArray containsObject:indexPath]) {
        
        cell.ediButton .selected=YES;
    }else
    {
        cell.ediButton .selected=NO;
    }
}
#pragma mark
#pragma mark lazy init
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.backgroundColor=RGBA(247, 247, 247, 1);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESMyFootListCell class] forCellReuseIdentifier:@"ESMyFootListCell"];
    }
    return _tableView;
}
- (UICollectionView*)bottomCollectionView
{
    if(!_bottomCollectionView)
    {
        UICollectionViewFlowLayout *flowRight = [[UICollectionViewFlowLayout alloc] init];
        flowRight.scrollDirection = UICollectionViewScrollDirectionVertical;
        _bottomCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, 3450) collectionViewLayout:flowRight];
        _bottomCollectionView.dataSource = self;
        _bottomCollectionView.delegate = self;
        _bottomCollectionView.scrollEnabled = NO;
        _bottomCollectionView.showsVerticalScrollIndicator = NO;
        _bottomCollectionView.showsHorizontalScrollIndicator = NO;
        [_bottomCollectionView setBackgroundColor:RGB(247, 247, 247)];
        [_bottomCollectionView registerClass:[ESProductViewCell class] forCellWithReuseIdentifier:@"ESProductViewCell"];
    }
    return _bottomCollectionView;
}


#pragma mark - UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.relatItemArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESProductViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESProductViewCell" forIndexPath:indexPath];
    cell.goodsInfo = [self.relatItemArray objectAtIndex:indexPath.item];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth-3)/2.0,(ScreenWidth-3)/2.0+65) ;
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
//设置列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsInfo *info = [self.relatItemArray objectAtIndex:indexPath.item];
    ESHomeShopDetailController*detail=[[ESHomeShopDetailController alloc]init];
    detail.goods_id=info.gid;
    [self .navigationController pushViewController:detail animated:YES];
}

#pragma mark - Networking

#pragma mark - 请求列表数据
- (void)refreshList
{
    self.page = 1;
    
    [self fetchFootprint];
    
    
}
- (void)moreList
{
    self.page ++ ;
    [self fetchFootprint];
    
    
}
#pragma mark 删除
//左拉 删除的是收藏 心愿单 或者是到货提醒//0 代表左拉删除 1代表删除多个
- (void)deleteCollectionAtGoods_id:(NSMutableArray*)array andFlag:(int)flag{
    
    if (self.flag == 3) {//我的足迹
        NSMutableString*fid=[[NSMutableString alloc]init];
        
        for (NSIndexPath*index in array) {
            FootprintInfo*footInfo=[self.footItems objectAtIndex:index.row];
            NSString*footId=footInfo.fid;
            if ([fid isEqualToString:@""]) {
                [fid appendString:footId];
            }else{
                [fid appendString:[NSString stringWithFormat:@",%@",footId]];
            }
        }
        self.deleFootREquest  = [DelFootprintRequest request];
        self.deleFootREquest.fid = fid;
        @weakify(self);
        [ESService delFootprintRequest:self.deleFootREquest success:^{
            @strongify(self);
            [self endGSNetworking];
            NSArray*copyArray=[self.footItems copy];
            for (NSIndexPath*index in array) {
                for (FootprintInfo*info in copyArray) {
                    FootprintInfo*footInfo=[copyArray objectAtIndex:index.row];
                    if ([info.fid isEqualToString:footInfo.fid]) {
                        [self.footItems removeObject:info];
                    }
                }
            }
            
            [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationTop];
            [self.delectArray removeAllObjects];
            [self cancelButtonAction];
            
        } failure:^(NSError *error) {
            @strongify(self);
            [self endGSNetworking];
        }];
        
    }else{//删除收藏 心愿单 以及到货提醒
        NSMutableString*fid=[[NSMutableString alloc]init];
        
        for (NSIndexPath*index in array) {
            FavoritesGoodsInfo*favortInfo=[self.footItems objectAtIndex:index.row];
            NSString*favortId=favortInfo.goods_id;
            if ([fid isEqualToString:@""]) {
                [fid appendString:favortId];
            }else{
                [fid appendString:[NSString stringWithFormat:@",%@",favortId]];
            }
        }
        self.favoriRequest = [CancelFavoritesGoodsRequest request];
        self.favoriRequest.goods_id  = fid;
        self.favoriRequest.type  = [NSNumber numberWithInt: self.flag];
        
    }
    @weakify(self);
    [ESService cancelFavoritesGoodsRequest:self.favoriRequest success:^{
        @strongify(self);
        [self endGSNetworking];
        NSArray*copyArray=[self.footItems copy];
        for (NSIndexPath*index in array) {
            for (FavoritesGoodsInfo*info in copyArray) {
                FavoritesGoodsInfo*footInfo=[copyArray objectAtIndex:index.row];
                if ([info.goods_id isEqualToString:footInfo.goods_id]) {
                    [self.footItems removeObject:info];
                }
            }
        }
        [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationTop];
        [self.delectArray removeAllObjects];
        [self cancelButtonAction];
        
        [self fetchFootprint];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}



- (void)fetchFootprint
{
    CGFloat h=ScreenHeight-64;


    if (self.flag==3) {//我的足迹
        GetFootprintRequest *request = [GetFootprintRequest request];
        request.page = [NSNumber numberWithInteger:self.page];
        request.n    = @8;
                @weakify(self);
        [ESService getFootprintRequest:request success:^(NSArray *response) {
            @strongify(self);
            [self endGSNetworking];
           
            if ( abs((int)response.count*84-40)<h) {
                self.tableView.tableFooterView=self.speciaSaleView;
                self.speciaSaleView.text=self.tipStr;
                //self.speciaSaleView.hidden=YES;
                [self.speciaSaleView addSubview:self.bottomCollectionView];
                [self.bottomCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.left.equalTo(@0);
                    make.top.equalTo(@40);
                    make.height.equalTo(@(((ScreenWidth-3)/2.0+65)*15+40+14*3));
                }];
                [self.tableView reloadData];

            }else{
                self.tableView.tableFooterView=nil;
            }
            
            if (self.page == 1) {
                if (response.count==0) {
                    [self.heardView addSubview:self.firstLbel];
                    [self.heardView addSubview:self.seconLable];
                    self.tableView.tableHeaderView=self.heardView;
                }else{
                    self.tableView.tableHeaderView=nil;
                }
                [self.footItems removeAllObjects];
            }
//            if (response.count < 20) {
//                [self.tableView.mj_footer endRefreshingWithNoMoreData];
//            } else
//            {
//                [self.tableView.mj_footer resetNoMoreData];
//            }
            
            [self.footItems addObjectsFromArray:response];
            [self.tableView reloadData];
            
            
            
        } failure:^(NSError *error) {
            @strongify(self);
            [self endGSNetworking];
        }];
    }else {
        GetFavoritesGoodsRequest *request = [GetFavoritesGoodsRequest request];
        request.type=[NSNumber numberWithInt:self.flag];
        request.page=[NSNumber numberWithInteger:self.page];
        request.n=@8;
        @weakify(self);
        [ESService getFavoritesGoodsRequest:request success:^(NSArray *response) {
            @strongify(self);
            [self endGSNetworking];
            
           
            if ( abs((int)response.count*100-40)<h) {
                self.tableView.tableFooterView=self.speciaSaleView;
                self.speciaSaleView.text=self.tipStr;
                [self.speciaSaleView addSubview:self.bottomCollectionView];
                [self.bottomCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.left.equalTo(@0);
                    make.top.equalTo(@40);
                    make.height.equalTo(@(((ScreenWidth-3)/2.0+65)*15+40+14*3));
                }];
            }else{
                self.tableView.tableFooterView=nil;
            }
            if (self.page == 1) {
                if (response.count==0) {
                    [self.heardView addSubview:self.firstLbel];
                    [self.heardView addSubview:self.seconLable];
                    self.tableView.tableHeaderView=self.heardView;
                }else{
                    self.tableView.tableHeaderView=nil;                }
                [self.footItems removeAllObjects];
            }
//            self.tableView.mj_footer.hidden = response.count < 20;
//            if (response.count < 20) {
//                [self.tableView.mj_footer endRefreshingWithNoMoreData];
//            } else
//            {
//                [self.tableView.mj_footer resetNoMoreData];
//            }
//            
            [self.footItems addObjectsFromArray:response];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            @strongify(self);
            [self endGSNetworking];
        }];
    }
    
    
}
//请求底部的collection的数据
-(void)fetchGoods{
    GoodsRequest*request=[GoodsRequest request];
    request.page=[NSNumber numberWithInteger:self.page];
    request.n=[NSNumber numberWithInt:30];
    request.orderBy=[NSNumber numberWithInt:2];
    @weakify(self);
    [ESService goodsRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        [self.relatItemArray addObjectsFromArray:response];
        
        [self.bottomCollectionView reloadData];
        
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
        
    }];
    
}

#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

@end
