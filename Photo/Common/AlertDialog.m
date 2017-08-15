//
//  AlertDialog.m
//  PengPeng
//
//  Created by duanly on 11/30/15.
//  Copyright © 2015 贵阳朗玛信息技术股份有限公司. All rights reserved.
//

#import "AlertDialog.h"
#import "AppDelegate.h"

#define kIOS7AlertDialogRef @"kIOS7AlertDialogRef"

#pragma mark - AlertAction

@implementation AlertAction

- (instancetype)initWithTitle:(NSString *)title style:(AlertActionStyle)style handler:(void (^)())handler
{
    self = [super init];
    if (self) {
        _title = title;
        _style = style;
        _handler = handler;
    }
    return self;
}

+ (instancetype)title:(NSString *)title style:(AlertActionStyle)style handler:(void (^)())handler
{
    return [[AlertAction alloc] initWithTitle:title style:style handler:handler];
}

@end

#pragma mark - AlertDialog

@interface AlertDialog () <UIAlertViewDelegate, UIActionSheetDelegate>
{
    AlertDialogStyle _style;
    NSMutableArray<AlertAction *> *_actions;
    
    UIAlertController *_alertController;
    UIAlertView *_alertView;
    UIActionSheet *_actionSheet;
}
@end

@implementation AlertDialog

#pragma mark - Public methods
+ (instancetype)style:(AlertDialogStyle)style
{
    return [[AlertDialog alloc] initWithStyle:style];
}

- (instancetype)initWithStyle:(AlertDialogStyle)style
{
    self = [super init];
    if (self) {
        _style = style;
        _actions = [[NSMutableArray<AlertAction *> alloc] init];
    }
    return self;
}

- (void)addAction:(AlertAction *)action
{
    [_actions addObject:action];
}

- (void)show:(UIViewController *)parentViewController
{    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        [self showUIAlertController:parentViewController];
    }
    else {
        if (_style == AlertDialogStyleActionSheet) {
            [self showUIActionSheet];
        }
        else {
            [self showUIAlertView];
        }
    }
    NSLog(@"_alertController show done");
}

- (void)showAlertView
{
    if (_style == AlertDialogStyleActionSheet) {
        [self showUIActionSheet];
    }
    else {
        [self showUIAlertView];
    }
}

- (void)dismiss:(BOOL)animated
{
    if (_alertController) {
        [_alertController dismissViewControllerAnimated:animated completion:nil];
    }
    
    if (_alertView) {
        [_alertView dismissWithClickedButtonIndex:_alertView.cancelButtonIndex animated:animated];
    }
    
    if (_actionSheet) {
        [_actionSheet dismissWithClickedButtonIndex:_actionSheet.cancelButtonIndex animated:animated];
    }
}

#pragma mark - Private methods
- (void)showUIAlertController:(UIViewController *)parentViewController
{
    _alertController = [UIAlertController alertControllerWithTitle:self.title
                                                         message:self.message
                                                  preferredStyle:[self convertDialogStyle:_style]];
    for (AlertAction *alertAction in _actions) {
        [_alertController addAction:[UIAlertAction actionWithTitle:alertAction.title
                                                            style:[self convertActionStyle:alertAction.style]
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              if (alertAction.handler) {
                                                                  alertAction.handler();
                                                              }
                                                          }]];
    }
    
    [parentViewController presentViewController:_alertController animated:YES completion:nil];
}

- (void)showUIActionSheet
{
    // UIActionSheet构造函数中设置cancelButtonTitle，和destructiveButtonTitle的行为与UIAlertController不一致
    // 显示优先级为 destructiveButtonTitle -> cancelButtonTitle -> otherButtonTitles
    // 而UIAlertController中Cancel始终显示在底部，且与其他项有明显分割，Destructive可以指定为除Cancel外的任意一项
    _actionSheet = [[UIActionSheet alloc] initWithTitle:self.title
                                               delegate:self
                                      cancelButtonTitle:nil
                                 destructiveButtonTitle:nil
                                      otherButtonTitles:nil, nil];
    // 验证Cancel是否唯一，并将Cancel设为最后一个
    AlertAction *cancelAction = nil;
    for (AlertAction *alertAction in _actions) {
        if (alertAction.style == AlertActionStyleCancel) {
            if (!cancelAction) {
                cancelAction = alertAction;
            }
            else {
                @throw [NSException exceptionWithName:@"NSInternalInconsistencyException"
                                               reason:@"AlertDialog can only have one action with a style of AlertActionStyleCancel"
                                             userInfo:nil];
            }
        }
    }
    if (cancelAction) {
        [_actions removeObject:cancelAction];
        [_actions addObject:cancelAction];
    }
    
    // 验证DestructiveIndex是否唯一，并获取其位置
    NSInteger destructiveIndex = -1;
    for (NSInteger i = 0; i < _actions.count; i++) {
        AlertAction *alertAction = _actions[i];
        if (alertAction.style == AlertActionStyleDestructive) {
            if (destructiveIndex == -1) {
                destructiveIndex = i; // 记录
            }
            else {
                @throw [NSException exceptionWithName:@"NSInternalInconsistencyException"
                                               reason:@"AlertDialog can only have one action with a style of AlertActionStyleDestructive"
                                             userInfo:nil];
            }
        }
    }
    
    // 添加所有按钮
    for (AlertAction *alertAction in _actions) {
        [_actionSheet addButtonWithTitle:alertAction.title];
    }
    
    // 标识Cancel按钮index
    if (cancelAction) {
        _actionSheet.cancelButtonIndex = _actionSheet.numberOfButtons - 1;
    }
    
    // 标识Destructive按钮index
    if (destructiveIndex != -1) {
        _actionSheet.destructiveButtonIndex = destructiveIndex;
    }
    
    // 将其显示到 Window 上
    [_actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)showUIAlertView
{
    // 调整Cancel的位置到顶部，方便点击时通过索引获取
    AlertAction *cancelAction = nil;
    for (AlertAction *alertAction in _actions) {
        if (alertAction.style == AlertActionStyleCancel) {
            if (!cancelAction) {
                cancelAction = alertAction;
            }
            else {
                @throw [NSException exceptionWithName:@"异常使用" reason:@"只能包含一个style为Cancel的Action" userInfo:nil];
            }
        }
    }
    if (cancelAction) {
        [_actions removeObject:cancelAction];
        [_actions insertObject:cancelAction atIndex:0];
    }
    
    _alertView = [[UIAlertView alloc] initWithTitle:self.title
                                            message:self.message
                                           delegate:self
                                  cancelButtonTitle:cancelAction ? cancelAction.title : nil
                                  otherButtonTitles:nil, nil];
    
    // 添加其他按钮
    for (AlertAction *alertAction in _actions) {
        if (alertAction.style != AlertActionStyleCancel) {
            [_alertView addButtonWithTitle:alertAction.title];
        }
    }
    
    [_alertView show];
}

#pragma mark - UIAlertViewDelegate (before iOS 8)

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AlertAction *action = _actions[buttonIndex];
    if (action.handler) {
        action.handler();
    }
}

#pragma mark - UIActionSheetDelegate (before iOS 8)

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AlertAction *action = _actions[buttonIndex];
    if (action.handler) {
        action.handler();
    }
}


#pragma mark - Others
- (UIAlertControllerStyle)convertDialogStyle:(AlertDialogStyle)style
{
    switch (style) {
        case AlertDialogStyleActionSheet:
            return UIAlertControllerStyleActionSheet;

        default:
            return UIAlertControllerStyleAlert;
    }
}

- (UIAlertActionStyle)convertActionStyle:(AlertActionStyle)style
{
    switch (style) {
        case AlertActionStyleCancel:
            return UIAlertActionStyleCancel;
        
        case AlertActionStyleDestructive:
            return UIAlertActionStyleDestructive;
            
        default:
            return UIAlertActionStyleDefault;
    }
}

@end
