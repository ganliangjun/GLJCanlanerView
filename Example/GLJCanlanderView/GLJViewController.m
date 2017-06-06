//
//  GLJViewController.m
//  GLJCanlanderView
//
//  Created by 970721775@qq.com on 05/23/2017.
//  Copyright (c) 2017 970721775@qq.com. All rights reserved.
//

#import "GLJViewController.h"
#import <GLJCanlanderView/GLJCalendarView.h>

typedef void(^GLJblock)(NSString* string);

@interface GLJViewController ()<GLJCalendarViewProtocol>

@property (assign ,nonatomic) int i;

@property (assign, nonatomic) int t;
@property (assign, nonatomic) int sum;

@property (nonatomic, copy)  GLJblock block;

@end

@implementation GLJViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    __weak typeof(self) weakSelf = self;
    [self add:^(NSString *str) {
        
        GLJCalendarView *view = [[GLJCalendarView alloc] init];
        view.type = GLJCalendarHandlerSelectedType_QuanRi;
        view.frame = CGRectMake(0, 64, weakSelf.view.bounds.size.width, weakSelf.view.bounds.size.height - 64);
        [weakSelf.view addSubview:view];
        view.delegate = weakSelf;
        
    }];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = self.view.frame;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(add1:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)add:(void(^)(NSString *str)) block{
    _block = block;
}

-(void)add1:(UIButton*) sender{
    
    _block(@"asdkasdalkdjklas");
    
}



@end
