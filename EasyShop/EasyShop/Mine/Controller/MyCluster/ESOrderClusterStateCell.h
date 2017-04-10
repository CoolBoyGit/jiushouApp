//
//  OrderStateCell.h
//  Glife
//
//  Created by 脉融iOS开发 on 16/3/15.
//  Copyright © 2016年 MFBank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESOrderClusterStateCell : UITableViewCell

@property (nonatomic, strong) NSArray                                   *titleArr;
@property (nonatomic, strong) NSArray                                   *imgArr;
@property  (nonatomic,strong) AllOrderCount*countInfo;
@property (nonatomic,strong) NSMutableArray*itemArray;

@end



