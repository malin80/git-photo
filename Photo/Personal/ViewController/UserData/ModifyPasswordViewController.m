//
//  ModifyPasswordViewController.m
//  Photo
//
//  Created by malin  on 2017/7/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "Masonry.h"
#import "NavigationBar.h"
#import "LoginManager.h"
#import "PersonalManager.h"
#import "LoginInfo.h"

@interface ModifyPasswordViewController () <NavigationBarDelegate>
{
    LoginInfo *_info;
    
    UIImageView *_icon;
    UITextField *_phoneTextField;
    UILabel     *_line1;
    UITextField *_identifyTextField;
    UIButton    *_getIdentifyButton;
    UILabel     *_line2;
    UITextField *_passwordTextField;
    UIButton *_confirmButton;
    UILabel *_orLabel;
    UIButton *_oldPasswordButton;
}

@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:@"修改密码"];
    bar.delegate = self;
    [self.view addSubview:bar];

    [self initView];
    [self setImmutableConstraints];
    _info = [[LoginInfo alloc] init];
    _info.loginType = LoginTypeIdentifyCode;
}

- (void)initView {
    _icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personal_update_pwd"]];
    [self.view addSubview:_icon];
    
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.text = GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberPhone;
    _phoneTextField.textColor = [UIColor colorR:173 G:174 B:174 alpha:1];
    _phoneTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_phoneTextField];
    
    _line1 = [[UILabel alloc] init];
    _line1.backgroundColor = [UIColor colorR:237 G:237 B:237 alpha:1];
    [self.view addSubview:_line1];
    
    _identifyTextField = [[UITextField alloc] init];
    _identifyTextField.placeholder = @"请输入验证码";
    _identifyTextField.textColor = [UIColor colorR:173 G:174 B:174 alpha:1];
    _identifyTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_identifyTextField];
    
    _getIdentifyButton = [[UIButton alloc] init];
    [_getIdentifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getIdentifyButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _getIdentifyButton.backgroundColor = [UIColor colorR:95 G:193 B:255 alpha:1];
    _getIdentifyButton.layer.cornerRadius = 10;
    [_getIdentifyButton addTarget:self action:@selector(getIdentifyCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getIdentifyButton];
    
    _line2 = [[UILabel alloc] init];
    _line2.backgroundColor = [UIColor colorR:237 G:237 B:237 alpha:1];
    [self.view addSubview:_line2];

    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.placeholder = @"请输入新密码";
    _passwordTextField.textColor = [UIColor colorR:173 G:174 B:174 alpha:1];
    _passwordTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_passwordTextField];
    
    _confirmButton = [[UIButton alloc] init];
    [_confirmButton setTitle:@"修改密码" forState:UIControlStateNormal];
    _confirmButton.backgroundColor = UIColorFromRGB(95, 193, 255, 1);
    [_confirmButton addTarget:self action:@selector(updatePassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmButton];
    
    _orLabel = [[UILabel alloc] init];
    _orLabel.text = @"或";
    _orLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_orLabel];
    
    _oldPasswordButton = [[UIButton alloc] init];
    [_oldPasswordButton setTitle:@"旧密码验证" forState:UIControlStateNormal];
    _oldPasswordButton.layer.borderWidth = 2;
    _oldPasswordButton.layer.borderColor = [UIColorFromRGB(123, 199, 229, 1) CGColor];
    [_oldPasswordButton setTitleColor:UIColorFromRGB(71, 177, 215, 1) forState:UIControlStateNormal];
    [_oldPasswordButton addTarget:self action:@selector(modifyPwdWithOldPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_oldPasswordButton];
}

- (void)setImmutableConstraints {
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(80);
        make.height.equalTo(@(50));
        make.width.equalTo(@(50));
    }];
    
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_icon.mas_bottom).with.offset(30);
        make.height.equalTo(@(30));
        make.width.equalTo(@(ScreenWidth));
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_phoneTextField.mas_bottom).with.offset(5);
        make.height.equalTo(@(1));
        make.width.equalTo(@(ScreenWidth*0.8));
        make.centerX.equalTo(self.view);
    }];
    
    [_identifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_phoneTextField.mas_bottom).with.offset(20);
        make.height.equalTo(@(30));
        make.width.equalTo(@(ScreenWidth*0.8));
        make.centerX.equalTo(self.view);
    }];
    
    [_getIdentifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_identifyTextField);
        make.height.equalTo(@(30));
        make.width.equalTo(@(60));
        make.right.equalTo(_identifyTextField.mas_right).with.offset(-20);
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_identifyTextField.mas_bottom).with.offset(5);
        make.height.equalTo(@(1));
        make.width.equalTo(@(ScreenWidth*0.8));
        make.centerX.equalTo(self.view);
    }];
    
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_identifyTextField.mas_bottom).with.offset(20);
        make.height.equalTo(@(30));
        make.width.equalTo(@(ScreenWidth));
    }];
    
    [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_passwordTextField.mas_bottom).with.offset(40);
        make.width.equalTo(@(ScreenWidth*0.8));
        make.height.equalTo(@(40));
    }];
    
    [_orLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_confirmButton.mas_bottom).with.offset(20);
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(10));
    }];
    
    [_oldPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_orLabel.mas_bottom).with.offset(20);
        make.width.equalTo(@(ScreenWidth*0.8));
        make.height.equalTo(@(40));
    }];

}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark --- button method ---
- (void)getIdentifyCode {
    [GET_SINGLETON_FOR_CLASS(LoginManager) getLoginIdentifyCodeWithPhoneNumber:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberPhone];
}

- (void)updatePassword {
    LoginManager *manager = GET_SINGLETON_FOR_CLASS(LoginManager);
    [GET_SINGLETON_FOR_CLASS(PersonalManager) updatePasswordWithToke:manager.memberInfo.safeCodeValue withOldCode:_identifyTextField.text withNewCode:_passwordTextField.text wihhUpdateType:1];
}

- (void)modifyPwdWithOldPwd {
    if (_info.loginType == LoginTypeIdentifyCode) {
        _identifyTextField.placeholder = @"请输入旧密码";
        _getIdentifyButton.hidden = YES;
        [_oldPasswordButton setTitle:@"旧密码验证" forState:UIControlStateNormal];
        _info.loginType = LoginTypePassword;
    } else {
        _identifyTextField.placeholder = @"请输入验证码";
        _getIdentifyButton.hidden = NO;
        [_oldPasswordButton setTitle:@"验证码验证" forState:UIControlStateNormal];
        _info.loginType = LoginTypeIdentifyCode;
    }
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
