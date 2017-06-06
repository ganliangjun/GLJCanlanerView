//
//  GLJCalendarDayModel.h
//  GLJCanlanderView
//
//  Created by JunLiang Gan on 2017/3/28.
//  Copyright © 2017年 JunLiang Gan. All rights reserved.
//

#import <Foundation/Foundation.h>
//屏幕高度
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
//屏幕宽度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
//根据八进制 获取字体颜色
#define GLJCOLORFROMRGD(valueRGD) [UIColor colorWithRed:(float)((valueRGD & 0Xff0000) >> 16)/255 green:(float)((valueRGD & 0Xff00) >> 8)/255 blue:(float)(valueRGD & 0Xff)/255 alpha:1.0]
//根据数字获取颜色值
#define GLJColorWithRGB(red, green, bkue, alpha)  [[UIColor alloc] initWithRed:(a)/255.0 green:(b)/255.0 blue:(c)/255.0 alpha:alpha]
//根据屏幕计算高度
#define GLJCalculateWithHeight(height) ((ScreenHeight) > 568 ? ScreenWidth*(height)/720.0 : (height)/2.0)
//计算字体大小
#define GLJFontWithSize(size) [UIFont systemFontOfSize:GLJCalculateWithHeight(size)]


@interface GLJCalendarDayModel : NSObject

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic)  NSDateComponents *dateComponents;

@end
