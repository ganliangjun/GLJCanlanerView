//
//  GLJCalendarMonthView.h
//  GLJCanlanderView
//
//  Created by JunLiang Gan on 2017/3/28.
//  Copyright © 2017年 JunLiang Gan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLJCalendarDayView.h"
#import "GLJCalendarMonthModel.h"
#import "GLJCalendarHandler.h"

@interface GLJCalendarMonthView : UIView

@property (strong, nonatomic) GLJCalendarMonthModel *calendarMonthModel;
-(void)show;


@end
