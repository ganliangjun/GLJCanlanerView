//
//  GLJCalendarDayView.m
//  GLJCanlanderView
//
//  Created by JunLiang Gan on 2017/3/28.
//  Copyright © 2017年 JunLiang Gan. All rights reserved.
//

#import "GLJCalendarDayView.h"

@interface GLJCalendarDayView ()

@property (strong, nonatomic) UILabel *dayTitleLabel;
@property (strong, nonatomic) UIView *markedView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong , nonatomic) UIView *lineView;

@property (nonatomic, strong) UIImageView *alertImgView;

@end

@implementation GLJCalendarDayView

-(instancetype)init{
    if (self = [super init]) {
        [self ainint];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
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
    _dayTitleLabel = [[UILabel alloc] init];
    [self addSubview:_dayTitleLabel];
    _markedView = [[UIView alloc] init];
    [self addSubview:_markedView];
    _titleLabel = [[UILabel alloc] init];
    [self addSubview:_titleLabel];
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = GLJCOLORFROMRGD(0xe7e7e7);
    
    self.clipsToBounds = NO;
    
}

-(void)tap{
    
    [GLJCalendarHandler shareCalendarHandler].block(_calendarDayModel.date);
   
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.lineView.frame = CGRectMake(0, height - 3, width , 0.5);
    [self addSubview:self.lineView];
    
    if (self.calendarDayModel) {
        
        self.markedView.hidden = YES;
        if (_isShowMarkedView) {
            self.markedView.hidden = NO;
            self.dayTitleLabel.textColor = [UIColor whiteColor];
        }
        self.markedView.frame = CGRectMake(0, 0, width, height/2);
        self.markedView.backgroundColor = GLJCOLORFROMRGD(0xffa0a0);//---
        
        
        self.dayTitleLabel.frame = CGRectMake(width/4, 0, width/2, height/2);
        self.dayTitleLabel.text = [NSString stringWithFormat:@"%d", (int)_calendarDayModel.dateComponents.day];
        self.dayTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.dayTitleLabel.layer.cornerRadius = height/2/2;
        self.dayTitleLabel.clipsToBounds = YES;
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
        NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:[NSDate date]];
        NSDateComponents *tempDateComponents = [[NSDateComponents alloc] init];
        tempDateComponents.year = dateComponents.year;
        tempDateComponents.month = dateComponents.month;
        tempDateComponents.day = dateComponents.day;
        if ((int)[[calendar dateFromComponents:tempDateComponents] timeIntervalSinceDate:self.calendarDayModel.date] <= 0) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
            [self addGestureRecognizer:tap];
//            self.dayTitleLabel.textColor = [UIColor blackColor];
            //周末
            if (_calendarDayModel.dateComponents.weekday == 7|| _calendarDayModel.dateComponents.weekday == 1) {
//                self.dayTitleLabel.textColor = [UIColor orangeColor];
            }
        }else{
            self.dayTitleLabel.textColor = [UIColor grayColor];
        }
        
        
        [self.alertImgView removeFromSuperview];
        //入住时间
        if ((int)[self.calendarDayModel.date timeIntervalSinceDate:[GLJCalendarHandler shareCalendarHandler].startDate] == 0 && [GLJCalendarHandler shareCalendarHandler].startDate) {
            _dayTitleLabel.backgroundColor = [UIColor redColor];
            self.markedView.frame = CGRectMake(width/2, 0, width/2, height/2);
            self.titleLabel.text = @"入住";
            
            if ([GLJCalendarHandler shareCalendarHandler].type == GLJCalendarHandlerSelectedType_QuanRi) {
                [self addSubview:self.alertImgView];
            }
            self.dayTitleLabel.textColor = [UIColor whiteColor];
            if ([GLJCalendarHandler shareCalendarHandler].endDate) {
                [self.alertImgView removeFromSuperview];
            }
        }
        //离店时间
        if ((int)[self.calendarDayModel.date timeIntervalSinceDate:[GLJCalendarHandler shareCalendarHandler].endDate] == 0&& [GLJCalendarHandler shareCalendarHandler].endDate) {
            NSLog(@"self.calendarDayModel.date:%@", self.calendarDayModel.date);
            _dayTitleLabel.backgroundColor = [UIColor redColor];
            self.markedView.frame = CGRectMake(0, 0, width/2, height/2);
            self.titleLabel.text = @"离店";
            self.dayTitleLabel.textColor = [UIColor whiteColor];
        }
        
        self.titleLabel.font = GLJFontWithSize(20);
        self.titleLabel.textColor = GLJCOLORFROMRGD(0xf23030);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.frame = CGRectMake(0, width/2, width, height/2);
        
    }else{
        
        self.markedView.hidden = YES;
        if (_isShowMarkedView) {
            self.markedView.hidden = NO;
        }
        self.markedView.frame = CGRectMake(0, 0, width, height/2);
        self.markedView.backgroundColor = GLJCOLORFROMRGD(0xffa0a0);//---
    }
    
    [self bringSubviewToFront:self.dayTitleLabel];

    
}

- (UIImageView *)alertImgView{
    if (!_alertImgView) {
        _alertImgView = [[UIImageView alloc] initWithFrame:CGRectMake(-(50-self.frame.size.width/2), -35, 100, 35)];
        _alertImgView.image = [UIImage imageNamed:@"tishikuang"];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _alertImgView.frame.size.width, _alertImgView.frame.size.height)];
        contentLabel.text = @"请选择离店时间";
        contentLabel.font = [UIFont systemFontOfSize:12];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.textColor = GLJCOLORFROMRGD(0xffffff);
        [_alertImgView addSubview:contentLabel];
    }
    return _alertImgView;
}


@end
