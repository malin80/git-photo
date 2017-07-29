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

@interface ModifyPasswordViewController () <NavigationBarDelegate>
{
    UIImageView *_icon;
    UITextField *_phoneTextField;
    UITextField *_identifyTextField;
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
}

- (void)initView {
    _icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personal_update_pwd"]];
    [self.view addSubview:_icon];
    
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.text = @"13885229434";
    _phoneTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_phoneTextField];
    
    _identifyTextField = [[UITextField alloc] init];
    _identifyTextField.text = @"请输入验证码";
    _identifyTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_identifyTextField];
    
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.text = @"请输入密码";
    _passwordTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_passwordTextField];
    
    _confirmButton = [[UIButton alloc] init];
    [_confirmButton setTitle:@"修改密码" forState:UIControlStateNormal];
    _confirmButton.backgroundColor = UIColorFromRGB(95, 193, 255, 1);
    [self.view addSubview:_confirmButton];
    
    _orLabel = [[UILabel alloc] init];
    _orLabel.text = @"或";
    _orLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_orLabel];
    
    _oldPasswordButton = [[UIButton alloc] init];
    [_oldPasswordButton setTitle:@"旧密码登录" forState:UIControlStateNormal];
    _oldPasswordButton.layer.borderWidth = 2;
    _oldPasswordButton.layer.borderColor = [UIColorFromRGB(123, 199, 229, 1) CGColor];
    [_oldPasswordButton setTitleColor:UIColorFromRGB(71, 177, 215, 1) forState:UIControlStateNormal];
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
    
    [_identifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_phoneTextField.mas_bottom).with.offset(20);
        make.height.equalTo(@(30));
        make.width.equalTo(@(ScreenWidth));
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
        make.width.equalTo(@(120));
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
        make.width.equalTo(@(120));
        make.height.equalTo(@(40));
    }];

}

- (void)goBack {
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
