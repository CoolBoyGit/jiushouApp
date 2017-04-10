//
//  ESProductImageViewCell.m
//  EasyShop
//
//  Created by wcz on 16/3/31.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESProductImageViewCell.h"
#import "ESImageCollectionViewCell.h"
#import "DYQBannerScrollView.h"
#import "SDAutoLayout.h"
@interface ESProductImageViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DYQBannerScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) UIPageControl *pageController;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,strong) DYQBannerScrollView*detailScroll;
@end
@implementation ESProductImageViewCell
-(DYQBannerScrollView *)detailScroll{
    if (_detailScroll==nil) {
        _detailScroll=[[DYQBannerScrollView alloc]init];
        _detailScroll.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).heightIs(ScreenWidth);
        _detailScroll.timeInterval=10;
        _detailScroll.delegate=self;
        _detailScroll.pageControlPosition=PageControlPositionCenter;
    }
    return _detailScroll;
}
- (void)setImageItems:(NSMutableArray *)imageItems
{
    _imageItems = imageItems;
    self.detailScroll.imageUrls=imageItems;

    if (_imageItems.count==0) {
        
    }
//    else{
//        HHBannerView *bannerView = [[HHBannerView alloc] initWithFrame:self.contentView.bounds WithBannerSource:NinaBannerStyleOnlyWebSource WithBannerArray:_imageItems];
//        
//        bannerView.timeInterval = 3;
//        if (_imageItems.count>1) {
//            bannerView.showPageControl = YES;
//        }
//        else{
//            bannerView.showPageControl = NO;
//        }
//        bannerView.delegate = self;
//        [self.contentView addSubview:bannerView];
//        [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(@0);
//        }];
//    }
//   
//
//    self.pageController.numberOfPages = _imageItems.count-2;
//     _collectionview.contentOffset=CGPointMake(ScreenWidth, 0);
//    [self.collectionview reloadData];
//    
//    if(_imageItems.count >1)
//    {
//        self.pageController.hidden = NO;
////        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 5*NSEC_PER_SEC);
////        dispatch_after(time, dispatch_get_main_queue(), ^{
////            [self.timer setFireDate:[NSDate distantPast]];
////        });
//    }else
//    {
//        self.pageController.hidden = YES;
//        //[self.timer setFireDate:[NSDate distantFuture]];
//    }

}

- (UIPageControl *)pageController
{
    if (_pageController == nil) {
        _pageController = [[UIPageControl alloc] init];
        _pageController.numberOfPages = 0;
        _pageController.currentPage = 0;
        _pageController.pageIndicatorTintColor = [UIColor blackColor];
        _pageController.currentPageIndicatorTintColor = [UIColor grayColor];
    }
    return _pageController;
}

- (UICollectionView *)collectionview
{
    if (_collectionview == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //        flowLayout.itemSize = CGSizeMake(ScreenWidth, 125);
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionview.pagingEnabled = YES;
        _collectionview.dataSource = self;
        _collectionview.showsVerticalScrollIndicator = NO;
        _collectionview.showsHorizontalScrollIndicator = NO;
        _collectionview.delegate = self;
        
        [_collectionview registerClass:[ESImageCollectionViewCell class] forCellWithReuseIdentifier:@"ESImageCollectionViewCell"];
        _collectionview.backgroundColor = [UIColor whiteColor];
    }
    return _collectionview;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView addSubview:self.detailScroll];
        [self.detailScroll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return self;
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
    if (index == self.imageItems.count - 1)
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


#pragma mark - collectionview 代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageItems.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth, ScreenWidth);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESImageCollectionViewCell" forIndexPath:indexPath];
    //    cell.model = self.model.doctorArray[indexPath.row];
    ESImageInfo *info = [self.imageItems objectAtIndex:indexPath.item];
    cell.imageUrl = info.image;
    return cell;
}

//#pragma mark - 换页
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.x==(_imageItems.count-1)*ScreenWidth) {
//        [scrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:NO];
//        
//    } else if(scrollView.contentOffset.x==0 ){
//        [scrollView setContentOffset:CGPointMake(ScreenWidth*(_imageItems.count-2), 0) animated:NO];
//    }
//    NSInteger numberPage = (scrollView.contentOffset.x -ScreenWidth)/ ScreenWidth;
//    self.pageController.currentPage = numberPage;
//}
//
//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    NSInteger numberPage = scrollView.contentOffset.x / ScreenWidth;
//    self.pageController.currentPage = numberPage;
//}
//
@end
