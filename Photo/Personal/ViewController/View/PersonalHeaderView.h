//
//  PersonalHeaderView.h
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvatarView.h"
#import "MemberInfo.h"

@interface PersonalHeaderView : UIView

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic ,strong) AvatarView *avatarView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *phoneNunberLabel;
@property (nonatomic, strong) UIImageView *arrowView;

@property (nonatomic, strong) MemberInfo *info;

@end
