//
//  ESBannerScrollview.m
//  EasyShop
//
//  Created by wcz on 16/3/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESBannerScrollview.h"
#import "ESImageCollectionViewCell.h"

@interface ESBannerScrollview ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) UIPageControl *pageController;
@property (nonatomic ,strong) UIView*lineView;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic, strong) NSTimer *timer;

@end
@implementation ESBannerScrollview

- (void)setNavInfo:(NavInfo *)navInfo
{
    _navInfo = navInfo;
    self.pageController.numberOfPages = _navInfo.m_banner.count;
    [self.collectionview reloadData];
    if(_navInfo.m_banner.count >1)
    {
        self.pageController.hidden = NO;
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 5*NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [self.timer setFireDate:[NSDate distantPast]];
        });
    }else
    {
        self.pageController.hidden = YES;
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

-(UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel =[[UILabel alloc]init];
        _titleLabel.font=[UIFont systemFontOfSize:14];
        _titleLabel.textColor=AllTextColor;
        
        _titleLabel.text=@"就手国际";
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        
    }
    return _titleLabel;
    
}
- (UIPageControl *)pageController
{
    if (_pageController == nil) {
        _pageController = [[UIPageControl alloc] init];
        _pageController.numberOfPages = 0;
        _pageController.currentPage = 0;
        _pageController.pageIndicatorTintColor = [UIColor whiteColor];
        _pageController.currentPageIndicatorTintColor = [UIColor blackColor];
    }
    return _pageController;
}

- (NSTimer *)timer
{
    if (_timer == nil)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(actionToBePerform) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)actionToBePerform
{
    NSInteger index = self.collectionview.contentOffset.x / ScreenWidth;
    if (index == self.navInfo.m_banner.count - 1)
    {
        index = 0;
        [self.collectionview setContentOffset:CGPointMake(index *ScreenWidth, 0) animated:NO];
        self.pageController.currentPage = 0;
    } else
    {
        index = index + 1;
        [self.collectionview setContentOffset:CGPointMake(index *ScreenWidth, 0) animated:YES];
        
    }
}

- (UICollectionView *)collectionview
{
    if (_collectionview == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionview.dataSource = self;
        _collectionview.pagingEnabled = YES;
        _collectionview.showsVerticalScrollIndicator = NO;
        _collectionview.showsHorizontalScrollIndicator = NO;
        _collectionview.delegate = self;
        [_collectionview registerClass:[ESImageCollectionViewCell class] forCellWithReuseIdentifier:@"ESImageCollectionViewCell"];
        _collectionview.backgroundColor = [UIColor whiteColor];
    }
    return _collectionview;
}
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        _lineView.backgroundColor=RGB(247, 247, 247);
        _lineView.alpha=1;
        
    }
    return _lineView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        [self addSubview:self.collectionview];
        [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@0);
            make.height.equalTo(@(ScreenWidth*408/617));
        }];
//        [self addSubview:self.titleLabel];
//        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.collectionview.mas_bottom).offset(0);
//            make.right.left.equalTo(@0);
//            make.height.equalTo(@49);
//        }];
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collectionview.mas_bottom).offset(0);
            make.right.left.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
        [self addSubview:self.pageController];
        [self.pageController mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.bottom.equalTo(@(-59));
            make.height.equalTo(@10);
        }];   
    }
    return self;
}



#pragma mark - collectionview 代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.navInfo.m_banner.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth, ScreenWidth*408/617.0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESImageCollectionViewCell" forIndexPath:indexPath];
    cell.isHome=YES;
    BannerInfo *info = [self.navInfo.m_banner objectAtIndex:indexPath.item];
    cell.imageUrl = info.banner;
    return cell;
}

#pragma mark - 换页

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger numberPage = scrollView.contentOffset.x / ScreenWidth;
    self.pageController.currentPage = numberPage;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger numberPage = scrollView.contentOffset.x / ScreenWidth;
    self.pageController.currentPage = numberPage;
}

@end