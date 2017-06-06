//
//  GLJCalendarMonthView.m
//  GLJCanlanderView
//
//  Created by JunLiang Gan on 2017/3/28.
//  Copyright © 2017年 JunLiang Gan. All rights reserved.
//

#import "GLJCalendarMonthView.h"

@interface GLJCalendarMonthView ()

@property (strong, nonatomic) UILabel *titleStringLabel;

@end
@implementation GLJCalendarMonthView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self ainint];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        [self ainint];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self ainint];
    }
    return self;
}

-(void)ainint{
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = NO;
    
}


-(void)show{
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    self.titleStringLabel = [[UILabel alloc] init];
    self.titleStringLabel.textColor = [UIColor blackColor];
    self.titleStringLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleStringLabel];
    
    self.titleStringLabel.frame = CGRectMake(0, 0, [GLJCalendarHandler shareCalendarHandler].calendarWidth, [GLJCalendarHandler shareCalendarHandler].calendarWidth/7/2);
    self.titleStringLabel.text = self.calendarMonthModel.monthTitle;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, [GLJCalendarHandler shareCalendarHandler].calendarWidth/7/2 - 0.5, [GLJCalendarHandler shareCalendarHandler].calendarWidth, 0.5)];
    lineView.backgroundColor = GLJCOLORFROMRGD(0xe7e7e7);
    [self addSubview:lineView];
                                                               
    NSInteger firstWeekDay = [(GLJCalendarDayModel*)[self.calendarMonthModel.calendarDayModelArray firstObject] dateComponents].weekday;
    
    for (int i = 0; i < self.calendarMonthModel.weekCount*7; i++) {
        GLJCalendarDayView * calendarDayView  = [[GLJCalendarDayView alloc] init];
        calendarDayView.isShowMarkedView = NO;
        CGFloat width = [GLJCalendarHandler shareCalendarHandler].calendarWidth/7;
        CGFloat height = [GLJCalendarHandler shareCalendarHandler].calendarWidth/7;
        CGFloat x = (i%7)*[GLJCalendarHandler shareCalendarHandler].calendarWidth/7;
        CGFloat y = [GLJCalendarHandler shareCalendarHandler].calendarWidth/7/2 + (i/7)*[GLJCalendarHandler shareCalendarHandler].calendarWidth/7;
        calendarDayView.frame = CGRectMake(x, y, width, height);
        [self addSubview:calendarDayView];
        if (i - firstWeekDay+1 < 0){
            
            if ([GLJCalendarHandler shareCalendarHandler].startDate && [GLJCalendarHandler shareCalendarHandler].endDate) {
                GLJCalendarDayModel *dayModel = [self.calendarMonthModel.calendarDayModelArray firstObject];
                if ((int)[dayModel.date timeIntervalSinceDate:[GLJCalendarHandler shareCalendarHandler].startDate] > 0 && (int)[dayModel.date timeIntervalSinceDate:[GLJCalendarHandler shareCalendarHandler].endDate] <= 0) {
                    calendarDayView.isShowMarkedView = YES;
                }
            }
        }else if (i - firstWeekDay+1 <  self.calendarMonthModel.calendarDayModelArray.count && i - firstWeekDay+1 >= 0) {
            GLJCalendarDayModel *dayModel = self.calendarMonthModel.calendarDayModelArray[i - firstWeekDay+1];
            calendarDayView.calendarDayModel = dayModel;
            if ([GLJCalendarHandler shareCalendarHandler].startDate && [GLJCalendarHandler shareCalendarHandler].endDate) {
                if ((int)[dayModel.date timeIntervalSinceDate:[GLJCalendarHandler shareCalendarHandler].startDate] >= 0 && (int)[dayModel.date timeIntervalSinceDate:[GLJCalendarHandler shareCalendarHandler].endDate] <= 0) {
                    calendarDayView.isShowMarkedView = YES;
                    NSLog(@",.....");
                }
            }
        }else if (i - firstWeekDay+1>= self.calendarMonthModel.calendarDayModelArray.count){
            if ([GLJCalendarHandler shareCalendarHandler].startDate && [GLJCalendarHandler shareCalendarHandler].endDate) {
                GLJCalendarDayModel *dayModel = [self.calendarMonthModel.calendarDayModelArray lastObject];
                if ((int)[dayModel.date timeIntervalSinceDate:[GLJCalendarHandler shareCalendarHandler].startDate] >= 0 && (int)[dayModel.date timeIntervalSinceDate:[GLJCalendarHandler shareCalendarHandler].endDate] < 0) {
                    calendarDayView.isShowMarkedView = YES;
                    NSLog(@",.....");
                }
            }
        }
    }
}
@end
