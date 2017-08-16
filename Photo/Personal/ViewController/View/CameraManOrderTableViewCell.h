//
//  CameraManOrderTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/8/16.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CameraManOrderTableViewCellDelegate <NSObject>

@optional
- (void)cancelButtonClick:(UIButton *)sender;
- (void)backButtonClick:(UIButton *)sender;
- (void)payButtonClick:(UIButton *)sender;
- (void)deleteButtonClick:(UIButton *)sender;

@end

@interface CameraManOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *groupNameLabel;
@property (nonatomic, strong) UILabel *orderNumLabel;
@property (nonatomic, strong) UILabel *orderCameraManNameLabel;
@property (nonatomic, strong) UILabel *orderCreatDateLabel;
@property (nonatomic, strong) UILabel *orderDateLabel;
@property (nonatomic, strong) UILabel *orderStatusLabel;
@property (nonatomic, strong) UIView *buttonBackView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *payButton;
@property (nonatomic, strong) UIButton *deleteButton;

@property(nonatomic, weak)  id<CameraManOrderTableViewCellDelegate> delegate;


@end
