//
//  AddGoodsToShoppingViewController.m
//  Photo
//
//  Created by malin  on 2017/8/4.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "AddGoodsToShoppingViewController.h"
#import "ConfirmOrderViewController.h"

#import "StoreManager.h"
#import "LoginManager.h"

#import "NavigationBar.h"
#import "Masonry.h"

@interface AddGoodsToShoppingViewController () <NavigationBarDelegate>

@property (nonatomic, assign) NSInteger countNumber;

@property (nonatomic, strong) UILabel *line1;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *goodsTypeText;
@property (nonatomic, strong) UILabel *countTitle;
@property (nonatomic, strong) UIButton *minus;
@property (nonatomic, strong) UIButton *add;
@property (nonatomic, strong) UILabel *count;
@property (nonatomic, strong) UILabel *line2;
@property (nonatomic, strong) UILabel *goodsType;
@property (nonatomic, strong) UIButton *goodsSubType;
@property (nonatomic, strong) UIButton *confirm;

@end

@implementation AddGoodsToShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    NSString *string = @"";
    if (self.isBuy) {
        string = @"购买商品";
    } else {
        string = @"添加到购物车";
    }
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:string];
    bar.delegate = self;
    [self.view addSubview:bar];
    
    [self initView];
    [self setImmutableConstraints];
    
    self.countNumber = 1;
}

- (void)initView {
    [self.view addSubview:self.line1];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.price];
    [self.view addSubview:self.goodsTypeText];
    [self.view addSubview:self.countTitle];
    [self.view addSubview:self.minus];
    [self.view addSubview:self.add];
    [self.view addSubview:self.count];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.goodsType];
    [self.view addSubview:self.goodsSubType];
    [self.view addSubview:self.confirm];
}

- (void)setImmutableConstraints {
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(74);
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.width.equalTo(@(100));
        make.height.equalTo(@(100));
    }];
    
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_top).with.offset(5);
        make.left.equalTo(_imageView.mas_right).with.offset(15);
    }];
    
    [_goodsTypeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_price.mas_left);
        make.centerY.equalTo(_imageView);
    }];
    
    [_countTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_imageView.mas_bottom);
        make.left.equalTo(_price.mas_left);
    }];
    
    [_add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.top.equalTo(_countTitle);
        make.height.equalTo(@(30));
        make.width.equalTo(@(30));
    }];
    
    [_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_add.mas_left).with.offset(-20);
        make.top.equalTo(_countTitle);
    }];
    
    [_minus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_count.mas_right).with.offset(-20);
        make.top.equalTo(_countTitle);
        make.height.equalTo(@(30));
        make.width.equalTo(@(30));
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_countTitle.mas_bottom).with.offset(10);
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(1));
    }];
    
    [_goodsType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1.mas_bottom).with.offset(25);
        make.left.equalTo(_imageView.mas_left);
    }];
    
    [_goodsSubType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsType.mas_bottom).with.offset(25);
        make.left.equalTo(_imageView.mas_left);
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsSubType.mas_bottom).with.offset(10);
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(1));
    }];
    
    [_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(40));
    }];
}

#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark --- getters and setters ---
- (UILabel *)line1 {
    if (!_line1) {
        _line1 = [[UILabel alloc] init];
        _line1.backgroundColor = [UIColor colorR:222 G:223 B:222 alpha:1];
    }
    return _line1;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,self.info.goodsPic]];
        UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
        _imageView.image = imgFromUrl;
    }
    return _imageView;
}

- (UILabel *)price {
    if (!_price) {
        _price = [[UILabel alloc] init];
        _price.text = [NSString stringWithFormat:@"¥ %ld",self.info.goodsPrice];;
        _price.textColor = [UIColor colorR:237 G:147 B:73 alpha:1];
        _price.font = [UIFont systemFontOfSize:16];
        [_price sizeToFit];
    }
    return _price;
}

- (UILabel *)goodsTypeText {
    if (!_goodsTypeText) {
        _goodsTypeText = [[UILabel alloc] init];
        _goodsTypeText.text = [NSString stringWithFormat:@"请选择   %@",self.info.goodsParamKey];
        _goodsTypeText.textColor = [UIColor colorR:62 G:65 B:64 alpha:1];
        _goodsTypeText.font = [UIFont systemFontOfSize:16];
        [_goodsTypeText sizeToFit];
    }
    return _goodsTypeText;
}

- (UILabel *)countTitle {
    if (!_countTitle) {
        _countTitle = [[UILabel alloc] init];
        _countTitle.text = @"购买数量";
        _countTitle.textColor = [UIColor colorR:62 G:65 B:64 alpha:1];
        _countTitle.font = [UIFont systemFontOfSize:16];
        [_countTitle sizeToFit];
    }
    return _countTitle;
}

- (UIButton *)minus {
    if (!_minus) {
        _minus = [[UIButton alloc] init];
        [_minus setImage:[UIImage imageNamed:@"store_number_sub"] forState:UIControlStateNormal];
        [_minus addTarget:self action:@selector(minusCount) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minus;
}

- (UIButton *)add {
    if (!_add) {
        _add = [[UIButton alloc] init];
        [_add setImage:[UIImage imageNamed:@"store_number_add"] forState:UIControlStateNormal];
        [_add addTarget:self action:@selector(addCount) forControlEvents:UIControlEventTouchUpInside];
    }
    return _add;
}


- (UILabel *)count {
    if (!_count) {
        _count = [[UILabel alloc] init];
        _count.textColor = [UIColor colorR:78 G:78 B:78 alpha:1];
        _count.text = @"1";
        [_count sizeToFit];
    }
    return _count;
}

- (UILabel *)line2 {
    if (!_line2) {
        _line2 = [[UILabel alloc] init];
        _line2.backgroundColor = [UIColor colorR:222 G:223 B:222 alpha:1];
    }
    return _line2;
}

- (UILabel *)goodsType {
    if (!_goodsType) {
        _goodsType = [[UILabel alloc] init];
        _goodsType.text = self.info.goodsParamKey;
        _goodsType.textColor = [UIColor colorR:114 G:114 B:114 alpha:1];
    }
    return _goodsType;
}

- (UIButton *)goodsSubType {
    if (!_goodsSubType) {
        _goodsSubType = [[UIButton alloc] init];
        _goodsSubType.layer.cornerRadius = 10.0f;
        [_goodsSubType setTitle:[NSString stringWithFormat:@"%@",self.info.goodsParamValue] forState:UIControlStateNormal];
        [_goodsSubType setTitleColor:[UIColor colorR:114 G:114 B:114 alpha:1] forState:UIControlStateNormal];
    }
    return _goodsSubType;
}

- (UIButton *)confirm {
    if (!_confirm) {
        _confirm = [[UIButton alloc] init];
        [_confirm setTitle:@"确定" forState:UIControlStateNormal];
        [_confirm setTitleColor:[UIColor colorR:255 G:243 B:217 alpha:1] forState:UIControlStateNormal];
        _confirm.backgroundColor = [UIColor colorR:254 G:102 B:0 alpha:1];
        [_confirm addTarget:self action:@selector(addGoodsToShopping) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirm;
}

#pragma mark --- button method ---
- (void)addGoodsToShopping {
    if (self.isBuy) {
        ConfirmOrderViewController *controller = [[ConfirmOrderViewController alloc] init];
        controller.goodsInfos = [NSArray arrayWithObject:self.info];
        [self.navigationController pushViewController:controller animated:NO];
    } else {
        NSString *string = [NSString stringWithFormat:@"%@:%@",self.info.goodsParamKey,self.info.goodsParamValue];
        [GET_SINGLETON_FOR_CLASS(StoreManager) addGoodsToShoppingWithGoodsCount:_count.text withGoodParam:string withSafeCodeValue:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue withGoodsId:self.info.goodsId];
        [self goBack];
    }
}

- (void)addCount {
    self.countNumber++;
    _count.text = [NSString stringWithFormat:@"%ld",(long)self.countNumber];
}

- (void)minusCount {
    self.countNumber--;
    _count.text = [NSString stringWithFormat:@"%ld",(long)self.countNumber];
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
