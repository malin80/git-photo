//
//  DQMarryDateView.h
//  Photo
//
//  Created by malin  on 2017/8/14.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@class DQAgeModel;
@protocol DQMarryDateViewDelegate <NSObject>
@optional
/**
 DQAgeModel
 Str 星座
 */
//点击选中哪一行 的代理方法
- (void)clickDQMarryDateViewEnsureBtnActionAgeModel:(DQAgeModel *)ageModel andConstellation:(NSString *)str;

@end

@interface DQMarryDateView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, weak) id<DQMarryDateViewDelegate> delegate;

@property (nonatomic, strong) UIViewController *ctl;

/**
 根据出生年月日的时间戳 来设置默认选项
 */
- (void)setMarryDateStatusFromString:(NSString *)timStr;

//开启动画
- (void)startAnimationFunction;
//关闭动画
- (void)CloseAnimationFunction;
@end
