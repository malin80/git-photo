//
//  DatePickerView.h
//  Photo
//
//  Created by malin  on 2017/7/26.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>

@optional
- (void)cancelDatePicker;
- (void)completeDatePicker:(NSString*)dateString;

@end

@interface DatePickerView : UIView
{
    NSDateFormatter* _dateFormatter;
    UIDatePicker* _datePicker;
    NSString* _resultStr;
}

@property(nonatomic,assign) id<DatePickerViewDelegate> delegate;

- (void)setDatePickerDefault:(NSString*)defaultStr;

@end
