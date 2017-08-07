//
//  UserNameViewController.m
//  Photo
//
//  Created by malin  on 2017/7/27.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "UserNameViewController.h"

#import "NavigationBar.h"
#import "Masonry.h"
#import "PersonalManager.h"
#import "LoginManager.h"

@interface UserNameViewController () <NavigationBarDelegate, UITextFieldDelegate>
{
    UITextField *_nameTextField;
    UIView *_topLine;
    UIView *_bottomLine;
}

@end

@implementation UserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:@"修改昵称"];
    [bar setRightButtonTitle:@"完成"];
    bar.delegate = self;
    [self.view addSubview:bar];
    
    [self initView];
    [self setImmutableConstraints];
}

- (void)initView {
    _topLine = [[UIView alloc] init];
    _topLine.backgroundColor = [UIColor redColor];
    [self.view addSubview:_topLine];
    
    _nameTextField = [[UITextField alloc] init];
    _nameTextField.textColor = [UIColor blackColor];
    _nameTextField.font = [UIFont boldSystemFontOfSize:13];
    _nameTextField.keyboardType = UIKeyboardTypeEmailAddress;
    _nameTextField.delegate = self;
    _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nameTextField.placeholder = @"请输入姓名";
    _nameTextField.returnKeyType = UIReturnKeyDone;
    _nameTextField.backgroundColor = [UIColor whiteColor];
    [_nameTextField becomeFirstResponder];
    [self.view addSubview:_nameTextField];
    
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:_bottomLine];
}

- (void)setImmutableConstraints {
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.width.equalTo(@(ScreenWidth));
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@(1));
    }];
    
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom);
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(41));
        make.left.equalTo(self.view.mas_left);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameTextField.mas_bottom);
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(1));
        make.left.equalTo(self.view.mas_left);
    }];
}

#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)completeClick {
    LoginManager *manager = GET_SINGLETON_FOR_CLASS(LoginManager);
    [GET_SINGLETON_FOR_CLASS(PersonalManager) updateMemberInfoWithNickName:manager.memberInfo.memberNickName withMemberName:_nameTextField.text withMemberSex:manager.memberInfo.memberSex withMemberMarry:manager.memberInfo.memberMarry withMemberBirthday:manager.memberInfo.memberBirthday withToken:manager.memberInfo.safeCodeValue];

    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
