//
//  GLJCalendarMonthCell.m
//  GLJCanlanderView
//
//  Created by JunLiang Gan on 2017/3/28.
//  Copyright © 2017年 JunLiang Gan. All rights reserved.
//

#import "GLJCalendarMonthCell.h"
#import "GLJCalendarMonthView.h"

@interface GLJCalendarMonthCell ()

@property (strong, nonatomic) GLJCalendarMonthView *calendarMonthView;

@end

@implementation GLJCalendarMonthCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _calendarMonthView = [[GLJCalendarMonthView alloc] init];
        [self.contentView addSubview:_calendarMonthView];
        self.contentView.clipsToBounds = NO;
        self.clipsToBounds = NO;
    }
    return self;
    
}

-(void)setCalendarMonthModel:(GLJCalendarMonthModel *)calendarMonthModel{
    
    _calendarMonthModel = calendarMonthModel;
    self.calendarMonthView.frame = _calendarMonthModel.monthFrame;
    self.calendarMonthView.calendarMonthModel = _calendarMonthModel;
    [self.calendarMonthView show];
    
}

@end
