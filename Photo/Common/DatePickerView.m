//
//  DatePickerView.m
//  Photo
//
//  Created by malin  on 2017/7/26.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _resultStr = @"";
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    //日期格式化类
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    
    [_dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [_dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    //取消完成按钮
    UIImageView* topToolBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 46)];
    topToolBar.userInteractionEnabled = YES;
    topToolBar.image = [UIImage imageNamed:@""];
    
    UIButton* cancel = [[UIButton alloc] initWithFrame:CGRectMake(5, 7.5, 51, 31)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancel setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [cancel setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    cancel.titleLabel.font = [UIFont systemFontOfSize:18.0];
    cancel.frame = CGRectMake(5, 7.5, 51, 31);
    [cancel setTitleEdgeInsets:UIEdgeInsetsMake(6, 0, 6, 10)];
    [cancel addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton* complete = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-51-5, 7.5, 51, 31)];
    [complete setTitle:@"完成" forState:UIControlStateNormal];
    [complete setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [complete setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [complete setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    complete.titleLabel.font = [UIFont systemFontOfSize:18.0];
    complete.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width-51-5, 7.5, 51, 31);
    [complete setTitleEdgeInsets:UIEdgeInsetsMake(6, 10, 6, 0)];
    [complete addTarget:self action:@selector(clickCompleteBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    [topToolBar addSubview:cancel];
    [topToolBar addSubview:complete];
    
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 46, [[UIScreen mainScreen] bounds].size.width, 214)];
    }
    _datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate* minDate = [_dateFormatter dateFromString:@"1920-01-01"];
    NSDate* maxDate = [NSDate date];
    _datePicker.minimumDate = minDate;
    _datePicker.maximumDate = maxDate;
    [_datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    [self addSubview:topToolBar];
    [self addSubview:_datePicker];
    self.backgroundColor = [UIColor whiteColor];
}

-(void)dateChanged
{
    NSString *dateStr = [_dateFormatter stringFromDate:_datePicker.date];
    //不能选择今天
    NSString *todayStr = [_dateFormatter stringFromDate:[NSDate date]];
    if (todayStr && dateStr && [todayStr isEqualToString:dateStr]) {
//        showToastMsg(NSLocalizedString(@"PleaseInputCorrectAge", nil));
        _resultStr = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",@""]];
    } else {
        _resultStr = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",dateStr]];
    }
}

- (void)setDatePickerDefault:(NSString*)defaultStr;
{
    NSDate* date = [_dateFormatter dateFromString:defaultStr];
    if (date) {
        [_datePicker setDate:date animated:NO];
    } else {
        [_datePicker setDate:[NSDate date] animated:NO];
    }
    [self dateChanged];
    
}

//取消按钮
- (void)clickCancelBtn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelDatePicker)]) {
        [self.delegate cancelDatePicker];
    }
}

//完成按钮
- (void)clickCompleteBtn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(completeDatePicker:)]) {
        [self.delegate completeDatePicker:[NSString stringWithFormat:@"%@",_resultStr]];
    }
}

@end
