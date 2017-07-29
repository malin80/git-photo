//
//  LoginViewController.m
//  Photo
//
//  Created by malin  on 2017/7/27.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "LoginViewController.h"
#import "Masonry.h"

@interface LoginViewController ()
{
    UIImageView *_iconView;
    UITextField *_phoneTextField;
    UILabel *_seperateLine;
    UITextField *_identifyTextField;
    UIButton *_identifyButton;
    UIButton *_loginButton;
    UILabel *_orLabel;
    UIButton *_passwordLoginButton;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
    [self setImmutableConstraints];
}

- (void)initView {
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personal_login"]];
    _iconView.layer.cornerRadius = 10;
    [self.view addSubview:_iconView];
    
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.placeholder = @"请输入手机号码";
    _phoneTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_phoneTextField];
    
    _seperateLine = [[UILabel alloc] init];
    _seperateLine.backgroundColor = [UIColor redColor];
    [self.view addSubview:_seperateLine];
    
    _identifyTextField = [[UITextField alloc] init];
    _identifyTextField.placeholder = @"请输入验证码";
    _identifyTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_identifyTextField];
    
    _identifyButton = [[UIButton alloc] init];
    [_identifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _identifyButton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_identifyButton];
    
    _loginButton = [[UIButton alloc] init];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    _loginButton.backgroundColor = UIColorFromRGB(95, 193, 255, 1);
    [self.view addSubview:_loginButton];
    
    _orLabel = [[UILabel alloc] init];
    _orLabel.text = @"或";
    _orLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_orLabel];
    
    _passwordLoginButton = [[UIButton alloc] init];
    [_passwordLoginButton setTitle:@"账号密码登录" forState:UIControlStateNormal];
    _passwordLoginButton.layer.borderWidth = 2;
    _passwordLoginButton.layer.borderColor = [UIColorFromRGB(123, 199, 229, 1) CGColor];
    [_passwordLoginButton setTitleColor:UIColorFromRGB(71, 177, 215, 1) forState:UIControlStateNormal];
    [self.view addSubview:_passwordLoginButton];
}

- (void)setImmutableConstraints {
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(60);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(60));
        make.width.equalTo(@(60));
    }];
    
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconView.mas_bottom).with.offset(50);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(ScreenWidth *0.8));
        make.height.equalTo(@(40));
    }];
    
    [_seperateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneTextField.mas_bottom).with.offset(5);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(ScreenWidth *0.8));
        make.height.equalTo(@(1));
    }];
    
    [_identifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_seperateLine.mas_bottom).with.offset(5);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(ScreenWidth *0.8));
        make.height.equalTo(@(40));
    }];
    
    [_identifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_identifyTextField);
        make.right.equalTo(_identifyTextField.mas_right);
        make.height.equalTo(@(40));
        make.width.equalTo(@(60));
    }];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_identifyTextField.mas_bottom).with.offset(50);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(ScreenWidth *0.8));
        make.height.equalTo(@(40));
    }];
    
    [_orLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginButton.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(ScreenWidth *0.8));
        make.height.equalTo(@(10));
    }];
    
    [_passwordLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orLabel.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(ScreenWidth *0.8));
        make.height.equalTo(@(40));
    }];
}

- (void)login {
    
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
