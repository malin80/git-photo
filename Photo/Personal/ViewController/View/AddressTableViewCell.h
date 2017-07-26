//
//  AddressTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddressTableViewCellDelegate <NSObject>

@optional
- (void)editAddress;

@end

@interface AddressTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UILabel *normalAddressLabel;
@property (nonatomic, strong) UIImageView *selectView;
@property (nonatomic, strong) UIView *editBackView;
@property (nonatomic, strong) UIImageView *editImageView;
@property (nonatomic, strong) UILabel *editLabel;
@property (nonatomic, strong) UIView *deleteBackView;
@property (nonatomic, strong) UIImageView *deleteImageView;
@property (nonatomic, strong) UILabel *deleteLabel;

@property(nonatomic, weak)  id<AddressTableViewCellDelegate> delegate;

@end
