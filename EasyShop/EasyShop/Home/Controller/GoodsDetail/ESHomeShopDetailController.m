
//
//  ESHomeShopDetailController.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/3/27.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESHomeShopDetailController.h"
#import <AVFoundation/AVFoundation.h>
#import "ESCommentCell.h"
#import "ESShopDetailCell.h"
#import "ESShopInfoCell.h"
#import "ESShopPriceCell.h"
#import "ESProductImageViewCell.h"
#import "ESShopDetailHeaderTitleView.h"
#import "ESShopCartViewController.h"
#import "ESRecommendShopListCell.h"
#import "ESFunctionView.h"
#import "ESWebSocket.h"
#import "ESIndicator.h"
#import "ICAlert.h"
#import "ShareTool.h"
//#import "HomeTitleView.h"
#import "ESShopDetailView.h"
#import "ICShareInfoView.h"
#import "ESChatViewController.h"
#import "EaseMob.h"
#import "ICShareInfoView.h"

#import "ESClusterDetailController.h"
#import "ESclusterPayController.h"
#import "ESTipsCell.h"
#import "ESToDetailPeopleCell.h"


#import "ESCommentCell.h"
#import "ESShopCommentCell.h"
#import "ESShopCommentController.h"
#import "ESLoginViewController.h"
#import "WarningControlView.h"
#import "HHBannerView.h"//一个简单的轮播框架
#import "MJRefresh.h"
#import "MJRefreshComponent.h"
@interface ESHomeShopDetailController ()<UITableViewDataSource,UITableViewDelegate,ICAlertDelegate,ESFunctionViewDelegate,UIWebViewDelegate,UIAlertViewDelegate>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ESFunctionView *bottonView;

/** ESWebSocket */
@property (nonatomic,strong) ESWebSocket *webSocket;

/** 商品详情 */
@property (nonatomic,strong) GoodsDetailInfo *goodsDetailInfo;

/** 评价信息  (item : GoodEvaluationItem ) */
@property (nonatomic,strong) NSArray *evaluationItems;
/** 推荐商品 */
@property (nonatomic,strong) NSArray *relatedItems;

/** indicator */
@property (nonatomic,strong) ESIndicator *indicator;
@property (nonatomic,assign) BOOL select;
/*用来显示websocke的消息*/
@property (nonatomic,strong) UIView*bgView;
@property (nonatomic,strong) UILabel*titleLabel;
@property (nonatomic,strong) UIImageView*imageView;
//@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) ESShopDetailView *webView;
//@property (strong, nonatomic) HomeTitleView     *titleView;
@property (nonatomic,strong) AVPlayer* player;
@property (nonatomic,strong) UIImageView *moveImageView;
@property (nonatomic,strong) NSDate *firstDate;
@property (nonatomic,strong) NSDate *secondDate;
@property (nonatomic,assign) int flag;//用来做加入购物车的标志
@property (nonatomic,strong) UILabel *tipsLabel;
@property (nonatomic, strong) UILabel *countLabel; //
@property (nonatomic ,strong) UIView*tableFooterView;

@property (nonatomic,strong)  UIWebView*webview;

/** 用来做拼团的属性 */
@property (nonatomic,strong) NSMutableArray*clusterArray;


/**
 *  name    用来做为是否有拼多多按钮的参照
 *  return  <#type#>
 *  @param  <#param1, param2, ...#>
 *
 **/
@end

@implementation ESHomeShopDetailController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.flag=1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"商品详情";
    //设置按钮的颜色返回按钮的颜色
     [self.navigationController.navigationBar setTintColor:RGB(70, 70, 70)];
    //设置背景颜色
    //[self.navigationController.navigationBar setBarTintColor:RGB(233, 40, 46)];
    //self.navigationController.navigationBar.translucent = NO;
    [self addNotification];
    UIButton*rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightButton addTarget:self action:@selector(shopDeatilToshare) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"detail_share"] forState:UIControlStateNormal];
    UIBarButtonItem*buttonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=buttonItem;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@64);
        make.bottom.equalTo(@(-44));
    }];
    
    [self.scrollView addSubview:self.tableView];
    [self.scrollView addSubview:self.webview];
    
      @weakify(self);
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self fetchGoodsDetail];
        [self fetchGoodsEvaluation];
        [self fetchRelatedGoods];
    }];
    MJRefreshAutoNormalFooter*footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadWbeView)];
    self.tableView.mj_footer =footer;
    footer.stateLabel.backgroundColor=[UIColor colorWithWhite:0.902 alpha:1.000];
    [footer setTitle:@"继续拖动,查看图文详情" forState:MJRefreshStateIdle];
    [footer setTitle:@"继续拖动,查看图文详情" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"继续拖动,查看图文详情" forState:MJRefreshStateNoMoreData];
    footer.automaticallyRefresh=NO;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(goToDeatail)];
    header.lastUpdatedTimeLabel.hidden=YES;
    [header setTitle:@"下拉,返回宝贝详情" forState:MJRefreshStateIdle];
    [header setTitle:@"释放,返回宝贝详情" forState:MJRefreshStatePulling];
    [header setTitle:@"" forState:MJRefreshStateRefreshing];
    self.webview.scrollView.mj_header =header;
    [self.bgView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@3);
        make.top.equalTo(@3);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];
    
    [self.bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(5);
        make.width.equalTo(@195);
        make.height.equalTo(@20);
        make.top.equalTo(@(8));
        
    }];
    
    
    
    
    self.bottonView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.bottonView];
    
    [self.bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@44);
    }];
    [self fetchGoodsDetail];
    [self fetchGoodsEvaluation];
    [self fetchRelatedGoods];
    [self addNotification];
    [self.webSocket connect];
    
}

//动画效果
- (void)close
{
    //CGRect frame = _popView.frame;
    //frame.origin.y= _popView.frame.size.height;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //maskView隐藏
        //[_maskView setAlpha:0.f];
        //popView下降
        //_popView.frame = frame;
        
        //同时进行 感觉更丝滑
        [self.view.layer setTransform:[self firstTransform]];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //变为初始值
            [self.view.layer setTransform:CATransform3DIdentity];
            
        } completion:^(BOOL finished) {
            
            //移除
            // [_popView removeFromSuperview];
        }];
        
    }];
    
    
    
}
- (void)show
{
    //[[UIApplication sharedApplication].windows[0] addSubview:_popView];
    
    CGRect frame = self.view.frame;
    frame.origin.y =0;
    //self.view.bounds.size.height;
    //    - _popView.frame.size.height+64;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [self.view.layer setTransform:[self firstTransform]];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self.view.layer setTransform:[self secondTransform]];
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
}

- (CATransform3D)firstTransform{
    CATransform3D t1 = CATransform3DIdentity;
    
    t1.m34 = 1.0/-900;
    //带点缩小的效果
    //t1=CATransform3DMakeScale(0.95, 0.95, 0.95);
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    //绕x轴旋转
    t1 = CATransform3DRotate(t1, 15.0 * M_PI/90.0, 1, 0, 0);
    return t1;
    
}

- (CATransform3D)secondTransform{
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = [self firstTransform].m34;
    //向上移
    t2 = CATransform3DTranslate(t2, 0, self.view.frame.size.height * (-0.08), 0);
    //第二次缩小
    t2 = CATransform3DScale(t2, 0.8, 0.8, 1);
    return t2;
}

-(void)goToDeatail{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    //结束加载
    self.scrollView.scrollEnabled=NO;
    [self.webview.scrollView.mj_header endRefreshing];
}
#pragma mark loadWebView
-(void)loadWbeView{
   
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self.scrollView setContentOffset:CGPointMake(0, ScreenHeight-64) animated:YES];
    } completion:^(BOOL finished) {
        //结束加载
        self.scrollView.scrollEnabled=NO;
        
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
-(UIWebView *)webview{
    if (_webview==nil) {
        _webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, ScreenHeight-64, ScreenWidth, ScreenHeight-64-44)];
        self.webview.backgroundColor=[UIColor whiteColor];
    }
    return _webview;
}
-(UIImageView *)moveImageView{
    if (_moveImageView==nil) {
        _moveImageView=[[UIImageView alloc]init];
        _moveImageView.layer.cornerRadius=20;
        _moveImageView.layer.masksToBounds=YES;
        _moveImageView.backgroundColor=[UIColor yellowColor];
    }
    return _moveImageView;
    
    
}

-(UIView *)tableFooterView{
    if (_tableFooterView==nil) {
        _tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        _tableFooterView.backgroundColor=[UIColor colorWithRed:0.502 green:0.251 blue:0.000 alpha:1.000];
        UILabel*label=[[UILabel alloc]init];
        label.frame=CGRectMake(0, 0, 0, 0);
        label.text=@"继续拖动,查看图文详情";
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:15];
        
        [_tableFooterView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@5);
            make.left.right.equalTo(@0);
            make.height.equalTo(@20);
        }];
        
    }
    return _tableFooterView;
}
- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-44)];
        // _scrollView.backgroundColor=[UIColor ];
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled=NO;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(ScreenWidth, (ScreenHeight-64-44)*2-44);
    }
    return _scrollView;
}

- (ESShopDetailView *)webView
{
    if(_webView == nil)
    {
        
        _webview.delegate=self;
        _webView = [[ESShopDetailView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight)];
    }
    return _webView;
}
-(NSMutableArray *)clusterArray{
    if (_clusterArray==nil) {
        _clusterArray=[NSMutableArray array];
    }
    return _clusterArray;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-44) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;//设置代理，self就是实现方法的对象
        _tableView.tableFooterView = [[UIView alloc] init];
        // _tableView.tableFooterView=self.tableFooterView;
        
        _tableView.showsVerticalScrollIndicator=YES;
        //评论
        [_tableView registerClass:[ESCommentCell class] forCellReuseIdentifier:@"ESCommentCell"];
        //商品bannar
        [_tableView registerClass:[ESProductImageViewCell class] forCellReuseIdentifier:@"ESProductImageViewCell"];
        //推荐商品
        [_tableView registerClass:[ESRecommendShopListCell class] forCellReuseIdentifier:@"ESRecommendShopListCell"];
        //商品详情 网页
        [_tableView registerClass:[ESShopDetailCell class] forCellReuseIdentifier:@"ESShopDetailCell"];
        [_tableView registerClass:[ESShopInfoCell class] forCellReuseIdentifier:@"ESShopInfoCell"];
        [_tableView registerClass:[ESShopPriceCell class] forCellReuseIdentifier:@"ESShopPriceCell"];
        [_tableView registerClass:[ESShopCommentCell class] forCellReuseIdentifier:@"ESShopCommentCell"];
        //团购提示语
        [_tableView registerClass:[ESTipsCell class] forCellReuseIdentifier:@"ESTipsCell"];
        [_tableView registerClass:[ESToDetailPeopleCell class] forCellReuseIdentifier:@"ESToDetailPeopleCell"];
        
    }
    return _tableView;
}

-(UILabel *)tipsLabel{
    if (_tipsLabel==nil) {
        NSString*str=@"客官,请慢点.......";
        CGFloat wiht=  [str widthOfFont:[UIFont systemFontOfSize:13]];
        _tipsLabel=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-wiht)/2.0-25, self.view.centerY-50, wiht+50, 30)];
        _tipsLabel.text=@"客官,请慢点.......";
        _tipsLabel.backgroundColor=RGB(90, 90, 90);
        _tipsLabel.textAlignment=NSTextAlignmentCenter;
        
    }return _tipsLabel;
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]initWithFrame:CGRectMake(30, 74, 223, 36)];
        _bgView.layer.cornerRadius=17;
        _bgView.layer.masksToBounds=YES;
        _bgView.backgroundColor=[UIColor grayColor];
        _bgView.alpha=0.9;
    }
    return _bgView;
}
-(UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        _titleLabel.font=[UIFont systemFontOfSize:10];
        _titleLabel.layer.cornerRadius=10;
        _titleLabel.layer.masksToBounds=YES;
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.backgroundColor=[UIColor clearColor];
        _titleLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _titleLabel;
}
-(UIImageView *)imageView{
    if (_imageView==nil) {
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _imageView.layer.cornerRadius=15;
        _imageView.layer.masksToBounds=YES;
    }
    return _imageView;
}
- (ESWebSocket *)webSocket
{
    if (!_webSocket) {
        _webSocket = [[ESWebSocket alloc] init];
        @weakify(self);
        _webSocket.receiveBroadcastOrder = ^(BroadcastOrderInfo *info){
            @strongify(self);
            [self.view addSubview:self.bgView];
            self.titleLabel.text=info.title;
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:info.image] placeholderImage:nil];
            [UIView animateWithDuration:3.0 animations:^{
                self.bgView.alpha = 0.01;
            } completion:^(BOOL finished) {
                [self.bgView removeFromSuperview];
                self.bgView.alpha = 1.0;
            }];
            
        };
    }
    return _webSocket;
}
-(void)leftButtoonAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 点击了分享按钮
- (void)shopDeatilToshare
{
   // [self show];
    ICShareInfoView*view = [[ICShareInfoView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 160)];;
    @weakify(self);
    [view setSelectShareButton:^(NSInteger index) {
        @strongify(self);
        [self ICAlertShareDidSelectIndex:index];
    }];
    view.tapHidenBLock=^{
       // [self close];
    };
    [view showPopView];
}
#pragma mark 分享
- (void)ICAlertShareDidSelectIndex:(NSInteger)index

{
    NSString*url=@"http://wap.jiushouguoji.com/detail/10831";
    NSString*newUrl=[url stringByReplacingOccurrencesOfString:@"10831" withString:self.goodsDetailInfo.gid];
    // 检测是否安装了微信
    
    if (index == 0) {//朋友圈
        [[ShareTool shareTool] shareWithType:ShareType_WexinTimeline
                                       title:self.goodsDetailInfo.name
                                         url:newUrl
                                       image:self.goodsDetailInfo.image];
    }else if (index == 1){//微信好友
        //http://www.jiushouguoji.com/goods-detail-964.html
        
        [[ShareTool shareTool] shareWithType:ShareType_WexinSession
                                       title:self.goodsDetailInfo.name
                                         url:newUrl
                                       image:self.goodsDetailInfo.image];
        
    }
    if(index==2){
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = newUrl;
        [ESToast showMessage:@"成功复制"];
    }
    
}





- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.webSocket close];
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 5) {
        return self.evaluationItems.count;
        
    }
    if (section == 6) {
        return 1;
    }
    if (section==3) {//这里是拼团的提示
        if (self.goodsDetailInfo.goodsInfoType==GoodsInfoType_Sell) {
            if ([self.goodsDetailInfo.cluster isEqualToString:@"0"]) {
                return 0;
            }else{
                return 1;
            }
            
        }else{
            return 0;
        }
        
    }if (section==4) {//人数
        if (self.clusterArray.count==0) {
            
            return 0;
        }else{
            
            return self.clusterArray.count+1;
        }
        
    }
    return 1;
};

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {//是上面的banner
        ESProductImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESProductImageViewCell"];
        NSArray*array=[[NSMutableArray alloc]initWithArray:self.goodsDetailInfo.images];
        NSMutableArray*imageArray=[[NSMutableArray alloc]init];
        for (ESImageInfo*imageStr in array) {
            [imageArray addObject:imageStr.image];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageItems =imageArray ;
        return cell;
    }
    if (indexPath.section == 1) {//商品原价
        ESShopPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESShopPriceCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.goodsInfo = self.goodsDetailInfo;
        return cell;
    }
    if (indexPath.section == 2) {//商品信息
        ESShopInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESShopInfoCell"];
        //        cell.model = nil;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.goodsInfo = self.goodsDetailInfo;
        return cell;
    }
    if (indexPath.section==3) {//放的是参团提示
        
        ESTipsCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESTipsCell"];
        cell.backgroundColor=[UIColor whiteColor];
        cell.isOneRow=NO;
        cell.goodsDetail=self.goodsDetailInfo;
        return cell;
        
    }
    if (indexPath.section==4){//放的是参团的人数  不用组头 都是用cell来解决问题.
        if (indexPath.row==0) {
            ESTipsCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESTipsCell"];
            cell.backgroundColor=RGBA(240, 240, 240, 1);
            cell.tipStr=@"以下老板正在开团,您可以直接参与,祝你购物愉快";
            return cell;
        }
        else{
            
            ESToDetailPeopleCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESToDetailPeopleCell"];
            if (self.clusterArray.count!=0) {
                cell.respone=[self.clusterArray objectAtIndex:indexPath.row-1];
            }
            
            return cell;
        }
    }
    if (indexPath.section == 5) {//商品评论
        ESShopCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESShopCommentCell"];
        cell.item = [self.evaluationItems objectAtIndex:indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            cell.isShowLine=YES;
        }else{
            cell.isShowLine=NO;
        }
        
        return cell;
        
    }
    if (indexPath.section == 6) {//推荐商品
        ESRecommendShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESRecommendShopListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.controller = self;
        cell.relatedItems  = self.relatedItems;
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return ScreenWidth;
    }
    if (indexPath.section == 2) {
        /*自动计算Label的高度*/
        CGRect rect=[self.goodsDetailInfo.name boundingRectWithSize:CGSizeMake(ScreenWidth-30, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        CGFloat h=[self.goodsDetailInfo.sevice heightOfFont:[UIFont systemFontOfSize:12] andWidth:ScreenWidth-20];
        CGFloat h1=[self.goodsDetailInfo.prompt heightOfFont:[UIFont systemFontOfSize:12] andWidth:ScreenWidth-20];
        
        return rect.size.height+25+h+h1;
    }
    if (indexPath.section==3) {
        return 30;
    }
    if (indexPath.section==4) {
        if (indexPath.row==0) {
            return 44;
        }else{
            return 64;
        }
    }
    if (indexPath.section == 5) {
        GoodEvaluationItem *item =   [self.evaluationItems objectAtIndex:indexPath.row];
        return  item.cellHeight;
    }
    if (indexPath.section == 6) {
        return 210;
    }
    
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ( section == 5) {
        return 40;
    }
    else if (section==6){
        return 40;
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ESShopDetailHeaderTitleView *titleView = [[ESShopDetailHeaderTitleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    if (section == 5) {//评论页面
        titleView.model = @"评论";
        titleView.button.hidden = NO;
        @weakify(self);
        [titleView setCallBack:^{//评论页面
            @strongify(self);
            ESShopCommentController *vc = [[ESShopCommentController alloc] init];
            vc.goods_id         = self.goods_id;
            CATransition *transition = [CATransition animation];
            [transition setType:kCATransitionPush];               //立方体翻转
            // transition.subtype = kCATransitionFromTop;
            transition.duration = 0.5;
            transition.timingFunction=UIViewAnimationCurveEaseInOut;
            [self.navigationController pushViewController:vc animated:YES];
            [self.navigationController.view.layer addAnimation:transition forKey:@"transition"];
            
        }];
        [titleView setTapBlock:^{
            @strongify(self);
            ESShopCommentController *vc = [[ESShopCommentController alloc] init];
            vc.goods_id         = self.goods_id;
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
    } else
    {
        titleView.button.hidden = YES;
        
        if (section == 6)
        {
            titleView.model = @"推荐商品";
        }
    }
    return titleView;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==4) {
        if (indexPath.row!=0) {
            //跳转到参团详情列表
            ESClusterDetailController*vc=[[ESClusterDetailController alloc]init];
            vc.flag=1;
            vc.isComeClusterOrder=NO;
            ClusterRespone *clusterinfo=[self.clusterArray objectAtIndex:indexPath.row-1];
            // vc.clusterId=clusterinfo.cid;
            vc.clusterRespone=clusterinfo;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark
#pragma mark - lazy init
-(ESFunctionView *)bottonView
{
    if (!_bottonView) {
        _bottonView = [[ESFunctionView alloc] initWithFrame:CGRectMake(0, ScreenHeight-64-44, ScreenWidth, 44)];
        _bottonView.delegate = self;
    }
    return _bottonView;
}


#pragma mark
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        
    }else{
        ESLoginViewController*loginVc=[[ESLoginViewController alloc]init];
        [self.navigationController pushViewController:loginVc animated:YES];
    }
}
#pragma mark - 底部功能型代理方法;
-(void)functionViewAction:(int)index
{
    if (!kUserManager.isLogin){
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>8.0) {
            WarningControlView*warning=[[WarningControlView alloc]initShowTitle:nil andMessage:@"请登录"];
            warning.cancelBlock=^(){
                
            };
            warning.sucessBlock=^(){
                ESLoginViewController*loginVc=[[ESLoginViewController alloc]init];
                [self.navigationController pushViewController:loginVc animated:YES];
            };
            
        }else{
            UIAlertView *alter1 = [[UIAlertView alloc] initWithTitle:nil message:@"请登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alter1.delegate=self;
            [alter1 show];
        }
        
        
    }else{
        switch (index) {
            case 100://收藏
            {
                [self handleCollect];
            }
                break;
            case 101://购物车
            {
                [[NSNotificationCenter defaultCenter]postNotificationName:ClickShopCarButtonToShopCar object:nil userInfo:nil];
                self.navigationController.tabBarController.selectedIndex=2;
                [self.navigationController popToRootViewControllerAnimated:YES];
//                ESShopCartViewController *cart = [[ESShopCartViewController alloc] init];
//                cart.isHome=YES;
//                [self.navigationController pushViewController:cart animated:YES];
            }
                break;
            case 102://论坛
                [self askService];
                break;
            case 103://加入购物车
            {
                switch (self.goodsDetailInfo.goodsInfoType) {
                        
                    case GoodsInfoType_Sell:
                        [self addCart];
                        
                        break;
                    case GoodsInfoType_Remind:
                        [self addFavoritesWithType:FavoritesType_Remind];    break;
                    case GoodsInfoType_Wish:
                        [self addFavoritesWithType:FavoritesType_Wish];
                        break;
                }
            }
                break;
            case 104://创团
            {
                ESclusterPayController*vc=[[ESclusterPayController alloc]init];
                vc.goods_id=self.goodsDetailInfo.gid;
                
                vc.typeStaus=ClusterPayStaus_FromHome;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
        
    }
    
}


-(void)askService//客服
{
    
    NSString*url=@"http://www.jiushouguoji.hk/goods-detail-964.html";
    NSString*newUrl=[url stringByReplacingOccurrencesOfString:@"964" withString:self.goodsDetailInfo.gid];
    
    NSDictionary *dic =  @{
                           @"msgtype":@{
                                   // 用户轨迹消息
                                   @"track":@{
                                           // 消息标题
                                           @"title": self.goodsDetailInfo.shop_name,
                                           // 商品价格
                                           @"price": [NSString stringWithFormat:@"¥%@",self.goodsDetailInfo.price],
                                           //                                               self.goodsDetailInfo.price,
                                           //                    @"¥: 235.00",
                                           // 商品描述
                                           @"desc":   self.goodsDetailInfo.shop_name,
                                           //                                                商品图片链接
                                           @"img_url": self.goodsDetailInfo.image,
                                           //                                                商品页面链接
                                           @"item_url": newUrl
                                           
                                           }
                                   }
                           };
    
    NSString *easeMob = @"JiuShouGuoJi2";
    [EaseSDKHelper sendTextMessage:@" "to:easeMob messageType:eMessageTypeChat requireEncryption:NO messageExt: dic];
    ESChatViewController * controller = [[ESChatViewController alloc] initWithConversationChatter:easeMob conversationType:eConversationTypeChat];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:NO];
}

#pragma mark - Networking

- (void)handleCollect
{
    if (self.goodsDetailInfo) {
        if (self.goodsDetailInfo.isCollect) {//已收藏
            [self cancleFavoritesWithType:FavoritesType_Collect];//取消收藏
            self.select=!self.select;
            self.bottonView.isSelect=self.select;
        }else{//未收藏，添加收藏
            [self addFavoritesWithType:FavoritesType_Collect];
            self.select=!self.select;
            self.bottonView.isSelect=self.select;
        }
    }
}

#pragma mark 添加收藏
- (void)addFavoritesWithType:(FavoritesType)type
{
    AddFavoritesGoodsRequest *request = [AddFavoritesGoodsRequest request];
    request.goods_id    = self.goods_id;
    request.type        = [NSNumber numberWithInt:type];
    
    @weakify(self);
    NSString *str = nil;
    switch (type) {
        case FavoritesType_Collect: str = @"收藏";    break;
        case FavoritesType_Wish:    str = @"心愿单";    break;
        case FavoritesType_Remind:  str = @"到货提醒";    break;
    }
    [self.indicator startAnimationWithMessage:[NSString stringWithFormat:@"正在添加%@...",str]];
    [ESService addFavoritesGoodsRequest:request success:^{
        @strongify(self);
        [self endGSNetworking];
        
        [ESToast showSuccess:[NSString stringWithFormat:@"添加%@成功！",str]];
        
        switch (type) {
            case FavoritesType_Collect: self.goodsDetailInfo.subscribe_collect = @"Y";    break;
            case FavoritesType_Wish: self.goodsDetailInfo.subscribe_wish = @"Y";    break;
            case FavoritesType_Remind: self.goodsDetailInfo.subscribe_arrival = @"Y";    break;
        }
        
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}
#pragma mark 取消收藏
- (void)cancleFavoritesWithType:(FavoritesType)type
{
    CancelFavoritesGoodsRequest *request = [CancelFavoritesGoodsRequest request];
    request.goods_id    = self.goods_id;
    request.type        = [NSNumber numberWithInt:type];
    
    @weakify(self);
    NSString *str = nil;
    switch (type) {
        case FavoritesType_Collect: str = @"收藏";    break;
        case FavoritesType_Wish:    str = @"心愿单";    break;
        case FavoritesType_Remind:  str = @"到货提醒";    break;
    }
    [self.indicator startAnimationWithMessage:[NSString stringWithFormat:@"正在取消%@...",str]];
    [ESService cancelFavoritesGoodsRequest:request success:^{
        @strongify(self);
        [self endGSNetworking];
        
        [ESToast showSuccess:[NSString stringWithFormat:@"取消%@成功！",str]];
        
        switch (type) {
            case FavoritesType_Collect:
                self.goodsDetailInfo.subscribe_collect = @"N";
                break;
            case FavoritesType_Wish:
                self.goodsDetailInfo.subscribe_wish = @"N";
                break;
            case FavoritesType_Remind:
                self.goodsDetailInfo.subscribe_arrival = @"N";
                break;
        }
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}

-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlayer) name:kCartInfoUpdateNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fechClusterInGoodDetail) name:KClusterDidPaySuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableViewInFour) name:ESClusterTimeZero object:nil];
    
}
-(void)reloadTableViewInFour{
    
    [self fetchGoodsDetail];
}
-(void)stopPlayer{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        //sleep(1);
        
        //[self.player pause];
    });
    
    
}
#pragma mark 加入购物车
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
- (void)addCart
{
    
    if (self.goodsDetailInfo.stock.intValue==0) {
        TipViewAnimation*view=[[TipViewAnimation alloc]initWithFrame:self.view.bounds andTip:@"库存不足"];
        [view show];
        return;
    }
    self.secondDate=[NSDate date];
    NSTimeInterval time=[self.secondDate timeIntervalSinceDate:self.firstDate];
    if (self.flag==1) {
        [self addtocart];
    }else{
        if (time>=2) {
            self.moveImageView.hidden=NO;
            [self addtocart];
        }else{
            [UIView animateWithDuration:1.5 animations:^{
                [self.view addSubview:self.tipsLabel];
                self.tipsLabel.alpha=1;
            } completion:^(BOOL finished) {
                [self.tipsLabel removeFromSuperview];
                self.tipsLabel.alpha=1;
            }];
        }
    }
    
    
    
}
-(void)addtocart{
    
    AddCartGoodsRequest *request = [AddCartGoodsRequest request];
    request.goods_id = self.goods_id;
    request.n   = @1;
    [kKeyWindow addSubview:self.moveImageView];
    [self.moveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.width.equalTo(@40);
        make.right.equalTo(@(-90));
        make.top.equalTo(@160);
    }];
    NSString*string=[[NSBundle mainBundle]pathForResource:@"6124" ofType:@"mp3"];
    NSURL*fileUrl=[NSURL fileURLWithPath:string];
    AVPlayerItem*item=[AVPlayerItem playerItemWithURL:fileUrl];
    self.player=[[AVPlayer alloc]initWithPlayerItem:item];
    [self.player play];
    CAKeyframeAnimation*pathAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath*path=[UIBezierPath bezierPath];
    path.lineWidth=0.9;
    path.lineCapStyle=kCGLineCapRound;
    path.lineJoinStyle=kCGLineCapRound;
    [path moveToPoint:CGPointMake((ScreenWidth-105) , 175)];
    CGFloat h=ScreenHeight-60;
    [path addQuadCurveToPoint:CGPointMake(75,h) controlPoint:CGPointMake(80, 0)];
    pathAnimation.path=path.CGPath;
    
    pathAnimation.duration=1;
    //animation.delegate=self;
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    // fromValue：开始值    toValue：结束值
    
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]; //设置 X 轴和 Y 轴缩放比例都为1.0，而 Z 轴不变
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.3;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[ pathAnimation, transformAnimation, rotationAnimation];
    animationGroup.duration = 1.5; //设置动画执行时间；这里设置为1.0秒
    [self .moveImageView.layer addAnimation:animationGroup forKey:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        sleep(1);
        [self.moveImageView removeFromSuperview];
    });
    @weakify(self);
    [ESService addCartGoodsRequest:request success:^{
        @strongify(self);
        [self endGSNetworking];
        [ESToast showSuccess:@"加入购物车成功！"];
        NSString*flagStr=@"yes";
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kCartInfoUpdateNotification object:flagStr];
            
        });
        self.firstDate=[NSDate date];
        self.flag++;
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
    
    
}
#pragma mark 请求商品信息
/**
 *  请求商品详情
 */
- (void)fetchGoodsDetail
{
    GetGoodsDetailRequest *request = [GetGoodsDetailRequest request];
    request.goods_id = self.goods_id;
    @weakify(self);
    [self.indicator startAnimation];
    [ESService getGoodsDetailRequest:request success:^(GoodsDetailInfo *response) {
        @strongify(self);
        [self endGSNetworking];
        self.goodsDetailInfo = response;
         [self.webview loadHTMLString:self.goodsDetailInfo.body baseURL:nil];
        self.select=self.goodsDetailInfo.isCollect;
        [self.moveImageView sd_setImageWithURL:[NSURL URLWithString:self.goodsDetailInfo.image]];
        if (self.clusterArray.count!=0) {
            [self.clusterArray removeAllObjects];
        }
        [self.tableView reloadData];
        self.bottonView.goodsDetail=self.goodsDetailInfo;
        if ([response.cluster intValue]!=0) {
            [self fechClusterInGoodDetail];
        }
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
    
}
-(void)fechClusterInGoodDetail{
    ClusterRequest*request=[ClusterRequest request];
    request.goods_id=self.goods_id;
    request.page=@1;
    request.n=@10;
    [ESService getClusterRequest:request success:^(NSArray *response) {
        self.clusterArray=[NSMutableArray arrayWithArray:response];
        if (response.count!=0) {
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
/** 请求商品评价 */
- (void)fetchGoodsEvaluation
{
    GetGoodsEvaluationRequest *request = [GetGoodsEvaluationRequest request];
    request.goods_id = self.goods_id;
    request.page = @1;
    request.n   = @3;
    
    @weakify(self);
    [ESService getGoodsEvaluationRequest:request success:^(NSArray *response) {
        @strongify(self);
        
        NSMutableArray *mArr = [NSMutableArray array];
        for (GoodsEvaluationInfo *info in response) {
            [mArr addObject:[GoodEvaluationItem itemWithInfo:info]];
        }
        self.evaluationItems = [mArr copy];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

/** 获取推荐商品 */
- (void)fetchRelatedGoods
{
    GetRelatedGoodsRequest *request = [GetRelatedGoodsRequest request];
    request.goods_id = self.goods_id;
    request.n        = @5;
    
    @weakify(self);
    [ESService getRelatedGoodsRequest:request success:^(NSArray *response) {
        @strongify(self);
        
        self.relatedItems = response;
        [self.tableView reloadData];
        self.webView.body = self.goodsDetailInfo.body;
        
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma webview
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //[self.webview.scrollView.mj_header endRefreshing];
}

#pragma mark GSNetworking
- (void)endGSNetworking
{
    NSLog(@"%@",kUserManager.nowDate);
    
    [self.indicator stopAnimation];
    [self.tableView.mj_header endRefreshing];
}

@end