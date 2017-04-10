//
//  DZPhotoBrowser.h
//  EasyShop
//
//  Created by 就手国际 on 16/12/5.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DZPhotoBrowser;
@protocol DZPhotoBrowserDelegate <NSObject>

@optional
- (void)photoBrowser:(DZPhotoBrowser *)photoBrowser didSelectAtIndex:(NSInteger)index;
- (void)photoBrowser:(DZPhotoBrowser *)photoBrowser didDeselectAtIndex:(NSInteger)index;

@end

@interface DZPhotoBrowser : UIView

@property (nonatomic, weak) id<DZPhotoBrowserDelegate> delegate;

@property (nonatomic, strong) NSMutableArray      *assetsArray;

@property (nonatomic, assign) NSInteger    currentPage;
@property (nonatomic,strong) NSMutableArray*imageArray;
@property (nonatomic,assign ) BOOL isShowDeleButton;

- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;
@end
