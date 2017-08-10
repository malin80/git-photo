//
//  UserDataViewController.h
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DQBirthDateView.h"
#import "DQAgeModel.h"
#import "LTPickerView.h"

@interface UserDataViewController : BaseViewController <DQBirthDateViewDelegate>

@property (nonatomic, strong) DQBirthDateView *DQBirthView;

@end
