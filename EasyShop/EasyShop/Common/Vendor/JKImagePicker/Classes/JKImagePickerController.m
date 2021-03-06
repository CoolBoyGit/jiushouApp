//
//  JKImagePickerController.m
//  JKImagePicker
//
//  Created by Jecky on 15/1/9.
//  Copyright (c) 2015年 Jecky. All rights reserved.
//

#import "JKImagePickerController.h"
#import "JKUtil.h"
#import "JKAssetsGroupsView.h"
#import "UIView+JKPicker.h"
#import "JKAssetsViewCell.h"
#import "JKAssetsCollectionFooterView.h"
#import "JKPromptView.h"
#import "JKPhotoBrowser.h"
#import "PhotoAlbumManager.h"

ALAssetsFilter * ALAssetsFilterFromJKImagePickerControllerFilterType(JKImagePickerControllerFilterType type) {
    switch (type) {
        case JKImagePickerControllerFilterTypeNone:
            return [ALAssetsFilter allAssets];
            break;
            
        case JKImagePickerControllerFilterTypePhotos:
            return [ALAssetsFilter allPhotos];
            break;
            
        case JKImagePickerControllerFilterTypeVideos:
            return [ALAssetsFilter allVideos];
            break;
    }
}


@interface JKImagePickerController ()<JKAssetsGroupsViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,JKAssetsViewCellDelegate,JKPhotoBrowserDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) ALAssetsLibrary     *assetsLibrary;
@property (nonatomic, strong) NSArray *groupTypes;

@property (nonatomic, assign) BOOL showsAssetsGroupSelection;

@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UIButton     *titleButton;
@property (nonatomic, strong) UIButton     *arrowImageView;

@property (nonatomic, strong) UIButton              *touchButton;
@property (nonatomic, strong) UIView                *overlayView;
@property (nonatomic, strong) JKAssetsGroupsView    *assetsGroupsView;


@property (nonatomic, strong) ALAssetsGroup *selectAssetsGroup;
@property (nonatomic, strong) NSMutableArray *assetsArray;
@property (nonatomic, assign) NSUInteger numberOfAssets;
@property (nonatomic, assign) NSUInteger numberOfPhotos;
@property (nonatomic, assign) NSUInteger numberOfVideos;

@property (nonatomic, strong) UIToolbar     *toolbar;
@property (nonatomic, strong) UIButton      *selectButton;
@property (nonatomic, strong) UIButton      *finishButton;
@property (nonatomic, strong) UILabel       *finishLabel;

@property (nonatomic, strong) UICollectionView   *collectionView;

@end

@implementation JKImagePickerController

- (id)init
{
    self = [super init];
    if (self) {
        self.filterType = JKImagePickerControllerFilterTypeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpProperties];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self collectionView];
    [self toolbar];
    [self loadAssetsGroups];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)setUpProperties
{
    self.groupTypes = @[@(ALAssetsGroupLibrary),
                        @(ALAssetsGroupSavedPhotos),
                        @(ALAssetsGroupPhotoStream),
                        @(ALAssetsGroupAlbum)];
    
    self.navigationItem.titleView = self.titleButton;
    
    UIButton *preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    preBtn.frame = CGRectMake(0, 0, 50, 30);
    [preBtn setTitle:@"预览" forState:UIControlStateNormal];
    [preBtn setTitleColor:RGB(233, 40, 46) forState:UIControlStateNormal];
    [preBtn setTitleColor:[JKUtil getColor:@"828689"] forState:UIControlStateHighlighted];
    [preBtn setTitleColor:[JKUtil getColor:@"828689"] forState:UIControlStateDisabled];
    [preBtn addTarget:self action:@selector(previewPhotoesSelected) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *preItem = [[UIBarButtonItem alloc] initWithCustomView:preBtn];
    [self.navigationItem setRightBarButtonItem:preItem animated:NO];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
//点击了取消按钮
- (void)cancelEventDidTouched
{
    if ([_delegate respondsToSelector:@selector(imagePickerControllerDidCancel:)]) {
        [_delegate imagePickerControllerDidCancel:self];
    }
}

- (void)assetsGroupDidSelected
{
    self.showsAssetsGroupSelection = YES;
    
    if (self.showsAssetsGroupSelection) {
        [self showAssetsGroupView];
    }
}

- (void)selectOriginImage
{
    _selectButton.selected = !_selectButton.selected;
    
}

- (void)assetsGroupsDidDeselected
{
    self.showsAssetsGroupSelection = NO;
    [self hideAssetsGroupView];
}

- (void)showAssetsGroupView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.touchButton];
    
    self.overlayView.alpha = 0.0f;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.assetsGroupsView.top = 0;
                         self.overlayView.alpha = 0.85f;
                     }completion:^(BOOL finished) {
                         
                     }];
}

- (void)hideAssetsGroupView
{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.assetsGroupsView.top = -self.assetsGroupsView.height;
                         self.overlayView.alpha = 0.0f;
                     }completion:^(BOOL finished) {
                         [_touchButton removeFromSuperview];
                         _touchButton = nil;
                         
                         [_overlayView removeFromSuperview];
                         _overlayView = nil;
                     }];
    
}
#  pragma mark 点击了预览的按扭
- (void)previewPhotoesSelected
{
    [self passSelectedAssets];
}
#pragma mark 创建图片浏览选择器
- (void)browerPhotoes:(NSArray *)array page:(NSInteger)page
{
    JKPhotoBrowser  *photoBorwser = [[JKPhotoBrowser alloc] initWithFrame:[UIScreen mainScreen].bounds];
    photoBorwser.delegate = self;
    photoBorwser.pickerController = self;
    photoBorwser.currentPage = page;
    photoBorwser.assetsArray = [NSMutableArray arrayWithArray:array];
    [photoBorwser show:YES];
}

#pragma mark - Managing Assets
- (void)passSelectedAssets
{
    // Load assets from URLs
    __block NSMutableArray *assets = [NSMutableArray array];
    
    for (JKAssets *jka in self.selectedAssetArray) {
        __weak typeof(self) weakSelf = self;
        [self.assetsLibrary assetForURL:jka.assetPropertyURL
                            resultBlock:^(ALAsset *asset) {
                                // Add asset
                                [assets addObject:asset];
                                // Check if the loading finished
                                if (assets.count == weakSelf.selectedAssetArray.count) {
                                    [weakSelf browerPhotoes:assets page:0];
                                }
                            } failureBlock:^(NSError *error) {
                                
                            }];
    }
}

#pragma mark  获取所有的相册的数量
- (void)loadAssetsGroups
{
    // Load assets groups
    __weak typeof(self) weakSelf = self;
    [self loadAssetsGroupsWithTypes:self.groupTypes
                         completion:^(NSArray *assetsGroups) {
                             if ([assetsGroups count]>0) {
                                 weakSelf.titleButton.enabled = YES;
                                 //在这里的作用就是把当前的显示的相册展示为当前的相册对象
                                 weakSelf.selectAssetsGroup = [assetsGroups objectAtIndex:0];
                                 //
                                 
                                 
                                 weakSelf.assetsGroupsView.assetsGroups = assetsGroups;
                                 
                                 NSMutableDictionary  *dic = [NSMutableDictionary dictionaryWithCapacity:0];
                                 for (JKAssets  *asset in weakSelf.selectedAssetArray) {
                                     if (asset.groupPropertyID) {
                                         NSInteger  count = [[dic objectForKey:asset.groupPropertyID] integerValue];
                                         [dic setObject:[NSNumber numberWithInteger:count+1] forKey:asset.groupPropertyID];
                                     }
                                 }
                                 weakSelf.assetsGroupsView.selectedAssetCount = dic;
                                 [weakSelf resetFinishFrame];
                                 
                             }else{
                                 weakSelf.titleButton.enabled = NO;
                             }
                         }];
    
    // Validation
}
#pragma mark 作用是每次进入不同的相册的时候，让nav上面的按钮展示出不同的相册的文字
//这个方法是每次进入不同的相册的时候调用的
- (void)setSelectAssetsGroup:(ALAssetsGroup *)selectAssetsGroup{
    if (_selectAssetsGroup != selectAssetsGroup) {
        _selectAssetsGroup = selectAssetsGroup;
        
        NSString  *assetsName = [selectAssetsGroup valueForProperty:ALAssetsGroupPropertyName];
        NSLog(@"%@",assetsName);
        self.titleLabel.text = assetsName;
        [self.titleLabel sizeToFit];
        
        CGFloat  width = CGRectGetWidth(self.titleLabel.frame)/2+2+CGRectGetWidth(self.arrowImageView.frame)+15;
        self.titleButton.width = width*2;
        
        self.titleLabel.centerY = self.titleButton.height/2;
        self.titleLabel.centerX = self.titleButton.width/2;
        
        self.arrowImageView.left = self.titleLabel.right + 5;
        self.arrowImageView.centerY = self.titleLabel.centerY;
        
        [self loadAllAssetsForGroups];
    }
}

- (void)loadAllAssetsForGroups
{
    [self.selectAssetsGroup setAssetsFilter:ALAssetsFilterFromJKImagePickerControllerFilterType(self.filterType)];
    
    // Load assets
    //存放的是照片
    NSMutableArray *assets = [NSMutableArray array];
    __block NSUInteger numberOfAssets = 0;
    __block NSUInteger numberOfPhotos = 0;
    __block NSUInteger numberOfVideos = 0;
    
    [self.selectAssetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            numberOfAssets++;
            NSString *type = [result valueForProperty:ALAssetPropertyType];
            if ([type isEqualToString:ALAssetTypePhoto]){
                numberOfPhotos++;
            }else if ([type isEqualToString:ALAssetTypeVideo]){
                numberOfVideos++;
            }
            [assets addObject:result];
        }
    }];
    //存放的是每个相册下面的图片
    self.assetsArray = assets;
    self.numberOfAssets = numberOfAssets;
    self.numberOfPhotos = numberOfPhotos;
    self.numberOfVideos = numberOfVideos;
    
    // Update view
    [self.collectionView reloadData];
}

- (void)loadAssetsGroupsWithTypes:(NSArray *)types completion:(void (^)(NSArray *assetsGroups))completion
{
    __block NSMutableArray *assetsGroups = [NSMutableArray array];
    __block NSUInteger numberOfFinishedTypes = 0;
    
    for (NSNumber *type in types) {
        __weak typeof(self) weakSelf = self;
        //是系统的方法 是遍历拿到相册里面的图片以及视频的数量
        [self.assetsLibrary enumerateGroupsWithTypes:[type unsignedIntegerValue]
                                          usingBlock:^(ALAssetsGroup *assetsGroup, BOOL *stop) {
                                              if (assetsGroup) {
                                                  // Filter the assets group
                                                  [assetsGroup setAssetsFilter:ALAssetsFilterFromJKImagePickerControllerFilterType(weakSelf.filterType)];
                                                  
                                                  // Add assets group
                                                  if (assetsGroup.numberOfAssets > 0) {
                                                      // Add assets group
                                                      [assetsGroups addObject:assetsGroup];
                                                  }
                                              } else {
                                                  numberOfFinishedTypes++;
                                              }
                                              
                                              // Check if the loading finished
                                              if (numberOfFinishedTypes == types.count) {
                                                  // Sort assets groups
                                                  NSArray *sortedAssetsGroups = [self sortAssetsGroups:(NSArray *)assetsGroups typesOrder:types];
                                                  
                                                  // Call completion block
                                                  if (completion) {
                                                      completion(sortedAssetsGroups);
                                                  }
                                              }
                                          } failureBlock:^(NSError *error) {
                                              
                                          }];
    }
}

- (NSArray *)sortAssetsGroups:(NSArray *)assetsGroups typesOrder:(NSArray *)typesOrder
{
    NSMutableArray *sortedAssetsGroups = [NSMutableArray array];
    
    for (ALAssetsGroup *assetsGroup in assetsGroups) {
        if (sortedAssetsGroups.count == 0) {
            [sortedAssetsGroups addObject:assetsGroup];
            continue;
        }
        
        ALAssetsGroupType assetsGroupType = [[assetsGroup valueForProperty:ALAssetsGroupPropertyType] unsignedIntegerValue];
        NSUInteger indexOfAssetsGroupType = [typesOrder indexOfObject:@(assetsGroupType)];
        
        for (NSInteger i = 0; i <= sortedAssetsGroups.count; i++) {
            if (i == sortedAssetsGroups.count) {
                [sortedAssetsGroups addObject:assetsGroup];
                break;
            }
            
            ALAssetsGroup *sortedAssetsGroup = sortedAssetsGroups[i];
            ALAssetsGroupType sortedAssetsGroupType = [[sortedAssetsGroup valueForProperty:ALAssetsGroupPropertyType] unsignedIntegerValue];
            NSUInteger indexOfSortedAssetsGroupType = [typesOrder indexOfObject:@(sortedAssetsGroupType)];
            
            if (indexOfAssetsGroupType < indexOfSortedAssetsGroupType) {
                [sortedAssetsGroups insertObject:assetsGroup atIndex:i];
                break;
            }
        }
    }
    
    return sortedAssetsGroups;
}

- (BOOL)validateNumberOfSelections:(NSUInteger)numberOfSelections
{
    NSUInteger minimumNumberOfSelection = MAX(1, self.minimumNumberOfSelection);
    BOOL qualifiesMinimumNumberOfSelection = (numberOfSelections >= minimumNumberOfSelection);
    
    BOOL qualifiesMaximumNumberOfSelection = YES;
    if (minimumNumberOfSelection <= self.maximumNumberOfSelection) {
        qualifiesMaximumNumberOfSelection = (numberOfSelections <= self.maximumNumberOfSelection);
    }
    
    return (qualifiesMinimumNumberOfSelection && qualifiesMaximumNumberOfSelection);
}

- (BOOL)validateMaximumNumberOfSelections:(NSUInteger)numberOfSelections
{
    NSUInteger minimumNumberOfSelection = MAX(1, self.minimumNumberOfSelection);
    
    if (minimumNumberOfSelection <= self.maximumNumberOfSelection) {
        return (numberOfSelections <= self.maximumNumberOfSelection);
    }
    
    return YES;
}

#pragma mark - JKAssetsGroupsViewDelegate
- (void)assetsGroupsViewDidCancel:(JKAssetsGroupsView *)groupsView
{
    [self assetsGroupsDidDeselected];
}

- (void)assetsGroupsView:(JKAssetsGroupsView *)groupsView didSelectAssetsGroup:(ALAssetsGroup *)assGroup
{
    [self assetsGroupsDidDeselected];
    self.selectAssetsGroup = assGroup;
}

#pragma mark - setter
- (void)setShowsAssetsGroupSelection:(BOOL)showsAssetsGroupSelection{
    _showsAssetsGroupSelection = showsAssetsGroupSelection;
    
    self.arrowImageView.selected = _showsAssetsGroupSelection;
    
}
- (void)setShowsCancelButton:(BOOL)showsCancelButton{
    _showsCancelButton = showsCancelButton;
    
    // Show/hide cancel button
    if (showsCancelButton) {
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 0, 50, 30);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cancelBtn setTitleColor:RGB(233, 40, 46) forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[JKUtil getColor:@"828689"] forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(cancelEventDidTouched) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
        [self.navigationItem setLeftBarButtonItem:cancelItem animated:NO];
    } else {
        [self.navigationItem setLeftBarButtonItem:nil animated:NO];
    }
}


- (void)finishPhotoDidSelected
{
    if ([_delegate respondsToSelector:@selector(imagePickerController:didSelectAssets:isSource:)]) {
        [_delegate imagePickerController:self
                         didSelectAssets:self.selectedAssetArray
                                isSource:_selectButton.selected];
    }
}

static NSString *kJKImagePickerCellIdentifier = @"kJKImagePickerCellIdentifier";
static NSString *kJKAssetsFooterViewIdentifier = @"kJKAssetsFooterViewIdentifier";

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.assetsArray count]+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JKAssetsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kJKImagePickerCellIdentifier forIndexPath:indexPath];
    
    cell.delegate = self;
    if ([indexPath row]<=0) {
        cell.asset = nil;
    }else{
        ALAsset *asset = self.assetsArray[indexPath.row-1];
        cell.asset = asset;
        NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
        cell.isSelected = [self assetIsSelected:assetURL];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, 46.0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionFooter) {
        JKAssetsCollectionFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                      withReuseIdentifier:kJKAssetsFooterViewIdentifier
                                                                                             forIndexPath:indexPath];
        
        switch (self.filterType) {
            case JKImagePickerControllerFilterTypeNone:{
                NSString *format;
                if (self.numberOfPhotos == 1) {
                    if (self.numberOfVideos == 1) {
                        format = @"format_photo_and_video";
                    } else {
                        format = @"format_photo_and_videos";
                    }
                } else if (self.numberOfVideos == 1) {
                    format = @"format_photos_and_video";
                } else {
                    format = @"format_photos_and_videos";
                }
                footerView.textLabel.text = [NSString stringWithFormat:NSLocalizedStringFromTable(format,
                                                                                                  @"JKImagePickerController",
                                                                                                  nil),
                                             self.numberOfPhotos,
                                             self.numberOfVideos
                                             ];
                break;
            }
                
            case JKImagePickerControllerFilterTypePhotos:{
                NSString *format = (self.numberOfPhotos == 1) ? @"format_photo" : @"format_photos";
                footerView.textLabel.text = [NSString stringWithFormat:NSLocalizedStringFromTable(format,
                                                                                                  @"JKImagePickerController",
                                                                                                  nil),
                                             self.numberOfPhotos
                                             ];
                break;
            }
                
            case JKImagePickerControllerFilterTypeVideos:{
                NSString *format = (self.numberOfVideos == 1) ? @"format_video" : @"format_videos";
                footerView.textLabel.text = [NSString stringWithFormat:NSLocalizedStringFromTable(format,
                                                                                                  @"JKImagePickerController",
                                                                                                  nil),
                                             self.numberOfVideos
                                             ];
                break;
            }
        }
        
        return footerView;
    }
    
    return nil;
}

#define kSizeThumbnailCollectionView  ([UIScreen mainScreen].bounds.size.width-10)/4

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kSizeThumbnailCollectionView, kSizeThumbnailCollectionView);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}
#pragma mark 这里是点击了item 
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self browerPhotoes:self.assetsArray page:[indexPath row]-1];
}

#pragma mark - getter
- (void)photoBrowser:(JKPhotoBrowser *)photoBrowser didSelectAtIndex:(NSInteger)index
{
    ALAsset *asset = self.assetsArray[index];
    NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
    [self addAssetsObject:assetURL];
    [self resetFinishFrame];
    [self.collectionView reloadData];
}

- (void)photoBrowser:(JKPhotoBrowser *)photoBrowser didDeselectAtIndex:(NSInteger)index
{
    ALAsset *asset = self.assetsArray[index];
    NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
    [self removeAssetsObject:assetURL];
    [self resetFinishFrame];
    [self.collectionView reloadData];
}

#pragma mark- UIImagePickerViewController

#pragma mark   这里是点击了照相机之后的苹果的协议方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    __weak typeof(self) weakSelf = self;
    
    NSString  *assetsName = [self.selectAssetsGroup valueForProperty:ALAssetsGroupPropertyName];
    //NSLog(@"%@",assetsName);
    //作用是把照片保存
    [[PhotoAlbumManager sharedManager] saveImage:image
                                         toAlbum:assetsName
                                 completionBlock:^(ALAsset *asset, NSError *error) {
                                     if (error == nil && asset) {
                                         NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
                                         [self addAssetsObject:assetURL];
                                         [weakSelf finishPhotoDidSelected];
                                     }
                                 }];
    
    [picker dismissViewControllerAnimated:NO completion:^{}];
    
    
}

#pragma mark - JKAssetsViewCellDelegate
#pragma mark 点击了照相机
- (void)startPhotoAssetsViewCell:(JKAssetsViewCell *)assetsCell
{
    if (self.selectedAssetArray.count>=self.maximumNumberOfSelection) {
        NSString  *str = [NSString stringWithFormat:@"最多选择%ld张照片",self.maximumNumberOfSelection];
        [JKPromptView showWithImageName:@"picker_alert_sigh" message:str];
        return;
    }
    //这里是点击了照相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
        pickerController.allowsEditing = NO;
        pickerController.delegate = self;
        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickerController animated:YES completion:^{
        }];
    }
}
#pragma mark 点击了cell
- (void)didSelectItemAssetsViewCell:(JKAssetsViewCell *)assetsCell
{
    if (self.selectedAssetArray.count>=self.maximumNumberOfSelection) {
        NSString  *str = [NSString stringWithFormat:@"最多选择%ld张照片",self.maximumNumberOfSelection];
        [JKPromptView showWithImageName:@"picker_alert_sigh" message:str];
    }
    
    BOOL  validate = [self validateMaximumNumberOfSelections:(self.selectedAssetArray.count + 1)];
    if (validate) {
        // Add asset URL
        NSURL *assetURL = [assetsCell.asset valueForProperty:ALAssetPropertyAssetURL];
        [self addAssetsObject:assetURL];
        [self resetFinishFrame];
        assetsCell.isSelected = YES;
    }
    
}

- (void)didDeselectItemAssetsViewCell:(JKAssetsViewCell *)assetsCell
{
    NSURL *assetURL = [assetsCell.asset valueForProperty:ALAssetPropertyAssetURL];
    [self removeAssetsObject:assetURL];
    [self resetFinishFrame];
    assetsCell.isSelected = NO;
    
    
}

- (void)removeAssetsObject:(NSURL *)assetURL
{
    for (JKAssets *asset in self.selectedAssetArray) {
        if ([assetURL isEqual:asset.assetPropertyURL]) {
            [self.assetsGroupsView removeAssetSelected:asset];
            [self.selectedAssetArray removeObject:asset];
            break;
        }
    }
}
//这里是点击照相机完成之后的一个回调
#pragma mark 这里是把图片转换成自己的类型的数据
- (void)addAssetsObject:(NSURL *)assetURL
{
    //查看相册存储的位置地址
    NSURL *groupURL = [self.selectAssetsGroup valueForProperty:ALAssetsGroupPropertyURL];
     //查看相册的存储id
    NSString *groupID = [self.selectAssetsGroup valueForProperty:ALAssetsGroupPropertyPersistentID];
    JKAssets  *asset = [[JKAssets alloc] init];
    asset.groupPropertyID = groupID;
    asset.groupPropertyURL = groupURL;
    asset.assetPropertyURL = assetURL;
    [self.selectedAssetArray addObject:asset];
    [self.assetsGroupsView addAssetSelected:asset];
}

- (BOOL)assetIsSelected:(NSURL *)assetURL
{
    for (JKAssets *asset in self.selectedAssetArray) {
        if ([assetURL isEqual:asset.assetPropertyURL]) {
            return YES;
        }
    }
    return NO;
}

- (void)resetFinishFrame
{
    self.finishButton.hidden = (self.selectedAssetArray.count<=0);
    self.finishLabel.text = [NSString stringWithFormat:@"下一步(%ld)",self.selectedAssetArray.count];
    [self.finishLabel sizeToFit];
    self.finishButton.width = _finishLabel.width+10;
    self.finishButton.right = self.view.width - 10;
    self.finishLabel.centerX = self.finishButton.width/2;
    self.finishLabel.centerY = self.finishButton.height/2;
    
    self.navigationItem.rightBarButtonItem.enabled = (self.selectedAssetArray.count>0);
    
}

#pragma mark - getter/setter
- (NSMutableArray *)selectedAssetArray{
    if (!_selectedAssetArray) {
        _selectedAssetArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _selectedAssetArray;
}

- (ALAssetsLibrary *)assetsLibrary{
    if (!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}

- (UIButton *)titleButton{
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleButton.frame = CGRectMake(0, 0, 120, 30);
        UIImage  *img =[UIImage imageNamed:@"navigationbar_title_highlighted"];
        [_titleButton setBackgroundImage:nil forState:UIControlStateNormal];
        [_titleButton setBackgroundImage:[JKUtil stretchImage:img capInsets:UIEdgeInsetsMake(5, 2, 5, 2) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
        [_titleButton addTarget:self action:@selector(assetsGroupDidSelected) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleButton;
}

- (UIButton *)arrowImageView{
    if (!_arrowImageView) {
        UIImage  *img = [UIImage imageNamed:@"navigationbar_arrow_down"];
        UIImage  *imgSelect = [UIImage imageNamed:@"navigationbar_arrow_up"];
        _arrowImageView = [UIButton buttonWithType:UIButtonTypeCustom];
        _arrowImageView.frame = CGRectMake(0, 0, img.size.width, img.size.height);
        [_arrowImageView setBackgroundImage:img forState:UIControlStateNormal];
        [_arrowImageView setBackgroundImage:imgSelect forState:UIControlStateSelected];
        [self.titleButton addSubview:_arrowImageView];
    }
    return _arrowImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self.titleButton addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (JKAssetsGroupsView *)assetsGroupsView{
    if (!_assetsGroupsView) {
        _assetsGroupsView = [[JKAssetsGroupsView alloc] initWithFrame:CGRectMake(0, -self.view.height, self.view.width, self.view.height)];
        _assetsGroupsView.delegate = self;
        _assetsGroupsView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:_assetsGroupsView];
    }
    return _assetsGroupsView;
}

- (UIView *)overlayView{
    if (!_overlayView) {
        _overlayView = [[UIView alloc] initWithFrame:self.view.bounds];
        _overlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.85f];
        [self.view insertSubview:_overlayView belowSubview:self.assetsGroupsView];
    }
    return _overlayView;
}

- (UIButton *)touchButton{
    if (!_touchButton) {
        _touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _touchButton.frame = CGRectMake(0, 0, self.view.width, 64);
        [_touchButton addTarget:self action:@selector(assetsGroupsDidDeselected) forControlEvents:UIControlEventTouchUpInside];
    }
    return _touchButton;
}

- (UIToolbar *)toolbar{
    if (!_toolbar) {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.height-44-64, self.view.width, 44)];
        _toolbar.tintColor = [JKUtil getColor:@"f5f7fa"];
        if ([_toolbar respondsToSelector:@selector(barTintColor)]) {
            _toolbar.barTintColor = [JKUtil getColor:@"f5f7fa"];
        }
        _toolbar.translucent = YES;
        _toolbar.userInteractionEnabled = YES;
        
        UIImage  *img = [UIImage imageNamed:@"compose_photo_original"];
        UIImage  *imgSelect = [UIImage imageNamed:@"compose_photo_original_highlighted"];
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectButton.frame = CGRectMake(10, floor((44-img.size.height)/2), img.size.width, img.size.height);
        [_selectButton setBackgroundImage:img forState:UIControlStateNormal];
        [_selectButton setBackgroundImage:imgSelect forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectOriginImage) forControlEvents:UIControlEventTouchUpInside];
        [_toolbar addSubview:_selectButton];
        
        UILabel  *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [JKUtil getColor:@"828689"];
        label.font = [UIFont systemFontOfSize:11];
        label.text = @"原图";
        [label sizeToFit];
        label.centerY = _selectButton.height/2;
        label.right = _selectButton.width - 14;
        [_selectButton addSubview:label];
        
        _finishLabel = [[UILabel alloc] init];
        _finishLabel.backgroundColor = [UIColor clearColor];
        _finishLabel.textColor = [UIColor whiteColor];
        _finishLabel.font = [UIFont systemFontOfSize:14];
        _finishLabel.text = @"下一步(9)";
        //sizeToFit自动控制label的宽度。
        [_finishLabel sizeToFit];
        
        _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishButton.frame = CGRectMake(0, 0, _finishLabel.width+10, _selectButton.height);
        [_finishButton setBackgroundImage:[JKUtil stretchImage:[UIImage imageNamed:@"picker_button_orange"] capInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        [_finishButton setBackgroundImage:[JKUtil stretchImage:[UIImage imageNamed:@"picker_button_orange"] capInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
        _finishButton.right = self.view.width-10;
        _finishButton.centerY = _selectButton.centerY;
        _finishButton.hidden = YES;
        [_finishButton addTarget:self action:@selector(finishPhotoDidSelected) forControlEvents:UIControlEventTouchUpInside];
        [_toolbar addSubview:_finishButton];
        
        _finishLabel.centerY = _finishButton.height/2;
        _finishLabel.centerX = _finishButton.width/2;
        [_finishButton addSubview:_finishLabel];
        
        [self.view addSubview:_toolbar];
    }
    return _toolbar;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 2.0;
        layout.minimumInteritemSpacing = 2.0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, [UIScreen mainScreen].bounds.size.height-64-44) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[JKAssetsViewCell class] forCellWithReuseIdentifier:kJKImagePickerCellIdentifier];
        [_collectionView registerClass:[JKAssetsCollectionFooterView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:kJKAssetsFooterViewIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_collectionView];
        
    }
    return _collectionView;
}

@end
