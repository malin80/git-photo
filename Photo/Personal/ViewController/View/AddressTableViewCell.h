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
- (void)editAddressWithAddressName:(NSString *)name;
- (void)deleteAddressWithAddressName:(NSString *)name;
- (void)makeAddressDefaultWithAddressName:(NSString *)name;
- (void)cancelAddressDefaultWithAddressName:(NSString *)name;

@end

@interface AddressTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UILabel *normalAddressLabel;
@property (nonatomic, strong) UIButton *selectedView;
@property (nonatomic, strong) UIView *editBackView;
@property (nonatomic, strong) UIImageView *editImageView;
@property (nonatomic, strong) UILabel *editLabel;
@property (nonatomic, strong) UIView *deleteBackView;
@property (nonatomic, strong) UIImageView *deleteImageView;
@property (nonatomic, strong) UILabel *deleteLabel;
@property (nonatomic, strong) UIView *seperateView;

@property(nonatomic, weak)  id<AddressTableViewCellDelegate> delegate;

@end
