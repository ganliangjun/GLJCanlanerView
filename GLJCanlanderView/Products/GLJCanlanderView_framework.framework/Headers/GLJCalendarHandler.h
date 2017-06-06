//
//  GLJCalendarHandler.h
//  GLJCanlanderView
//
//  Created by JunLiang Gan on 2017/3/28.
//  Copyright © 2017年 JunLiang Gan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GLJCalendarMonthModel.h"

typedef void(^TapBlock)(NSDate *date);

typedef NS_ENUM(NSUInteger, GLJCalendarHandlerCalculateType){
    
    GLJCalendarHandlerCalculateType_FrontMonth,//上一个月
    GLJCalendarHandlerCalculateType_NextMonth//下一个月
    
};

typedef NS_ENUM(NSUInteger, GLJCalendarHandlerSelectedDateType){
    
    GLJCalendarHandlerSelectedType_ZhongDian,//终点房
    GLJCalendarHandlerSelectedType_QuanRi//
    
};


@interface GLJCalendarHandler : NSObject

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (assign, nonatomic) CGFloat calendarWidth;
@property (assign, nonatomic) CGFloat calendarHeight;
@property (assign, nonatomic) GLJCalendarHandlerSelectedDateType type;
@property (copy,   nonatomic) TapBlock block;

+(instancetype)shareCalendarHandler;
-(GLJCalendarMonthModel*)currentCalendarMonthModel;
-(GLJCalendarMonthModel*)calculateCalenderMonthModelWithCalenderMonthModel:(GLJCalendarMonthModel*) calenderMonthModel andCalculateType:(GLJCalendarHandlerCalculateType) type;

@end
