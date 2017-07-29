//
//  EditAddressViewController.m
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "EditAddressViewController.h"

#import "NavigationBar.h"
#import "Masonry.h"

@interface EditAddressViewController () <NavigationBarDelegate, UITextViewDelegate>

@property (nonatomic, strong) NavigationBar *bar;
@property (nonatomic, strong) UIView *backView1;
@property (nonatomic, strong) UIView *backView2;
@property (nonatomic, strong) UIView *backView3;
@property (nonatomic, strong) UIView *backView4;
@property (nonatomic, strong) UILabel *title1;
@property (nonatomic, strong) UILabel *title2;
@property (nonatomic, strong) UILabel *title3;
@property (nonatomic, strong) UITextView *textView1;
@property (nonatomic, strong) UITextView *textView2;
@property (nonatomic, strong) UITextView *textView3;

@end

@implementation EditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:@"修改收货地址"];
    self.bar.delegate = self;
    [self.bar setRightButtonTitle:@"修改"];
    [self.view addSubview:self.bar];
    
    [self initView];
    [self setImmutableConstraints];
}

- (void)initView {
    self.backView1 = [[UIView alloc] init];
    self.backView1.layer.borderWidth = 1;
    self.backView1.layer.borderColor = [[UIColor grayColor] CGColor];
    self.backView2 = [[UIView alloc] init];
    self.backView2.layer.borderWidth = 1;
    self.backView2.layer.borderColor = [[UIColor grayColor] CGColor];
    self.backView3 = [[UIView alloc] init];
    self.backView3.layer.borderWidth = 1;
    self.backView3.layer.borderColor = [[UIColor grayColor] CGColor];
    self.backView4 = [[UIView alloc] init];
    self.backView4.layer.borderWidth = 1;
    self.backView4.layer.borderColor = [[UIColor grayColor] CGColor];

    self.title1 = [[UILabel alloc] init];
    self.title1.text = @"收货人";
    self.title2 = [[UILabel alloc] init];
    self.title2.text = @"联系电话";

    self.textView1 = [[UITextView alloc] init];
    self.textView1.delegate = self;
    self.textView1.returnKeyType = UIReturnKeySend;
    self.textView1.keyboardType = UIKeyboardTypeDefault;
    self.textView1.font = [UIFont systemFontOfSize:15];
    self.textView1.textColor = [UIColor blackColor];
    self.textView1.backgroundColor = [UIColor whiteColor];
    self.textView1.text = @"收货人是谁";
    self.textView1.scrollEnabled = NO;

    self.textView2 = [[UITextView alloc] init];
    self.textView2.delegate = self;
    self.textView2.returnKeyType = UIReturnKeySend;
    self.textView2.keyboardType = UIKeyboardTypeDefault;
    self.textView2.font = [UIFont systemFontOfSize:15];
    self.textView2.textColor = [UIColor blackColor];
    self.textView2.backgroundColor = [UIColor whiteColor];
    self.textView2.text = @"123456789";
    self.textView2.scrollEnabled = NO;

    self.textView3 = [[UITextView alloc] init];
    self.textView3.delegate = self;
    self.textView3.returnKeyType = UIReturnKeySend;
    self.textView3.keyboardType = UIKeyboardTypeDefault;
    self.textView3.font = [UIFont systemFontOfSize:15];
    self.textView3.textColor = [UIColor blackColor];
    self.textView3.backgroundColor = [UIColor whiteColor];
    self.textView3.text = @"这里输地址";
    self.textView3.scrollEnabled = NO;

    self.title3 = [[UILabel alloc] init];
    self.title3.text = @"设为默认";

    [self.view addSubview:self.backView1];
    [self.backView1 addSubview:self.title1];
    [self.backView1 addSubview:self.textView1];

    [self.view addSubview:self.backView2];
    [self.backView2 addSubview:self.title2];
    [self.backView2 addSubview:self.textView2];
    
    [self.view addSubview:self.backView3];
    [self.backView3 addSubview:self.textView3];
    
    [self.view addSubview:self.backView4];
    [self.backView4 addSubview:self.title3];
}

- (void)setImmutableConstraints {
    [self.backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bar.mas_bottom);
        make.height.equalTo(@(100));
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(@([[UIScreen mainScreen] bounds].size.width));
    }];
    
    [self.title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView1);
        make.left.equalTo(self.backView1.mas_left).with.offset(20);
        make.height.equalTo(@(100));
        make.width.equalTo(@(80));
    }];
    
    [self.textView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView1);
        make.left.equalTo(self.title1.mas_right);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(30));
    }];
    
    [self.backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView1.mas_bottom);
        make.height.equalTo(@(100));
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(@([[UIScreen mainScreen] bounds].size.width));
    }];
    
    [self.title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView2);
        make.left.equalTo(self.backView2.mas_left).with.offset(20);
        make.height.equalTo(@(100));
        make.width.equalTo(@(80));
    }];
    
    [self.textView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView2);
        make.left.equalTo(self.title2.mas_right);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(30));
    }];
    
    [self.backView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView2.mas_bottom);
        make.height.equalTo(@(100));
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(@([[UIScreen mainScreen] bounds].size.width));
    }];
    
    [self.textView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView3);
        make.left.equalTo(self.backView3.mas_left).with.offset(20);
        make.width.equalTo(@([[UIScreen mainScreen] bounds].size.width));
        make.height.equalTo(@(30));
    }];
    
    [self.backView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView3.mas_bottom).with.offset(10);
        make.height.equalTo(@(100));
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(@([[UIScreen mainScreen] bounds].size.width));
    }];
    
    [self.title3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView4);
        make.left.equalTo(self.backView4.mas_left).with.offset(20);
        make.height.equalTo(@(100));
        make.width.equalTo(@(80));
    }];

}

#pragma mark --- NavigationBarDelegate ---
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
