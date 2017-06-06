//
//  GLJCalendarView.m
//  GLJCanlanderView
//
//  Created by JunLiang Gan on 2017/3/30.
//  Copyright © 2017年 JunLiang Gan. All rights reserved.
//

#import "GLJCalendarView.h"
#import "GLJCalendarMonthCell.h"
#import "GLJCalendarView.h"

@interface GLJCalendarView ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *monthModelArray;
@property (strong, nonatomic) UITableView *tableView;


@end

@implementation GLJCalendarView

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

-(void)setStartDate:(NSDate *)startDate{
    
    if (!startDate) {
        _startDate = nil;
    }else{
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
        NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:startDate];
        NSDateComponents *tempDateComponents = [[NSDateComponents alloc] init];
        tempDateComponents.year = dateComponents.year;
        tempDateComponents.month = dateComponents.month;
        tempDateComponents.day = dateComponents.day;
        _startDate = [calendar dateFromComponents:tempDateComponents];
    }
    [GLJCalendarHandler shareCalendarHandler].startDate = _startDate;
    
}

-(void)setEndDate:(NSDate *)endDate{
    
    
    if (!endDate) {
        _endDate = nil;
    }else{
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
        NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:endDate];
        NSDateComponents *tempDateComponents = [[NSDateComponents alloc] init];
        tempDateComponents.year = dateComponents.year;
        tempDateComponents.month = dateComponents.month;
        tempDateComponents.day = dateComponents.day;
        _endDate = [calendar dateFromComponents:tempDateComponents];
    }
    [GLJCalendarHandler shareCalendarHandler].endDate = _endDate;

    
}


-(void)setType:(GLJCalendarHandlerSelectedDateType)type{
    _type = type;
    [GLJCalendarHandler shareCalendarHandler].type = type;
}

-(void)ainint{
    self.backgroundColor = [UIColor whiteColor];
    //全日 并设置开始时间为当天
    self.startDate = [NSDate date];
    self.endDate = nil;
    self.type = GLJCalendarHandlerSelectedType_QuanRi;
    
    __weak typeof(self) weakSelf = self;
    
    [GLJCalendarHandler shareCalendarHandler].block = ^(NSDate *date){
        switch (weakSelf.type) {
            case GLJCalendarHandlerSelectedType_ZhongDian:
                //终点房
                weakSelf.startDate = date;
                if ([weakSelf.delegate respondsToSelector:@selector(calendarViewSelected:)]) {
                    [weakSelf.delegate calendarViewSelected:weakSelf];
                }
                break;
            case GLJCalendarHandlerSelectedType_QuanRi:
                //全日房
                //都已选着
                if (weakSelf.startDate&&weakSelf.endDate) {
                    weakSelf.endDate = nil;
                    weakSelf.startDate = date;
                }
                //只有开始时间
                if (weakSelf.startDate&&!weakSelf.endDate) {
                    if ((int)[date timeIntervalSinceDate:weakSelf.startDate] > 0) {
                        weakSelf.endDate = date;
                        if ([weakSelf.delegate respondsToSelector:@selector(calendarViewSelected:)]) {
                            [weakSelf.delegate calendarViewSelected:weakSelf];
                        }
                    }else{
                        weakSelf.startDate = date;
                        weakSelf.endDate = nil;
                    }
                }
                //都未选择
                if (!weakSelf.startDate&&!weakSelf.endDate) {
                    weakSelf.startDate = date;
                    weakSelf.endDate = nil;
                }
                break;
            default:
                break;
        }
        [weakSelf.tableView reloadData];
    };
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

-(NSMutableArray*)monthModelArray{
    
    if (!_monthModelArray) {
        _monthModelArray = [NSMutableArray array];
        [_monthModelArray addObject:[[GLJCalendarHandler shareCalendarHandler] currentCalendarMonthModel]];
        [_monthModelArray addObject:[[GLJCalendarHandler shareCalendarHandler] calculateCalenderMonthModelWithCalenderMonthModel:[_monthModelArray lastObject] andCalculateType:GLJCalendarHandlerCalculateType_NextMonth]];
        [_monthModelArray addObject:[[GLJCalendarHandler shareCalendarHandler] calculateCalenderMonthModelWithCalenderMonthModel:[_monthModelArray lastObject] andCalculateType:GLJCalendarHandlerCalculateType_NextMonth]];
        [_monthModelArray addObject:[[GLJCalendarHandler shareCalendarHandler] calculateCalenderMonthModelWithCalenderMonthModel:[_monthModelArray lastObject] andCalculateType:GLJCalendarHandlerCalculateType_NextMonth]];
    }
    return _monthModelArray;
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    [GLJCalendarHandler shareCalendarHandler].calendarWidth = self.frame.size.width;
    [GLJCalendarHandler shareCalendarHandler].calendarHeight = self.frame.size.height;
    _tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (_tableView.contentOffset.y < 0) {
            GLJCalendarMonthModel *monthModel =  [[GLJCalendarHandler shareCalendarHandler] calculateCalenderMonthModelWithCalenderMonthModel:[_monthModelArray firstObject] andCalculateType:GLJCalendarHandlerCalculateType_FrontMonth];
            [_monthModelArray insertObject:monthModel atIndex:0];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
                [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            });
        }
        if (_tableView.contentOffset.y > _tableView.contentSize.height - [GLJCalendarHandler shareCalendarHandler].calendarHeight) {
            [_monthModelArray addObject:[[GLJCalendarHandler shareCalendarHandler] calculateCalenderMonthModelWithCalenderMonthModel:[_monthModelArray lastObject] andCalculateType:GLJCalendarHandlerCalculateType_NextMonth]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.monthModelArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLJCalendarMonthCell *monthCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!monthCell) {
        monthCell = [[GLJCalendarMonthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [monthCell setCalendarMonthModel:self.monthModelArray[indexPath.row]];
    monthCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return monthCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [(GLJCalendarMonthModel*)_monthModelArray[indexPath.row] monthFrame].size.height;
    
}

-(void)dealloc{
    
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
    
}

@end
