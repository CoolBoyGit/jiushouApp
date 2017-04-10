//
//  CreateCommentCell.h
//  MFBank
//
//  Created by lyywhg on 15/12/5.
//  Copyright (c) 2015年 MFBank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceholderTextView.h"

@protocol CreateCommentDelegate <NSObject>

- (void)cBtnTouchAction:(NSInteger)btnIndex cellIndex:(NSInteger)cellIndex;
- (void)cAddPhotoActionWithCellIndex:(NSInteger)cellIndex;
- (void)cDeleteTouchAction:(NSInteger)btnIndex cellIndex:(NSInteger)cellIndex;


@end

@interface CreateCommentCell : UITableViewCell

@property (nonatomic, strong) PlaceholderTextView *commentTextView;
@property (nonatomic, weak) id<CreateCommentDelegate> delegate;

- (void)updateViewInfoWithInfo:(NSArray *)array index:(NSInteger)index;

@end
