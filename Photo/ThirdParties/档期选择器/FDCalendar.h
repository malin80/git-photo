//
//  FDCalendar.h
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol showDataDelegate <NSObject>

- (void)showData:(NSString *)riqi;
@end
@interface FDCalendar : UIView

- (instancetype)initWithCurrentDate:(NSDate *)date;
@property (weak, nonatomic) id<showDataDelegate> daili;
@end
