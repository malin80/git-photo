//
//  HomePageScrollView.h
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageInfo.h"

@protocol HomePageScrollViewDelegate <NSObject>

@optional
- (void)tapScrollView:(ImageInfo *)info;

@end

@interface HomePageScrollView : UIView

@property(nonatomic, weak)  id<HomePageScrollViewDelegate> delegate;


-(id)initWithFrame:(CGRect)frame withIsHomePage:(BOOL)isHomePage;

@end
