//
//  LoginViewController.m
//  Photo
//
//  Created by malin  on 2017/7/27.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "LoginViewController.h"
#import "Masonry.h"
#import "LoginInfo.h"
#import "LoginManager.h"

@interface LoginViewController () <LoginManagerDelegate>
{
    UIImageView *_iconView;
    UITextField *_phoneTextField;
    UILabel *_seperateLine;
    UITextField *_identifyTextField;
    UIButton *_identifyButton;
    UIButton *_loginButton;
    UILabel *_orLabel;
    UIButton *_passwordLoginButton;
    UIImageView *_backView;
    
    NSTimer *_verifyTimer;
    int16_t _countdown;
}

@property (nonatomic, strong) LoginInfo *loginInfo;
@property (nonatomic, strong) LoginManager *loginManager;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
    [self setImmutableConstraints];
    
    self.loginInfo = [[LoginInfo alloc] init];
    self.loginInfo.loginType = LoginTypePassword;
}

- (void)initView {
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personal_login"]];
    _iconView.layer.cornerRadius = 10;
    [self.view addSubview:_iconView];
    
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.placeholder = @"请输入手机号码";
    _phoneTextField.textAlignment = NSTextAlignmentCenter;
    _phoneTextField.textColor = UIColorFromRGB(146, 146, 146, 1);
    [self.view addSubview:_phoneTextField];
    
    _seperateLine = [[UILabel alloc] init];
    _seperateLine.backgroundColor = UIColorFromRGB(223, 223, 223, 1);
    [self.view addSubview:_seperateLine];
    
    _identifyTextField = [[UITextField alloc] init];
    _identifyTextField.placeholder = @"请输入密码";
    _identifyTextField.textAlignment = NSTextAlignmentCenter;
    _identifyTextField.textColor = UIColorFromRGB(146, 146, 146, 1);
    [self.view addSubview:_identifyTextField];
    
    _identifyButton = [[UIButton alloc] init];
    [_identifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _identifyButton.hidden = YES;
    _identifyButton.backgroundColor = UIColorFromRGB(95, 193, 255, 1);
    [_identifyButton addTarget:self action:@selector(getIdentifyCode) forControlEvents:UIControlEventTouchUpInside];
    _identifyButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _identifyButton.layer.cornerRadius = 10;
    [self.view addSubview:_identifyButton];
    
    _loginButton = [[UIButton alloc] init];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    _loginButton.backgroundColor = UIColorFromRGB(95, 193, 255, 1);
    [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    _orLabel = [[UILabel alloc] init];
    _orLabel.text = @"或";
    _orLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_orLabel];
    
    _passwordLoginButton = [[UIButton alloc] init];
    [_passwordLoginButton setTitle:@"验证码登录" forState:UIControlStateNormal];
    _passwordLoginButton.layer.borderWidth = 2;
    _passwordLoginButton.layer.borderColor = [UIColorFromRGB(123, 199, 229, 1) CGColor];
    [_passwordLoginButton setTitleColor:UIColorFromRGB(71, 177, 215, 1) forState:UIControlStateNormal];
    [_passwordLoginButton addTarget:self action:@selector(loginWithPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_passwordLoginButton];
    
    _backView = [[UIImageView alloc] init];
    _backView.image = [UIImage imageNamed:@"common_back"];
    _backView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginViewControllerGoBack)];
    [_backView addGestureRecognizer:tap];
    if (GET_SINGLETON_FOR_CLASS(LoginManager).loginOut) {
        [self.view addSubview:_backView];

        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(20);
            make.left.equalTo(self.view.mas_left).with.offset(15);
            make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];
    }
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
        make.centerY.equalTo(_identifyTextField);
        make.right.equalTo(_identifyTextField.mas_right);
        make.height.equalTo(@(30));
        make.width.equalTo(@(80));
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
    NSString *app_uuid = @"";
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef uuidString = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    app_uuid = [NSString stringWithString:(__bridge NSString *)uuidString];
    
    [self.loginManager loginWithPhoneNumber:_phoneTextField.text withIdentifyCode:_identifyTextField.text withLoginType:self.loginInfo.loginType withAppId:app_uuid];
}

- (void)loginWithPassword {
    if (self.loginInfo.loginType == LoginTypeIdentifyCode) {
        _identifyTextField.placeholder = @"请输入密码";
        _identifyTextField.secureTextEntry = YES;
        _identifyButton.hidden = YES;
        [_passwordLoginButton setTitle:@"验证码登录" forState:UIControlStateNormal];
        self.loginInfo.loginType = LoginTypePassword;
    } else {
        _identifyTextField.placeholder = @"请输入验证码";
        _identifyTextField.secureTextEntry = NO;
        _identifyButton.hidden = NO;
        [_passwordLoginButton setTitle:@"账号密码登录" forState:UIControlStateNormal];
        self.loginInfo.loginType = LoginTypeIdentifyCode;
    }
}

- (void)getIdentifyCode {
    if (_phoneTextField.text.length == 11) {
        [self startVerifyTimer];
        self.loginInfo.loginType = LoginTypeIdentifyCode;
        [self.loginManager getLoginIdentifyCodeWithPhoneNumber:_phoneTextField.text];
    } else {
        [self showtext:@"请输入正确的手机号码"];
    }
}

- (void)loginViewControllerGoBack {
    if ([self.delegate respondsToSelector:@selector(loginViewControllerGoBack)]) {
        [self.delegate loginViewControllerGoBack];
    }
}

- (void)startVerifyTimer
{
    _countdown = 60;
    [_identifyButton setTitle:[NSString stringWithFormat:@"%d秒后重发",_countdown] forState:UIControlStateDisabled];
    _identifyButton.enabled = NO;
    if (_verifyTimer) {
        [_verifyTimer invalidate];
        _verifyTimer = nil;
    }
    _verifyTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
}

- (void)updateCountDown
{
    _countdown--;
    if (_countdown < 0) {
        [self stopCountdownTimer];
        [_identifyButton setTitle:@"重新发送" forState:UIControlStateNormal];
        _identifyButton.enabled = YES;
    } else {
        [_identifyButton setTitle:[NSString stringWithFormat:@"%d秒后重发",_countdown] forState:UIControlStateDisabled];
        _identifyButton.enabled = NO;
    }
}

- (void)stopCountdownTimer
{
    if (_verifyTimer) {
        [_verifyTimer invalidate];
        _verifyTimer = nil;
    }
}


#pragma mark --- LoginManagerDelegate ---
- (void)loginSuccess {
    self.block();
}

- (void)loginFaield {
    [self showtext:@"登录失败，请重新登录"];
}

#pragma mark --- getters and setters ---
- (LoginManager *)loginManager {
    if (!_loginManager) {
        _loginManager = [[LoginManager alloc] init];
        _loginManager.delegate = self;
    }
    return _loginManager;
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
