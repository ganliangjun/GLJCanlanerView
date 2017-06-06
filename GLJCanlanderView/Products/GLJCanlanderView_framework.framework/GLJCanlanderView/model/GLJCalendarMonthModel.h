//
//  GLJCalendarMonthModel.h
//  GLJCanlanderView
//
//  Created by JunLiang Gan on 2017/3/28.
//  Copyright © 2017年 JunLiang Gan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLJCalendarDayModel.h"
#import <UIKit/UIKit.h>

@interface GLJCalendarMonthModel : NSObject

@property (strong, nonatomic) NSDate *firstDate;
@property (strong, nonatomic) NSDate *lastDate;
@property (assign, nonatomic) NSInteger weekCount;
@property (strong, nonatomic) NSString *monthTitle;
@property (assign, nonatomic) CGRect monthFrame;
@property (strong, nonatomic) NSMutableArray<GLJCalendarDayModel*>* calendarDayModelArray;


@end
