//
//  SexPickerView.m
//  Photo
//
//  Created by malin  on 2017/7/26.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "SexPickerView.h"

@interface SexPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *_pickerArray;
}

@end

@implementation SexPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self createPickerView];
        _pickerArray = [[NSArray alloc]initWithObjects:@"男", @"女", nil];
    }
    return self;
}

- (void)createPickerView {
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

    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:topToolBar];
    [self addSubview:pickerView];
}

#pragma mark --- PickerView DataSource ---
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}

#pragma mark --- PickerView Delegate ---
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent:(NSInteger)component{
    return [_pickerArray objectAtIndex:row];
}


@end
