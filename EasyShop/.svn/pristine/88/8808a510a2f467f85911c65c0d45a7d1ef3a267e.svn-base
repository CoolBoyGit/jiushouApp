//
//  ImageViewScrollView.h
//  MFBank
//
//  Created by lyywhg on 15/12/5.
//  Copyright (c) 2015年 MFBank. All rights reserved.
//

#import <UIKit/UIKit.h>




@protocol ImageViewScrollViewDelegate <NSObject>

- (void)btnTouchAction:(NSInteger)btnIndex;
- (void)addPhotoAction;
- (void)deleteTouchAction:(NSInteger)btnIndex;


@end


//typedef void (^ImageViewScrollViewBlock) (NSInteger index);

@interface ImageViewScrollView : UIScrollView

//@property (nonatomic, copy) ImageViewScrollViewBlock imageViewScrollViewBlock;


@property (nonatomic, weak) id<ImageViewScrollViewDelegate> iDelegate;

- (void)updateViewInfoWithInfo:(NSArray *)imageList type:(NSInteger)type;

@end
