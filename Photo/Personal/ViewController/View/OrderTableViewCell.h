//
//  OrderTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/7/31.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderTableViewCellDelegate <NSObject>

@optional
- (void)cancelButtonClick:(UIButton *)sender;
- (void)backButtonClick:(UIButton *)sender;
- (void)payButtonClick:(UIButton *)sender;
- (void)deleteButtonClick:(UIButton *)sender;

@end

@interface OrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *goodsImage;
@property (nonatomic, strong) UILabel *goodsNamme;
@property (nonatomic, strong) UILabel *goodsParameter;
@property (nonatomic, strong) UILabel *goodsNumber;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *goodsCount;
@property (nonatomic, strong) UILabel *goodsPrice;
@property (nonatomic, strong) UILabel *goodsState;
@property (nonatomic, strong) UIView *buttonBackView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *payButton;
@property (nonatomic, strong) UIButton *deleteButton;

@property(nonatomic, weak)  id<OrderTableViewCellDelegate> delegate;


@end
