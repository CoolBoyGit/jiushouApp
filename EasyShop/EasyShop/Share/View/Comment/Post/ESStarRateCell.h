//
//  ESStarRateCell.h
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/12.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanStarRatingView.h"
#import "CommentStartInfo.h"

@interface ESStarRateCell : UITableViewCell
/** 订单评论请求 */
@property (nonatomic,strong) AddEvaluationRequest  *evaluationRequest;

@end
