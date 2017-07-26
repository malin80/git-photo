//
//  CustomActionSheet.h
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomActionSheetDelegate <NSObject>

@optional
- (void)showActionSheet;

@end


@interface CustomActionSheet : UIView
{
    int _count;
    UIImageView *_actionViewBg;

}

+ (CustomActionSheet *)createShareActionSheet;

@property(nonatomic, weak) id<CustomActionSheetDelegate> delegate;

-(void)showCustomActionSheet;

@end
