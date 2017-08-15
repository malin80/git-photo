//
//  AlertDialog.h
//  PengPeng
//
//  Created by duanly on 11/30/15.
//  Copyright © 2015 贵阳朗玛信息技术股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 提示框动作风格
 */
typedef NS_ENUM(NSInteger, AlertActionStyle) {
    AlertActionStyleDefault = 0, // 默认
    AlertActionStyleCancel,      // 取消
    AlertActionStyleDestructive  // 加红警示
};

/**
 * 提示框风格
 */
typedef NS_ENUM(NSInteger, AlertDialogStyle) {
    AlertDialogStyleAlert = 0,  // 对话框 
    AlertDialogStyleActionSheet // 上拉菜单
};

/**
 * 提示框动作
 */
@interface AlertAction : NSObject

/**
 * 静态初始化方法
 *
 * @param title 动作标题
 * @param style 动作风格
 * @param handler 动作事件
 */
+ (instancetype)title:(NSString *)title style:(AlertActionStyle)style handler:(void (^)())handler;

/**
 * 动作标题
 */
@property (nonatomic, readonly) NSString *title;

/**
 * 动作风格
 */
@property (nonatomic, readonly) AlertActionStyle style;

/**
 * 动作事件
 */
@property (nonatomic, readonly) void (^handler)();

@end

/**
 * 提示框
 */
@interface AlertDialog : NSObject

/**
 * 提示框标题
 */
@property (nonatomic, retain) NSString *title;

/**
 * 提示框消息，当style为AlertDialogStyleActionSheet时，在低于iOS 8的系统上会忽略该参数
 */
@property (nonatomic, retain) NSString *message;

/**
 * 静态初始化方法
 *
 * @param style 提示框风格
 */
+ (instancetype)style:(AlertDialogStyle)style;

/**
 * 初始化方法
 *
 * @param style 提示框风格
 */
- (instancetype)initWithStyle:(AlertDialogStyle)style;

/**
 * 添加提示框动作
 *
 * @param action 提示框动作
 */
- (void)addAction:(AlertAction *)action;

/**
 * 显示提示框
 *
 * @param parentViewController 将显示提示框的UIViewController对象
 */
- (void)show:(UIViewController *)parentViewController;

- (void)showAlertView;

/**
 * 关闭对话框
 *
 * @param animated 关闭时是否有动画
 */
- (void)dismiss:(BOOL)animated;

@end
