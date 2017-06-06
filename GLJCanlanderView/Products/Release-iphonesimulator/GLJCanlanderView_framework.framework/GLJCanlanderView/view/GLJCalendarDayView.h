//
//  GLJCalendarDayView.h
//  GLJCanlanderView
//
//  Created by JunLiang Gan on 2017/3/28.
//  Copyright © 2017年 JunLiang Gan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLJCalendarDayModel.h"
#import "GLJCalendarHandler.h"

@interface GLJCalendarDayView : UIView

@property (strong, nonatomic) GLJCalendarDayModel *calendarDayModel;
@property (assign, nonatomic) BOOL isShowMarkedView;

@end
