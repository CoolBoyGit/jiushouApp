//
//  TypeView.h
//  WCZ
//
//  Created by Bigzone on 16/6/24.
//  Copyright © 2016年 Bigzone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    softwareProblem,
    transportProblem,
    goodProblem,
    changeOrReturnProblem,
    otherProblem
    
}allProblems;

@interface TypeView : UIView

@property (nonatomic,assign) allProblems myProblem;

@end
