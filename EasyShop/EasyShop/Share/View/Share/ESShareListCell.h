//
//  ESShareListCell.h
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/18.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESShareListCellDelegate <NSObject>

@optional
- (void)ESShareListCellShare;

@end

@interface ESShareListCell : UITableViewCell

@property (nonatomic, assign) id<ESShareListCellDelegate>    delegate;

/** 分享内容 */
@property (nonatomic,strong) ShareFeedInfo *feedInfo;

@end
