//
//  GLJCalendarHandler.m
//  GLJCanlanderView
//
//  Created by JunLiang Gan on 2017/3/28.
//  Copyright © 2017年 JunLiang Gan. All rights reserved.
//

#import "GLJCalendarHandler.h"

@implementation GLJCalendarHandler

static GLJCalendarHandler *sharedObj = nil;

+(instancetype)shareCalendarHandler{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedObj = [[self alloc] init];
    });
    return sharedObj;
}

+(id) allocWithZone:(NSZone *)zone
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedObj = [super allocWithZone:zone];
    });
    return sharedObj;
}

-(id) copyWithZone:(NSZone *)zone
{
    return self;
}

-(instancetype)init
{
    if (self == [super init]) {
    }
    return self;
}


-(GLJCalendarMonthModel*)currentCalendarMonthModel{
    return [self calenderMonthModelWith:[NSDate date]];
}

-(GLJCalendarMonthModel*)calenderMonthModelWith:(NSDate *)date{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
    
    GLJCalendarMonthModel *monthModel = [[GLJCalendarMonthModel alloc] init];
    monthModel.monthTitle = [NSString stringWithFormat:@"%d年%d月", (int)dateComponents.year, (int)dateComponents.month];
    NSDateComponents *tempDateComponents = [[NSDateComponents alloc] init];
    tempDateComponents.year = dateComponents.year;
    tempDateComponents.month = dateComponents.month;
    tempDateComponents.day = 1;
    
    monthModel.firstDate = [calendar dateFromComponents:tempDateComponents];
    int count = 0;
    BOOL flag = YES;
    while (flag) {
        NSDate *calculateDate = [monthModel.firstDate dateByAddingTimeInterval:60*60*24*count];
        NSDateComponents *calculateComponents = [calendar components:unitFlags fromDate:calculateDate];
        if (calculateComponents.month != tempDateComponents.month) {
            flag = NO;
            monthModel.lastDate = [[monthModel.calendarDayModelArray lastObject] date];
        }else{
            GLJCalendarDayModel *calendarDayModel = [[GLJCalendarDayModel alloc] init];
            calendarDayModel.dateComponents = calculateComponents;
            calendarDayModel.date = calculateDate;
            [monthModel.calendarDayModelArray addObject:calendarDayModel];
        }
        count++;
    }
    NSInteger calendarWeekCount = [[monthModel.calendarDayModelArray firstObject] dateComponents].weekday + monthModel.calendarDayModelArray.count - 1;
    monthModel.weekCount = calendarWeekCount/7;
    if (calendarWeekCount%7) {
        monthModel.weekCount = calendarWeekCount/7 + 1;
    }
    
    return monthModel;
}

-(GLJCalendarMonthModel*)calculateCalenderMonthModelWithCalenderMonthModel:(GLJCalendarMonthModel*) calenderMonthModel andCalculateType:(GLJCalendarHandlerCalculateType) type{
    switch (type) {
        case GLJCalendarHandlerCalculateType_FrontMonth:
        {
            return [self calenderMonthModelWith:[calenderMonthModel.firstDate dateByAddingTimeInterval:-60*60*24]];
        }
            break;
        case GLJCalendarHandlerCalculateType_NextMonth:
        {
            return [self calenderMonthModelWith:[calenderMonthModel.lastDate dateByAddingTimeInterval:60*60*24]];
        }
            break;
        default:
            break;
    }
    return nil;
    
}

@end
