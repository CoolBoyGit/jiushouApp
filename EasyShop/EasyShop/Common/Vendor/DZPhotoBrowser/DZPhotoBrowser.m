//
//  DZPhotoBrowser.m
//  EasyShop
//
//  Created by 就手国际 on 16/12/5.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "DZPhotoBrowser.h"
#import "DZPhotoBrowserColleCell.h"
#import "JKPhotoBrowserCell.h"
#import "UIView+JKPicker.h"
#import "JKUtil.h"
#import "JKPromptView.h"
#import "ESImageModel.h"
static NSString *DZKPhotoBrowserCellIdentifier = @"DZKPhotoBrowserCellIdentifier";
@interface DZPhotoBrowser() <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView   *topView;

@property (nonatomic, strong) UILabel  *numberLabel;
@property (nonatomic, strong) UIButton    *checkButton;
@property (nonatomic,assign) NSInteger*integer;

@end

@implementation DZPhotoBrowser

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [JKUtil getColor:@"282828"];
        //self.autoresizesSubviews = YES;
        [self collectionView];
        [self topView];
        [self addNoti];
    }
    return self;
}
-(void)addNoti{
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delect:) name:DeleItemInthePostCommet object:nil];
}
-(void)delect:(NSNotification*)noti{
    NSString*str=noti.userInfo[@"index"];
    [self.imageArray removeObjectAtIndex:[str integerValue]];
    NSIndexPath*indexPa=[NSIndexPath indexPathForItem:[str integerValue] inSection:0];
    if ([self.collectionView numberOfItemsInSection:0]==self.imageArray.count) {
        [self.collectionView reloadData];
    }else{
         [self.collectionView deleteItemsAtIndexPaths:@[indexPa]];
    }
   
    
}
#pragma mark - setter
- (void)setAssetsArray:(NSMutableArray *)assetsArray{
    if (_assetsArray != assetsArray) {
        _assetsArray = assetsArray;
        
        [self reloadPhotoeData];
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)closePhotoBrower
{
    [self hide:YES];
}


- (void)photoDidChecked
{

        if ([_delegate respondsToSelector:@selector(photoBrowser:didSelectAtIndex:)]) {
            [_delegate photoBrowser:self didSelectAtIndex:self.currentPage];
       
    }
    
    
}

- (void)show:(BOOL)animated
{
    if (animated){
        self.top = [UIScreen mainScreen].bounds.size.height;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.top = 0;
                         }
                         completion:^(BOOL finished) {
                         }];
        
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
}

- (void)hide:(BOOL)animated
{
    if (animated){
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.top = [UIScreen mainScreen].bounds.size.height;
                         }
                         completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
    }
    else{
        [self removeFromSuperview];
    }
    
}
-(void)setIsShowDeleButton:(BOOL)isShowDeleButton{
    self.checkButton.hidden=isShowDeleButton;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //return [self.assetsArray count];
    return [self.imageArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DZPhotoBrowserColleCell *cell = (DZPhotoBrowserColleCell *)[collectionView dequeueReusableCellWithReuseIdentifier:DZKPhotoBrowserCellIdentifier forIndexPath:indexPath];
    cell.image=[self.imageArray objectAtIndex:indexPath.row];
    return cell;
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.bounds.size.width+20, self.bounds.size.height);
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    self.currentPage=indexPath.item;
    [self updateStatus];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    float itemWidth = CGRectGetWidth(self.collectionView.frame);
    if (offsetX >= 0){
        int page = offsetX / itemWidth;
        [self didScrollToPage:page];
    }
}

- (void)didScrollToPage:(int)page
{
    _currentPage = page;
    [self updateStatus];
}

- (BOOL)assetIsSelected:(NSURL *)assetURL
{
//    for (JKAssets *asset in self.pickerController.selectedAssetArray) {
//        if ([assetURL isEqual:asset.assetPropertyURL]) {
//            return YES;
//        }
//    }
   return NO;
}


- (void)reloadPhotoeData
{
    [self.collectionView setContentOffset:CGPointMake(_currentPage*CGRectGetWidth(self.collectionView.frame), 0) animated:NO];
    [self updateStatus];
    [self.collectionView reloadData];
}


- (void)updateStatus
{
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/%lu",(long)(_currentPage+1),(unsigned long)[self.imageArray count]];
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/%lu",(long)(_currentPage+1),(unsigned long)[self.imageArray count]];
    
    ALAsset  *asset = [self.assetsArray objectAtIndex:_currentPage];
    NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
    self.checkButton.selected = [self assetIsSelected:assetURL];
}
-(void)setImageArray:(NSMutableArray *)imageArray{
    
        _imageArray=imageArray;
        [self reloadPhotoeData];
    
}
#pragma mark - getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-10, 0, self.bounds.size.width+20, self.bounds.size.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[DZPhotoBrowserColleCell class] forCellWithReuseIdentifier:DZKPhotoBrowserCellIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [self addSubview:_collectionView];
        
    }
    return _collectionView;
}

- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(floor((CGRectGetWidth(self.frame)-100)/2), 32, 100, 20)];
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.font = [UIFont systemFontOfSize:17.0f];
        _numberLabel.text = @"0/0";
    }
    return _numberLabel;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 64)];
        _topView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        [_topView addSubview:self.numberLabel];
        
        UIImage  *img = [UIImage imageNamed:@"camera_edit_cut_cancel"];
        UIImage  *imgHigh = [UIImage imageNamed:@"camera_edit_cut_cancel_highlighted"];
        UIButton  *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 20+floor((44-img.size.height)/2), 25, 25);
        [button setBackgroundImage:img forState:UIControlStateNormal];
        [button setBackgroundImage:imgHigh forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(closePhotoBrower) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:button];
        
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage  *img1 = [UIImage imageNamed:@"commet_deleButton"];
        UIImage  *imgH = [UIImage imageNamed:@"commet_deleButton"];
        _checkButton.frame = CGRectMake(0, 0, img1.size.width, img1.size.height);
        [_checkButton setBackgroundImage:img1 forState:UIControlStateNormal];
        [_checkButton setBackgroundImage:imgH forState:UIControlStateSelected];
        [_checkButton addTarget:self action:@selector(photoDidChecked) forControlEvents:UIControlEventTouchUpInside];
        _checkButton.hidden=YES;
        //exclusiveTouch的意思是UIView会独占整个Touch事件，具体的来说，就是当设置了exclusiveTouch的 UIView是事件的第一响应者，那么到你的所有手指离开前，其他的视图UIview是不会响应任何触摸事件的，对于多点触摸事件，这个属性就非常重要，值得注意的是：手势识别（GestureRecognizers）会忽略此属性。
        //列举用途：我们知道ios是没有GridView视图的，通常做法是在UITableView的cell上加载几个子视图，来模拟实现 GridView视图，但对于每一个子视图来说，就需要使用exclusiveTouch，否则当同时点击多个子视图，那么会触发每个子视图的事件。当然 还有我们常说的模态对话框。
        _checkButton.exclusiveTouch = YES;
        _checkButton.right = self.width-10;
        _checkButton.centerY = button.centerY;
        [_topView addSubview:_checkButton];
        
        [self addSubview:_topView];
    }
    return _topView;
}



@end
