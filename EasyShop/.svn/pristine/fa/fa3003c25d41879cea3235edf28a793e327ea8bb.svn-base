//
//  CreateCommentCell.h
//  MFBank
//
//  Created by lyywhg on 15/12/5.
//  Copyright (c) 2015年 MFBank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanStarRatingView.h"
#import "PlaceholderTextView.h"

@protocol CreateCommentDelegate <NSObject>

- (void)cBtnTouchAction:(NSInteger)btnIndex cellIndex:(NSInteger)cellIndex;
- (void)cAddPhotoActionWithCellIndex:(NSInteger)cellIndex;
- (void)cDeleteTouchAction:(NSInteger)btnIndex cellIndex:(NSInteger)cellIndex;

- (void)didSelectResult:(NSInteger)result;

@end

@interface PostCommentCell : UITableViewCell

/** 图片数组 (item: UIImage ) */
@property (nonatomic,strong) NSArray *imageItems;

/*评价的文字输入框*/
@property (nonatomic, strong) PlaceholderTextView *commentTextView;
@property (nonatomic, weak) id<CreateCommentDelegate> delegate;

- (void)updateViewInfoWithInfo:(NSDictionary *)dict index:(NSInteger)index;

@end
