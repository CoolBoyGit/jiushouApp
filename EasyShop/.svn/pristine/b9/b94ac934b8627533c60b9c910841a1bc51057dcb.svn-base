//
//  HomePushCell.h
//  MFBank
//
//  Created by mairong on 15/12/19.
//  Copyright © 2015年 MFBank. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomePushCellDelegate;

@interface ESForumPushCell : UITableViewCell

@property (nonatomic, assign) id<HomePushCellDelegate>                  delegate;

+ (CGFloat)heightOfCell:(NSArray *)arr;

@end



@protocol HomePushCellDelegate <NSObject>

@optional

- (void)clickHomePush:(NSInteger)tag;

@end