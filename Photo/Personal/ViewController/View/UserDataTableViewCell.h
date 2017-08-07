//
//  UserDataTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvatarView.h"
#import "MemberInfo.h"

@interface UserDataTableViewCell : UITableViewCell

@property (nonatomic ,strong) AvatarView *avatarView;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UILabel *subtitle;

@property (nonatomic, strong) MemberInfo *info;

@end
