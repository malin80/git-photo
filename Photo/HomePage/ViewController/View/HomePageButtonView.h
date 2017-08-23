//
//  HomePageButtonView.h
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomePageButtonViewDelegate <NSObject>

@optional

- (void)touchCameraButton;
- (void)touchWeddingButton;

@end


@interface HomePageButtonView : UIView

@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, strong) UIButton *weddingButton;
@property (nonatomic, strong) UILabel *weddingLabel;
@property (nonatomic, strong) UIButton *carButton;
@property (nonatomic, strong) UIButton *flowerButton;
@property (nonatomic, strong) UILabel *flowerLabel;
@property (nonatomic, strong) UIButton *hotelButton;
@property (nonatomic, strong) UILabel *hotelLabel;
@property (nonatomic, strong) UIButton *videoButton;
@property (nonatomic, strong) UILabel *videoLabel;
@property (nonatomic, strong) UIButton *clothButton;
@property (nonatomic, strong) UILabel *clothLabel;
@property (nonatomic, strong) UIButton *moreButton;

@property(nonatomic,assign) id<HomePageButtonViewDelegate> delegate;



@end
