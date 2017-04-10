//
//  ESJoinListPeopleImageCell.h
//  EasyShop
//
//  Created by jiushou on 16/10/13.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESClusterDetailPeopleCell : UITableViewCell
@property (nonatomic,assign) BOOL isHidenLable;//1是不显示3人团的label  2是显示label;
@property (nonatomic,strong) GetClusterDetailRespone*clusterDetail;
@property (nonatomic,copy) NSString*clusterid;//详情页的团购

@end
