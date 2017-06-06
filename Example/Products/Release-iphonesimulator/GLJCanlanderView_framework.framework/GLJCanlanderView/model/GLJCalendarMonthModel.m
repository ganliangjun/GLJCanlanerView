//
//  GLJCalendarMonthModel.m
//  GLJCanlanderView
//
//  Created by JunLiang Gan on 2017/3/28.
//  Copyright © 2017年 JunLiang Gan. All rights reserved.
//

#import "GLJCalendarMonthModel.h"
#import "GLJCalendarHandler.h"

@implementation GLJCalendarMonthModel

-(NSMutableArray<GLJCalendarDayModel*>*)calendarDayModelArray{
    
    if (!_calendarDayModelArray) {
        _calendarDayModelArray = [NSMutableArray array];
    }
    return _calendarDayModelArray;
}

-(CGRect)monthFrame{
    
    return CGRectMake(0, 0, [GLJCalendarHandler shareCalendarHandler].calendarWidth, (self.weekCount + .5)*[GLJCalendarHandler shareCalendarHandler].calendarWidth/7);
    
}

@end
