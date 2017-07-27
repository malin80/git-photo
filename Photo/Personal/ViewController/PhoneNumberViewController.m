//
//  PhoneNumberViewController.m
//  Photo
//
//  Created by malin  on 2017/7/27.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "PhoneNumberViewController.h"

#import "NavigationBar.h"
#import "Masonry.h"

@interface PhoneNumberViewController () <NavigationBarDelegate, UITextFieldDelegate>
{
    UITextField *_phoneFieldText;
    UIView *_topLine;
    UIView *_bottomLine;
}

@end

@implementation PhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:@"修改手机号码"];
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

    _phoneFieldText = [[UITextField alloc] init];
    _phoneFieldText.textColor = [UIColor blackColor];
    _phoneFieldText.font = [UIFont boldSystemFontOfSize:13];
    _phoneFieldText.keyboardType = UIKeyboardTypeEmailAddress;
    _phoneFieldText.delegate = self;
    _phoneFieldText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneFieldText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneFieldText.placeholder = @"请输入手机号";
    _phoneFieldText.returnKeyType = UIReturnKeyDone;
    _phoneFieldText.backgroundColor = [UIColor whiteColor];
    [_phoneFieldText becomeFirstResponder];
    [self.view addSubview:_phoneFieldText];
    
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
    
    [_phoneFieldText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom);
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(41));
        make.left.equalTo(self.view.mas_left);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneFieldText.mas_bottom);
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
