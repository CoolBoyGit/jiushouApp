//
//  ESMoneyBagCell.h
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/9.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESMoneyBagCellDelegate <NSObject>

- (void)clickHomePush:(NSInteger)tag;

@end



@interface ESMoneyBagCell : UITableViewCell

@property (nonatomic, assign) id<ESMoneyBagCellDelegate>                  delegate;
@property (nonatomic, strong) NSArray                                   *topTitleArr;
@property (nonatomic, strong) NSArray                                   *bottonTitleArr;

@end
