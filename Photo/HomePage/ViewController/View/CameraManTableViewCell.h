//
//  CameraManTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/8/3.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraManTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *cameraManImage;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UILabel *works;
@property (nonatomic, strong) UILabel *subscribeCount;
@property (nonatomic, strong) UILabel *commentCount;

@end
