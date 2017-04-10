//
//  ESPhotoBrowserController.m
//  EasyShop
//
//  Created by wcz on 16/5/15.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESPhotoBrowserController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ESProcessCollectionViewCell.h"
#import "ESFiltersView.h"
#import "EXTScope.h"

@interface ESPhotoBrowserController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView    *imageView;
@property (nonatomic, strong) NSMutableArray *imageTypeArr;//滤镜数组
@property (nonatomic, assign) int            selectIndex;
@property (nonatomic, strong) UIImage        *originImage;
@property (nonatomic, strong) ESFiltersView   *bottomView;

@end

@implementation ESPhotoBrowserController

- (ESFiltersView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[ESFiltersView alloc]init];
    }
    return _bottomView;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
-(NSMutableArray *)imageTypeArr
{
    if (!_imageTypeArr) {
        _imageTypeArr = [[NSMutableArray alloc] initWithObjects:
                       @"Origin",
                       @"CIPhotoEffectMono",
                       @"CIPhotoEffectChrome",
                       @"CIPhotoEffectFade",
                       @"CIPhotoEffectInstant",
                       @"CIPhotoEffectNoir",
                       @"CIPhotoEffectProcess",
                       @"CIPhotoEffectTonal",
                       @"CIPhotoEffectTransfer",
                       @"CISRGBToneCurveToLinear",
                       nil];
    }
    return _imageTypeArr;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor lightGrayColor];
    self.selectIndex = 0;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 4, 54, 44);
    [backButton setImage:[UIImage imageNamed:@"navibar_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(navibarBackAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIButton *nextStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextStepButton.frame = CGRectMake(0, 4, 54, 44);
    [nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    nextStepButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [nextStepButton addTarget:self action:@selector(navibarNextStepAction) forControlEvents:UIControlEventTouchUpInside];
//    [navibarView addSubview:nextStepButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nextStepButton];

    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
    flowLayout.itemSize = CGSizeMake(42, 42);
    flowLayout.minimumInteritemSpacing = 8;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 2, ScreenWidth - 110, 44) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[ESProcessCollectionViewCell class] forCellWithReuseIdentifier:@"ESProcessCollectionViewCell"];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.alwaysBounceHorizontal = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    self.navigationItem.titleView = collectionView;
    
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    ALAsset *asset = self.dataArray[0];
    self.originImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
    self.imageView.image = self.originImage;
    @weakify(self);
    [self.bottomView setCallBack:^(NSInteger index) {
        @strongify(self);
        [self fliterEvent:index];
    }];
    self.bottomView.image = self.originImage;
    [self.view addSubview:self.bottomView];
    self.bottomView.imageArray = self.imageTypeArr;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(@0);
        make.height.equalTo(@90);
    }];
}

#pragma mark 滤镜处理事件
- (void)fliterEvent:(NSInteger )index;
{
    NSString *filterName = self.imageTypeArr[index];
    if ([filterName isEqualToString:@"Origin"]) {
        self.imageView.image = self.originImage;
    }else{
        CIImage *ciImage = [[CIImage alloc] initWithImage:self.imageView.image];
        CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciImage, nil];
        [filter setDefaults];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
        UIImage *image = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        self.imageView.image = image;
        [self.dataArray replaceObjectAtIndex:self.selectIndex withObject:image];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ESProcessCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESProcessCollectionViewCell" forIndexPath:indexPath];
    cell.asset = self.dataArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = self.dataArray[indexPath.row];
    self.imageView.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
    self.selectIndex = (int)indexPath.row;
}

- (void)navibarBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)navibarNextStepAction
{
    [self dismissViewControllerAnimated:NO completion:^{
        if (self.callBack) {
            self.callBack(self.dataArray);
        }
    }]; 
}


@end
