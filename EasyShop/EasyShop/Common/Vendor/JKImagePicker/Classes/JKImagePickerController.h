//
//  JKImagePickerController.h
//  JKImagePicker
//
//  Created by Jecky on 15/1/9.
//  Copyright (c) 2015年 Jecky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "JKAssets.h"

typedef NS_ENUM(NSUInteger, JKImagePickerControllerFilterType) {
    JKImagePickerControllerFilterTypeNone,
    JKImagePickerControllerFilterTypePhotos,
    JKImagePickerControllerFilterTypeVideos
};

UIKIT_EXTERN ALAssetsFilter * ALAssetsFilterFromJKImagePickerControllerFilterType(JKImagePickerControllerFilterType type);

@class JKImagePickerController;

@protocol JKImagePickerControllerDelegate <NSObject>

@optional
//点击了下一步之后的协议
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAsset:(JKAssets *)asset isSource:(BOOL)source;
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source;
//点击了取消按钮
- (void)imagePickerControllerDidCancel:(JKImagePickerController *)imagePicker;

@end

@interface JKImagePickerController : UIViewController

@property (nonatomic, weak) id<JKImagePickerControllerDelegate> delegate;
@property (nonatomic, assign) JKImagePickerControllerFilterType filterType;
//是否显示取消按钮
@property (nonatomic, assign) BOOL showsCancelButton;
@property (nonatomic, assign) BOOL allowsMultipleSelection;
//z最少的图片张数
@property (nonatomic, assign) NSUInteger minimumNumberOfSelection;
@property (nonatomic, assign) NSUInteger maximumNumberOfSelection;
@property (nonatomic, strong) NSMutableArray     *selectedAssetArray;

@end
