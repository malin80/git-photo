//
//  BuyClothViewController.m
//  Photo
//
//  Created by malin  on 2017/8/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "BuyClothViewController.h"
#import "NavigationBar.h"
#import "SDWebImageCache.h"
#import "ClothManager.h"
#import "LoginManager.h"

@interface BuyClothViewController () <NavigationBarDelegate>
{
    UIImageView *_clothView;
    UILabel *_priceLabel;
    UILabel *_paramLabel;
    UILabel *_countLabel;
    UIButton *_minusBtn;
    UIButton *_addBtn;
    UILabel *_countDetailLabel;
    UILabel *_line;
    NSInteger _countNumber;
    
    UILabel *_colorLabel;
    UIButton *_colorParamButton;
    UILabel *_sizeLabel;
    UIButton *_sizeParamButton;
    UILabel *_line1;
}

@property (nonatomic, strong) UIButton *lastColorButton;
@property (nonatomic, strong) UIButton *selectedColorButton;
@property (nonatomic, strong) UIButton *lastSizeButton;
@property (nonatomic, strong) UIButton *selectedSizeButton;

@end

@implementation BuyClothViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"选择产品参数"];
    bar.delegate = self;
    bar.line.hidden=YES;
    [self.view addSubview:bar];
    
    _countNumber = 1;
    [self createHeaderView];
    [self createBottomView];
}

- (void)createHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 150)];
    [self.view addSubview:headerView];
    _clothView = [[UIImageView alloc] init];
    [headerView addSubview:_clothView];
    [_clothView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(10);
        make.centerY.equalTo(headerView);
        make.height.equalTo(@(80));
        make.width.equalTo(@(80));
    }];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,self.info.clothPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        _clothView.image = image;
    }];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.text = [NSString stringWithFormat:@"¥%ld",self.info.clothPrice];
    _priceLabel.textColor = [UIColor colorR:234 G:149 B:84 alpha:1];
    _priceLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_clothView.mas_top);
        make.left.equalTo(_clothView.mas_right).with.offset(10);
    }];
    
    _paramLabel = [[UILabel alloc] init];
    _paramLabel.text = @"请选择 颜色 尺码";
    [headerView addSubview:_paramLabel];
    [_paramLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLabel);
        make.centerY.equalTo(_clothView);
    }];
    
    _countLabel = [[UILabel alloc] init];
    _countLabel.text = @"购买数量";
    [headerView addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_clothView.mas_bottom);
        make.left.equalTo(_priceLabel);
    }];
    
    _minusBtn = [[UIButton alloc] init];
    [_minusBtn setImage:[UIImage imageNamed:@"store_number_sub"] forState:UIControlStateNormal];
    [_minusBtn addTarget:self action:@selector(minusCount) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_minusBtn];

    _addBtn = [[UIButton alloc] init];
    [_addBtn setImage:[UIImage imageNamed:@"store_number_add"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addCount) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_addBtn];

    _countDetailLabel = [[UILabel alloc] init];
    _countDetailLabel.textColor = [UIColor colorR:78 G:78 B:78 alpha:1];
    _countDetailLabel.text = @"1";
    [_countDetailLabel sizeToFit];
    [headerView addSubview:_countDetailLabel];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView.mas_right).with.offset(-20);
        make.top.equalTo(_countLabel);
        make.height.equalTo(@(30));
        make.width.equalTo(@(30));
    }];
    
    [_countDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_addBtn.mas_left).with.offset(-20);
        make.top.equalTo(_countLabel);
    }];
    
    [_minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_countDetailLabel.mas_right).with.offset(-20);
        make.top.equalTo(_countLabel);
        make.height.equalTo(@(30));
        make.width.equalTo(@(30));
    }];
    
    _line = [[UILabel alloc] init];
    _line.backgroundColor = [UIColor colorR:241 G:241 B:241 alpha:1];
    [headerView addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_clothView.mas_bottom).with.offset(10);
        make.left.equalTo(_clothView.mas_left);
        make.right.equalTo(_addBtn.mas_right);
        make.height.equalTo(@(1));
    }];
}

- (void)createBottomView {
    _colorLabel = [[UILabel alloc] init];
    _colorLabel.text = @"颜色";
    [self.view addSubview:_colorLabel];
    [_colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_clothView.mas_bottom).with.offset(20);
        make.left.equalTo(_clothView.mas_left);
    }];
    
    NSArray *temp = [self.info.clothParam componentsSeparatedByString:@";"];
    NSArray *color = [temp[0] componentsSeparatedByString:@","];
    for (int i = 0; i<color.count; i++) {
        _colorParamButton = [[UIButton alloc] init];
        [_colorParamButton setTitle:[NSString stringWithFormat:@"%@",color[i]] forState:UIControlStateNormal];
        _colorParamButton.titleLabel.numberOfLines = 0;
        _colorParamButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_colorParamButton setTitleColor:[UIColor colorR:114 G:114 B:114 alpha:1] forState:UIControlStateNormal];
        _colorParamButton.layer.cornerRadius = 10;
        _colorParamButton.layer.borderWidth = 0.5;
        _colorParamButton.layer.borderColor = [[UIColor colorR:224 G:224 B:224 alpha:1] CGColor];
        _colorParamButton.backgroundColor = [UIColor colorR:250 G:250 B:250 alpha:1];
        [_colorParamButton addTarget:self action:@selector(selectColorParamType:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_colorParamButton];
        [_colorParamButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_colorLabel.mas_bottom).with.offset(10+(i/3)*70);
            make.left.equalTo(_colorLabel.mas_left).with.offset(i%3*120);
            make.height.equalTo(@(50));
            make.width.equalTo(@(100));
        }];
    }
    
    _sizeLabel = [[UILabel alloc] init];
    _sizeLabel.text = @"尺寸";
    [self.view addSubview:_sizeLabel];
    [_sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_colorParamButton.mas_bottom).with.offset(10);
        make.left.equalTo(_colorLabel);
    }];
    
    NSArray *size = [temp[1] componentsSeparatedByString:@","];
    for (int i = 0; i<size.count; i++) {
        _sizeParamButton = [[UIButton alloc] init];
        [_sizeParamButton setTitle:[NSString stringWithFormat:@"%@",size[i]] forState:UIControlStateNormal];
        _sizeParamButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_sizeParamButton setTitleColor:[UIColor colorR:114 G:114 B:114 alpha:1] forState:UIControlStateNormal];
        _sizeParamButton.layer.cornerRadius = 8;
        _sizeParamButton.layer.borderWidth = 0.5;
        _sizeParamButton.layer.borderColor = [[UIColor colorR:224 G:224 B:224 alpha:1] CGColor];
        _sizeParamButton.backgroundColor = [UIColor colorR:250 G:250 B:250 alpha:1];
        [_sizeParamButton addTarget:self action:@selector(selectSizeParamType:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_sizeParamButton];
        [_sizeParamButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_sizeLabel.mas_bottom).with.offset(10+(i/6)*50);
            make.left.equalTo(_sizeLabel.mas_left).with.offset(i%6*60);
            make.height.equalTo(@(30));
            make.width.equalTo(@(50));
        }];
    }
    
    _line1 = [[UILabel alloc] init];
    _line1.backgroundColor = [UIColor colorR:241 G:241 B:241 alpha:1];
    [self.view addSubview:_line1];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sizeParamButton.mas_bottom).with.offset(10);
        make.left.equalTo(_clothView.mas_left);
        make.right.equalTo(_addBtn.mas_right);
        make.height.equalTo(@(1));
    }];

    UIButton *bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHieght-50, ScreenWidth, 50)];
    bottomButton.backgroundColor = [UIColor colorR:255 G:102 B:1 alpha:1];
    [bottomButton setTitle:@"确定" forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(buyClothClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
}

- (void)buyClothClick {
    [GET_SINGLETON_FOR_CLASS(ClothManager) buyClothWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue withClothId:self.info.clothId withClothCount:_countNumber];
}

- (void)selectColorParamType:(UIButton *)sender {
    if (sender == self.selectedColorButton) {

    } else {
        self.selectedColorButton = sender;
        self.selectedColorButton.backgroundColor = [UIColor colorR:254 G:102 B:0 alpha:1];
        self.lastColorButton.backgroundColor = [UIColor colorR:250 G:250 B:250 alpha:1];
    }
    self.lastColorButton = sender;
}

- (void)selectSizeParamType:(UIButton *)sender {
    if (sender == self.selectedSizeButton) {
        
    } else {
        self.selectedSizeButton = sender;
        self.selectedSizeButton.backgroundColor = [UIColor colorR:254 G:102 B:0 alpha:1];
        self.lastSizeButton.backgroundColor = [UIColor colorR:250 G:250 B:250 alpha:1];
    }
    self.lastSizeButton = sender;
}

- (void)addCount {
    _countNumber++;
    _countDetailLabel.text = [NSString stringWithFormat:@"%ld",(long)_countNumber];
}

- (void)minusCount {
    _countNumber--;
    _countDetailLabel.text = [NSString stringWithFormat:@"%ld",(long)_countNumber];
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
