//
//  ALAssetsLibrary+Extend.h
//  CustomImagePicker
//
//  Created by lvpw on 15/1/29.
//  Copyright (c) 2015年 lvpw. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

@interface ALAssetsLibrary (Extend)

// On iOS 8.1 [library assetForUrl] Photo Streams always returns nil.
// On iOS 5.1.1 no Photo Streams Group
// http://stackoverflow.com/questions/26480526/alassetslibrary-assetforurl-always-returning-nil-for-photos-in-my-photo-stream/26526199#26526199
// This method is asynchronous.

- (void)extend_assetForURL:(NSURL *)assetURL resultBlock:(ALAssetsLibraryAssetForURLResultBlock)resultBlock failureBlock:(ALAssetsLibraryAccessFailureBlock)failureBlock;

@end
