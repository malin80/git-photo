//
//  NavigationBar.h
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavigationBarDelegate <NSObject>

@optional
- (void)goBack;

@end

@interface NavigationBar : UIView

@property (nonatomic, strong) UILabel *titieLabel;
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, copy) NSString *titleName;

@property(nonatomic, weak) id<NavigationBarDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title;

- (void)setRightButtonTitle:(NSString *)title;

@end
