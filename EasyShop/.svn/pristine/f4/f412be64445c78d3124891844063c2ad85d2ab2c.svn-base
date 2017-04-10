//
//  CanStarRatingView.h
//  MFBank
//
//  Created by lyywhg on 15/11/2.
//  Copyright © 2015年 MFBank. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CanStarRatingView;

@protocol CanStarRatingViewDelegate <NSObject>

@optional
-(void)starRatingView:(CanStarRatingView *)view score:(CGFloat)score;

@end

@interface CanStarRatingView : UIView

- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number;
- (void)updateStarRatingWithScore:(CGFloat)score;

@property (nonatomic, readonly) int numberOfStar;
@property (nonatomic, weak) id <CanStarRatingViewDelegate> delegate;

@end
