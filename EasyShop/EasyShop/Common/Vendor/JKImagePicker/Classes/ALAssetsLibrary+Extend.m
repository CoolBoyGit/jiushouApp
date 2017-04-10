//
//  ALAssetsLibrary+Extend.m
//  CustomImagePicker
//
//  Created by lvpw on 15/1/29.
//  Copyright (c) 2015年 lvpw. All rights reserved.
//

#import "ALAssetsLibrary+Extend.h"

@implementation ALAssetsLibrary (Extend)

- (void)extend_assetForURL:(NSURL *)assetURL resultBlock:(ALAssetsLibraryAssetForURLResultBlock)resultBlock failureBlock:(ALAssetsLibraryAccessFailureBlock)failureBlock {
    [self assetForURL:assetURL resultBlock:^(ALAsset *asset) {
        if (asset) {
            resultBlock(asset);
        } else {
            [self enumerateGroupsWithTypes:ALAssetsGroupPhotoStream
                                usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                    if (group) {
                                        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                            if ([result.defaultRepresentation.url isEqual:assetURL]) {
                                                resultBlock(result);
                                                *stop = YES;
                                            }
                                            if (index == ([group numberOfAssets] - 1) && *stop == NO) {
                                                failureBlock(nil);
                                            }
                                        }];
                                    } else {
                                        failureBlock(nil);
                                    }
                                } failureBlock:failureBlock];
        }
    } failureBlock:failureBlock];
}

@end
