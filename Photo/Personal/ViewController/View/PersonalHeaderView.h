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

@protocol PersonalHeaderViewDelegate <NSObject>

@optional
- (void)loginButtonClick;

@end

@interface PersonalHeaderView : UIView

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic ,strong) AvatarView *avatarView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *phoneNunberLabel;
@property (nonatomic, strong) UIImageView *arrowView;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *subTitle;
@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) MemberInfo *info;

@property (nonatomic, assign) BOOL loginOut;

@property(nonatomic, weak)  id<PersonalHeaderViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame withIsLoginOut:(BOOL)loginOut;

@end
