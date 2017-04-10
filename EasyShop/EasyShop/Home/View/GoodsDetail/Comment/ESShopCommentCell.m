//
//  ESShopCommentCell.m
//  EasyShop
//
//  Created by wcz on 16/6/5.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShopCommentCell.h"
#import "ESImageCollectionViewCell.h"
#import "GSTimeTool.h"
#import "ImagesSkimView.h"
#import "MWPhotoBrowser.h"
#import "MWCommon.h"
#import "DZPhotoBrowser.h"
@interface ESShopCommentCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MWPhotoBrowserDelegate,DZPhotoBrowserDelegate>

@property (nonatomic, strong) UILabel *userMobile;//用户
@property (nonatomic, strong) UILabel *timeLable;//评价时间
@property (nonatomic, strong) UILabel *commentLabel;//评价内容
@property (nonatomic, strong) UILabel *lineLabel;//分割线
@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic,strong) NSMutableArray*thumbs;
@property (nonatomic,strong) NSMutableArray*imageArray;

@end



@implementation ESShopCommentCell

- (void)setItem:(GoodEvaluationItem *)item
{
    _imageArray=[[NSMutableArray alloc]initWithArray:item.evaluationInfo.image];
    _item = item;
    self.lineLabel.frame=_item.lineFrame;
    self.userMobile.frame = _item.nameFrame;
    self.timeLable.frame = _item.timeFrame;
    self.commentLabel.frame = _item.contentFrame;
    self.collectionview.frame = _item.imageFrame;
    if (_item.evaluationInfo.member_name.length<12) {
        self.userMobile.text=_item.evaluationInfo.member_name;
        
    }else{
         self.userMobile.text=[_item.evaluationInfo.member_name stringByReplacingCharactersInRange:NSMakeRange(4, 4) withString:@"****"];
    }
    self.timeLable.text = [GSTimeTool formatterNumber:_item.evaluationInfo.create_time toType:GSTimeType_YYMMddHHmm];
    self.commentLabel.text = _item.evaluationInfo.content;
}
-(void)setIsShowLine:(BOOL)isShowLine{
    self.lineLabel.hidden=isShowLine;
}
- (UICollectionView *)collectionview
{
    if (_collectionview == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing =3;
        flowLayout.minimumLineSpacing = 3;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //             flowLayout.itemSize = CGSizeMake(ScreenWidth, 125);
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

#pragma mark
#pragma mark Init & Add
- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = KCommontLineViewBagroudColor;
    }
    return _lineLabel;
}
- (UILabel *)userMobile {
    if (!_userMobile) {
        _userMobile = [[UILabel alloc] init];
        _userMobile.font = ADeanFONT14;
        _userMobile.textAlignment = NSTextAlignmentLeft;
        _userMobile.textColor = AllTextColor;
    }
    return _userMobile;
}
- (UILabel *)timeLable {
    if (!_timeLable) {
        _timeLable = [[UILabel alloc] init];
        _timeLable.font = ADeanFONT14;
        _timeLable.textAlignment = NSTextAlignmentRight;
        _timeLable.textColor = AllTextColor;
    }
    return _timeLable;
}
- (UILabel *)commentLabel {
    
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.numberOfLines = 0;
        _commentLabel.font = ADeanFONT14;
        _commentLabel.textColor = AllTextColor;
    }
    return _commentLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        

        [self.contentView addSubview:self.userMobile];
        
        [self.contentView addSubview:self.timeLable];

        
        [self.contentView addSubview:self.commentLabel];
        
        [self.contentView addSubview:self.collectionview];
        [self.contentView addSubview:self.lineLabel];
    }
    return self;
}


-(void)intalizedView
{
    [self.contentView addSubview:self.userMobile];
    [self.userMobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18));
        make.top.equalTo(@(6.5));
        make.width.equalTo(@130);
        make.height.equalTo(@20);
    }];
    
    [self.contentView addSubview:self.timeLable];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18));
        make.top.equalTo(@(6.5));
        make.width.equalTo(@120);
        make.height.equalTo(@20);
    }];
    
    
    [self.contentView addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.top.equalTo(self.timeLable.mas_bottom).offset(2);
        make.left.equalTo(@(15));
    }];
    
    [self.contentView addSubview:self.collectionview];
    [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commentLabel.mas_bottom).offset(5);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@(-10));
    }];
    [self.contentView addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.bottom.equalTo(@(-0.5));
        make.height.equalTo(@0.5);
    }];
    

    
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESImageCollectionViewCell" forIndexPath:indexPath];
    cell.imageUrl = [self.imageArray objectAtIndex:indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat imageWH = self.item.imageFrame.size.height;
    return CGSizeMake(imageWH, imageWH);
}

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 3, 0, 3);
//}
//
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // [self createNWPhoto:indexPath];
    
    DZPhotoBrowser  *photoBorwser = [[DZPhotoBrowser alloc] initWithFrame:[UIScreen mainScreen].bounds];
    photoBorwser.delegate = self;
    photoBorwser.currentPage = indexPath.item;
    NSMutableArray*array=[[NSMutableArray alloc]init];
    for (NSString*str in self.imageArray ) {
        UIImage*image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
        [array addObject:image];
        
    }
    photoBorwser.imageArray=array;
    photoBorwser.isShowDeleButton=YES;
    [photoBorwser show:YES];

}
-(NSMutableArray *)photos{
    if (_photos==nil) {
        _photos=[[NSMutableArray alloc]init];
    }
    return _photos;
}
//-(void)createNWPhoto:(NSIndexPath*)index{
//    NSMutableArray *photos = [[NSMutableArray alloc] init];
//    NSMutableArray *thumbs = [[NSMutableArray alloc] init];
//    //MWPhoto *photo;
//    for (NSString*str in self.item.evaluationInfo.image ) {
//         [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:str]]];
//        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:str]]];
//    }
//    self.thumbs=thumbs;
//    self.photos=photos;
//   // BOOL displayActionButton = YES;
//    BOOL displaySelectionButtons = NO;
//   // BOOL displayNavArrows = NO;
//    BOOL enableGrid = YES;
//    //BOOL startOnGrid = NO;
//    BOOL autoPlayOnAppear = NO;
//    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
//    browser.displayActionButton = NO;//分享按钮 默认是显示
//    browser.displayNavArrows = YES;//显示的是左右切换的箭头
//    browser.displaySelectionButtons = displaySelectionButtons;
//    browser.alwaysShowControls = NO;//设置是否一直显示导航栏
//    browser.zoomPhotosToFill = YES;
//    browser.enableGrid = enableGrid;
//    browser.startOnGrid = NO;
//    browser.enableSwipeToDismiss = NO;//这个是控制滑动的时候可以隐藏导航条
//    browser.autoPlayOnAppear = autoPlayOnAppear;//自动播放第一个视频
//    [browser setCurrentPhotoIndex:index.item];
//    [[AppDelegate shared]pushViewController:browser animated:YES];
//}
#pragma mark - MWPhotoBrowserDelegate
//这里是返回图片的个数
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.item.evaluationInfo.image.count;
}
//通过下标获取图片
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}
@end
