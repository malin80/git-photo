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
#import "DQMarryDateView.h"
#import "DQAgeModel.h"
#import "LTPickerView.h"

@interface UserDataViewController : BaseViewController <DQBirthDateViewDelegate, DQMarryDateViewDelegate>

@property (nonatomic, strong) DQBirthDateView *DQBirthView;
@property (nonatomic, strong) DQMarryDateView *DQMarryView;

@end
