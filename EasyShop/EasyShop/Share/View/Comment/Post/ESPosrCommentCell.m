


//
//  ESPosrCommentCell.m
//  EasyShop
//
//  Created by wcz on 16/7/14.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESPosrCommentCell.h"
#import "ImageViewScrollView.h"
#import "LIRTUIButton.h"
#import "PlaceholderTextView.h"
#import "ESPostCommentImageCell.h"
#import "JKImagePickerController.h"
#import "JKAssets.h"
#import <UIActionSheet+BlocksKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+Extend.h"
#import "JKAssets.h"
#import <ImageIO/ImageIO.h>
#import "DZPhotoBrowser.h"
#import "ESImageModel.h"
@interface ESPosrCommentCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JKImagePickerControllerDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,DZPhotoBrowserDelegate>

@property (nonatomic, strong) UIImageView *shopImageView;
@property (nonatomic, strong) UILabel *line1Label;
@property (nonatomic, strong) PlaceholderTextView *commentTextView;
@property (nonatomic, assign) NSInteger cellIndex;
@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) NSDictionary *cellInfoDict;
@property (nonatomic, strong) NSMutableArray *assetsArray;
@property (nonatomic, strong) NSMutableArray*buttonArray;
@property (nonatomic,strong) UIView*bottomView;

//照相相关
@property (nonatomic,strong) ALAssetsLibrary*assetsLibrary;
@property (nonatomic, strong) NSArray *groupTypes;
@property (nonatomic ,strong) ALAssetsGroup*selectAssetsGroup;
@property (nonatomic,strong)  NSMutableArray*commentImageArray;
@property (nonatomic,strong) DZPhotoBrowser  *photoBorwser;
/** 拍照控制器 */
@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (nonatomic,strong) NSMutableArray*photoBrowserArray;

@property (nonatomic,assign) int count;
@end

@implementation ESPosrCommentCell
-(NSMutableArray *)commentImageArray{
    if (_commentImageArray==nil) {
        _commentImageArray=[NSMutableArray array];
    }
    return _commentImageArray;
}
-(NSMutableArray *)photoBrowserArray{
    if (_photoBrowserArray==nil) {
        _photoBrowserArray=[NSMutableArray array];
    }
    return _photoBrowserArray;
}
-(NSMutableArray *)assetsArray{
    if (_assetsArray==nil) {
        _assetsArray=[[NSMutableArray alloc]init];
    }
    return _assetsArray;
}
- (UIImagePickerController *)imagePicker
{
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        //        _imagePicker.allowsEditing = YES;
    }
    return _imagePicker;
}

- (ALAssetsLibrary *)assetsLibrary{
    if (!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}
-(void)loadAllALAssetsGroup:(UIImage*)image{
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if ([[group valueForKey:ALAssetsGroupPropertyName] isEqualToString:@"相机胶卷"]) {
            
        }
    } failureBlock:^(NSError *error) {
        
    }];
    
}
- (void)setEvaluationInfo:(EvaluationGoodsInfo *)evaluationInfo
{
    _evaluationInfo = evaluationInfo;
    if (self.count==0) {
        [_evaluationInfo.imageItems addObject:[UIImage imageNamed:@"camera"]];
    }
    self.count++;

    
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:evaluationInfo.imageURL] placeholderImage:nil];
    
    [self.collectionview reloadData];
}

- (UICollectionView *)collectionview
{
    if (_collectionview == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionview.dataSource = self;
        _collectionview.pagingEnabled = YES;
        _collectionview.showsVerticalScrollIndicator = NO;
        _collectionview.showsHorizontalScrollIndicator = NO;
        _collectionview.delegate = self;
        [_collectionview registerClass:[ESPostCommentImageCell class] forCellWithReuseIdentifier:@"ESPostCommentImageCell"];
        _collectionview.backgroundColor = [UIColor whiteColor];
    }
    return _collectionview;
}
-(void)btnClick1:(LIRTUIButton *)btn
{
    NSArray *array2 = @[@"GoodSComment",@"MediumComment",@"NegativeComment"];
    NSArray *array3 = @[RGB(233, 40, 46),RGB(254, 204, 46),RGB(20, 20, 20)];
    for (LIRTUIButton*button in self.buttonArray) {
        switch (button.tag) {
            case 0:
                button.leftImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"GoodSComment_normal"]];
                button.rightLabel.textColor=RGB(70, 70, 70);
                
                break;
            case 1:
                button.leftImg.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",@"MediumComment_normal"]];
                button.rightLabel.textColor=RGB(70, 70, 70);
                break;
            case 2:
                button.leftImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"CommentNormal"]];
                button.rightLabel.textColor=RGB(70, 70, 70);
                break;
            default:
                break;
        }
        
        
        
        
    }
    btn.selected=YES;
    if (btn.selected) {
        btn.leftImg.image = [UIImage imageNamed:array2[btn.tag]];
        btn.rightLabel.textColor=array3[btn.tag];
    } else{
        
    }
    
    self.evaluationInfo.result = [NSNumber numberWithInteger:btn.tag + 1];
}

-(UIView *)bottomView{
    if (_bottomView==nil) {
        _bottomView=[[UIView alloc]init];
        _bottomView.backgroundColor=RGB(247, 247, 247);
    }
    return _bottomView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.count=0;
        [self.photoBrowserArray addObject:[UIImage imageNamed:@"camera"]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.shopImageView];
        [self.shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(10);
            make.top.equalTo(self.mas_top).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        [self.contentView addSubview:self.commentTextView];
        [self.commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.shopImageView.mas_right).with.offset(5);
            make.right.equalTo(self.mas_right).with.offset(-15);
            make.top.equalTo(self.mas_top).with.offset(10);
            make.height.equalTo(@85);
        }];
        [self.contentView addSubview:self.line1Label];
        [self.line1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(0);
            make.bottom.equalTo(@(-60));
            make.height.equalTo(@0.5);
        }];
        [self.contentView addSubview:self.collectionview];
        [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(@(-10));
            make.bottom.equalTo(self.line1Label.mas_top).offset(-10);
            make.height.equalTo(@((ScreenWidth-23)/4));
        }];
        [self.contentView addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@10);
            make.bottom.equalTo(@0);
        }];
        
        
        NSArray *array = @[@"好评",@"中评",@"差评"];
        
        for (int i = 0; i < 3; i++) {
            LIRTUIButton *button1 = [[LIRTUIButton alloc] initWithFrame:CGRectMake(ScreenWidth/3.0*i, 220, ScreenWidth/3.0, 30)];
            button1.frame = CGRectMake(ScreenWidth/3.0*i, 140+(ScreenWidth-23)/4.0, ScreenWidth/3.0, 30);
            button1.tag = i;
            [button1 addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
            button1.rightLabel.text = array[i];
            switch (button1.tag) {
                case 0:
                    button1.leftImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"GoodSComment_normal"]];
                    break;
                case 1:
                    button1.leftImg.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",@"MediumComment_normal"]];
                    break;
                case 2:
                    button1.leftImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"CommentNormal"]];
                    break;
                default:
                    break;
            }
            if (button1.tag==0) {
                button1.leftImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"GoodSComment"]];
                button1.rightLabel.textColor=RGB(233, 40, 46);
            }
            [self.buttonArray addObject:button1];
            [self addSubview:button1];
        }
        
    }
    return self;
}
-(NSMutableArray *)buttonArray{
    if (_buttonArray==nil) {
        _buttonArray=[[NSMutableArray alloc]init];
        
    }
    return _buttonArray;
}
#pragma mark
#pragma mark Init & Add
- (UIImageView *)shopImageView {
    if (!_shopImageView) {
        _shopImageView = [[UIImageView alloc] init];
        _shopImageView.layer.masksToBounds = YES;
    }
    return _shopImageView;
}
- (UILabel *)line1Label {
    if (!_line1Label) {
        _line1Label = [[UILabel alloc] init];
        _line1Label.backgroundColor = ADeanHEXCOLOR(0xcccccc);
    }
    return _line1Label;
}
- (PlaceholderTextView *)commentTextView {
    if (!_commentTextView) {
        _commentTextView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(5, 0, ScreenWidth - 10, 60)];
        _commentTextView.placeholder = @"亲,给好评哟!";
        _commentTextView.placeholderFont=[UIFont boldSystemFontOfSize:13];
        _commentTextView.delegate = self;
    }
    return _commentTextView;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    self.evaluationInfo.content = textView.text;
}

-(BOOL)textView:(PlaceholderTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    textView.textColor = ADeanHEXCOLOR(0x323232);
    textView.font = ADeanFONT17;
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (toBeString.length >120) {
        return NO;
    }
    return YES;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.evaluationInfo.imageItems.count;
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESPostCommentImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESPostCommentImageCell" forIndexPath:indexPath];
        cell.image = [self.evaluationInfo.imageItems objectAtIndex:indexPath.item];
       return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth-23)/4,(ScreenWidth-23)/4);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
    
}
#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.commentImageArray.count==5) {
         [self showDZPhotoBrowser:indexPath.item];
    }else{
        if (indexPath.item==self.evaluationInfo.imageItems.count-1) {
            UIActionSheet *sheet = [[UIActionSheet alloc] init];
            @weakify(self);
            [sheet bk_addButtonWithTitle:@"拍照" handler:^{
                @strongify(self);
                self.imagePicker.sourceType= UIImagePickerControllerSourceTypeCamera;
                [[AppDelegate shared]presentViewController:self.imagePicker animated:YES completion:^{
                    
                }];
                
            }];
            [sheet bk_addButtonWithTitle:@"从手机相册选择" handler:^{
                @strongify(self);
                [self photoLibraryAction];
            }];
            [sheet bk_setCancelButtonWithTitle:@"取消" handler:nil];
            [sheet showInView:kKeyWindow];
        }else{
            [self showDZPhotoBrowser:indexPath.item];
        }

    }
    
    
    
    
}
-(void)showDZPhotoBrowser:(NSInteger)index{
    self.photoBorwser = [[DZPhotoBrowser alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.photoBorwser.delegate = self;
    self.photoBorwser.currentPage = index;
    self.photoBrowserArray =[self.commentImageArray mutableCopy];
    [self.photoBrowserArray removeLastObject];
    self.photoBorwser.imageArray=self.photoBrowserArray;
    self.photoBorwser.isShowDeleButton=NO;
    [self.photoBorwser show:YES];

}
#pragma mark 图片浏览的协议方法
-(void)photoBrowser:(DZPhotoBrowser *)photoBrowser didSelectAtIndex:(NSInteger)index{
    [self.evaluationInfo.imageItems removeObjectAtIndex:index];
    [self.commentImageArray removeObjectAtIndex:index];
    NSIndexPath*indexPa=[NSIndexPath indexPathForItem:index inSection:0];
    if ([self.collectionview numberOfItemsInSection:0]==self.evaluationInfo.imageItems.count) {
           
        }
        else{
            //发送通知来操作去刷新里面的界面?
            NSDictionary*dic=[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",index]forKey:@"index"];
            [[NSNotificationCenter defaultCenter]postNotificationName:DeleItemInthePostCommet object:nil userInfo:dic];
            
            [self.collectionview deleteItemsAtIndexPaths:@[indexPa]];
            [self.assetsArray removeObjectAtIndex:self.commentImageArray.count-1-index];
            if (self.commentImageArray.count==4) {
                [self.evaluationInfo.imageItems addObject:[UIImage imageNamed:@"camera"]];
            }
            [self.collectionview reloadData];

            if (self.assetsArray.count==0) {
                [self.photoBorwser hide:YES];
            }
        }
 
}

- (void)photoLibraryAction {
    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 1;
    imagePickerController.maximumNumberOfSelection = 4;
    imagePickerController.selectedAssetArray = self.assetsArray;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [[AppDelegate shared] presentViewController:navigationController animated:YES completion:nil];
}
//原生相机的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage* image = [info objectForKey: @"UIImagePickerControllerOriginalImage"];
    @weakify(self);
    [self.assetsLibrary writeImageToSavedPhotosAlbum:image.CGImage orientation:(ALAssetOrientation)image.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
        @strongify(self);
        [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            @strongify(self);
            if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:@"相机胶卷"]) {
                self.selectAssetsGroup=group;
                [self addAssetsObject:assetURL];
                //可以用这种方式返回到前一个界面
                [picker dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
        } failureBlock:^(NSError *error) {
            
        }];
    }];
    
}

#pragma mark 这里是把图片转换成自己的类型的数据
- (void)addAssetsObject:(NSURL *)assetURL
{
    //查看相册存储的位置地址
    NSURL *groupURL = [self.selectAssetsGroup valueForProperty:ALAssetsGroupPropertyURL];
    //查看相册的存储id
    NSString *groupID = [self.selectAssetsGroup valueForProperty:ALAssetsGroupPropertyPersistentID];
    JKAssets  *asset = [[JKAssets alloc] init];
    if (self.commentImageArray.count==0) {
        [self.commentImageArray addObject:[UIImage imageNamed:@"camera"]];
    }
    asset.groupPropertyID = groupID;
    asset.groupPropertyURL = groupURL;
    asset.assetPropertyURL = assetURL;
    [self.assetsArray addObject:asset];
    [self.assetsLibrary extend_assetForURL:asset.assetPropertyURL resultBlock:^(ALAsset *asset) {
        if (asset) {
            CGImageRef ref = [[asset  defaultRepresentation]fullScreenImage];
            UIImage *image = [[UIImage alloc]initWithCGImage:ref];
            [self.evaluationInfo.imageItems insertObject:[self imageCompressForWidth:image targetWidth:1.5*ScreenWidth] atIndex:0];
            [self.commentImageArray insertObject:[self imageCompressForWidth:image targetWidth:1.5*ScreenWidth] atIndex:0];
            [self.collectionview reloadData];
            
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    
}


#pragma mark - JKImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(JKImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//代理方法
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source
{
    
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    self.assetsArray = [NSMutableArray arrayWithArray:assets];
     [self.evaluationInfo.imageItems removeAllObjects];
    [self.commentImageArray removeAllObjects];
    [self.commentImageArray addObject:[UIImage imageNamed:@"camera"]];
    [self.evaluationInfo.imageItems addObject:[UIImage imageNamed:@"camera"]];
    for (int i = 0; i < self.assetsArray.count; i++) {
        JKAssets *jka = self.assetsArray[i];
        ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
        [lib extend_assetForURL:jka.assetPropertyURL resultBlock:^(ALAsset *asset) {
            if (asset) {
               CGImageRef ref = [[asset  defaultRepresentation]fullScreenImage];
                UIImage *image = [[UIImage alloc]initWithCGImage:ref];
                [self.evaluationInfo.imageItems insertObject:[self imageCompressForWidth:image targetWidth:1.5*ScreenWidth] atIndex:0];
                if (self.evaluationInfo.imageItems.count==5) {
                    [self.evaluationInfo.imageItems removeLastObject];
                }
                [self.commentImageArray insertObject:[self imageCompressForWidth:image targetWidth:1.5*ScreenWidth] atIndex:0];
                //这里做了刷新
                [self.collectionview reloadData];
                
            }
            
        } failureBlock:^(NSError *error) {
            
        }];
    
    }
}
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
        CGSize imageSize = sourceImage.size;
        CGFloat width = imageSize.width;
    
        CGFloat height = imageSize.height;
    
        CGFloat targetWidth = defineWidth;
        CGFloat targetHeight = (targetWidth / width) * height;
        UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
        [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
        
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData *dataOf02 =UIImageJPEGRepresentation(newImage, 0.4);
        UIImage*image=[UIImage imageWithData:dataOf02];
    //UIImageJPEGRepresentation函数需要两个参数:图片的引用和压缩系数.而UIImagePNGRepresentation只需要图片引用作为参数.通过在实际使用过程中,比较发现: UIImagePNGRepresentation(UIImage* image) 要比UIImageJPEGRepresentation(UIImage* image, 1.0) 返回的图片数据量大很多.
        return image;
}
#pragma mark - ALAsset图片裁剪
static size_t getAssetBytesCallback(void *info, void *buffer, off_t position, size_t count) {
    ALAssetRepresentation *rep = (__bridge id)info;
    
    NSError *error = nil;
    size_t countRead = [rep getBytes:(uint8_t *)buffer fromOffset:position length:count error:&error];
    
    if (countRead == 0 && error) {
        // We have no way of passing this info back to the caller, so we log it, at least.
        NSLog(@"thumbnailForAsset:maxPixelSize: got an error reading an asset: %@", error);
    }
    
    return countRead;
}

static void releaseAssetCallback(void *info) {
    // The info here is an ALAssetRepresentation which we CFRetain in thumbnailForAsset:maxPixelSize:.
    // This release balances that retain.
    CFRelease(info);
}

// Returns a UIImage for the given asset, with size length at most the passed size.
// The resulting UIImage will be already rotated to UIImageOrientationUp, so its CGImageRef
// can be used directly without additional rotation handling.
// This is done synchronously, so you should call this method on a background queue/thread.
- (UIImage *)thumbnailForAsset:(ALAsset *)asset maxPixelSize:(NSUInteger)size {
    NSParameterAssert(asset != nil);
    NSParameterAssert(size > 0);
    
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    
    CGDataProviderDirectCallbacks callbacks = {
        .version = 0,
        .getBytePointer = NULL,
        .releaseBytePointer = NULL,
        .getBytesAtPosition = getAssetBytesCallback,
        .releaseInfo = releaseAssetCallback,
    };
    
    CGDataProviderRef provider = CGDataProviderCreateDirect((void *)CFBridgingRetain(rep), [rep size], &callbacks);
    CGImageSourceRef source = CGImageSourceCreateWithDataProvider(provider, NULL);
    
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef) @{
                                                                                                      (__bridge NSString *)kCGImageSourceCreateThumbnailFromImageAlways : @YES,
                                                                                                      (__bridge NSString *)kCGImageSourceThumbnailMaxPixelSize : [NSNumber numberWithInteger:size],
                                                                                                      (__bridge NSString *)kCGImageSourceCreateThumbnailWithTransform : @YES,
                                                                                                      });
    CFRelease(source);
    CFRelease(provider);
    
    if (!imageRef) {
        return nil;
    }
    
    UIImage *toReturn = [UIImage imageWithCGImage:imageRef];
    
    CFRelease(imageRef);
    
    return toReturn;
}
@end
