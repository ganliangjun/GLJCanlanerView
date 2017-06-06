//
//  GLJCalendarView.h
//  GLJCanlanderView
//
//  Created by JunLiang Gan on 2017/3/30.
//  Copyright © 2017年 JunLiang Gan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLJCalendarHandler.h"
@class GLJCalendarView;
@protocol GLJCalendarViewProtocol <NSObject>

@optional
-(void)calendarViewSelected:(GLJCalendarView*) calendarView;

@end

@interface GLJCalendarView : UIView

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (assign, nonatomic) GLJCalendarHandlerSelectedDateType type;
@property (weak,   nonatomic) id<GLJCalendarViewProtocol> delegate;

@end
