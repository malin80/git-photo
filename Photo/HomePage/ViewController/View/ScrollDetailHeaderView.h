//
//  ScrollDetailHeaderView.h
//  Photo
//
//  Created by malin  on 2017/10/13.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ScrollDetailType) {
    ScrollDetailTypeAll = 0,
    ScrollDetailTypeCameraMan,
    ScrollDetailTypeDressMan
};

@interface ScrollDetailHeaderView : UIView

@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UIImageView *titleView;
@property (nonatomic, strong) UILabel *line1;
@property (nonatomic, strong) UIImageView *cameraManView;
@property (nonatomic, strong) UIImageView *dressManView;
@property (nonatomic, strong) UILabel *line2;
@property (nonatomic, strong) UILabel *line3;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) ScrollDetailType type;

-(id)initWithFrame:(CGRect)frame withType:(ScrollDetailType)type;

@end
