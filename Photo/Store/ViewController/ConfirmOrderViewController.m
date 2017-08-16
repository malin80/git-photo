//
//  ConfirmOrderViewController.m
//  Photo
//
//  Created by malin  on 2017/8/10.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "ShoppingTableViewCell.h"
#import "SelectAddressViewController.h"
#import "PersonalManager.h"
#import "AddressInfo.h"
#import "Masonry.h"
#import "NavigationBar.h"
#import "StoreManager.h"
#import "LoginManager.h"
#import "ShoppingGoodsInfo.h"
#import "SDWebImageCache.h"
#import "AlertDialog.h"
#import "AddAddressViewController.h"
#import "GGActionSheet.h"
@interface ConfirmOrderViewController () <GGActionSheetDelegate,NavigationBarDelegate,UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong) GGActionSheet *actionSheetImg;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GoodsInfo *goodsInfo;
@property (nonatomic, strong) AddressInfo *addressInfo;
@property (nonatomic, strong) UIView *addressView;

@end

@implementation ConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"确认订单"];
    bar.delegate = self;
    [self.view addSubview:bar];
    
    [self createTableView];
    [self createBottomView];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(alipay) name:@"alipay" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self createAddressView];
}

- (void)createAddressView {
    self.addressInfo = GET_SINGLETON_FOR_CLASS(PersonalManager).normalAddressInfo;
    if (self.addressInfo) {
        if (self.addressView) {
            [self.addressView removeFromSuperview];
        }
        self.addressView = [[UIView alloc] init];
        self.addressView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoEditAddress)];
        [self.addressView addGestureRecognizer:tap];
        [self.view addSubview:self.addressView];
        
        [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(70);
            make.left.equalTo(self.view.mas_left);
            make.width.equalTo(@(ScreenWidth));
            make.height.equalTo(@(100));
        }];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = [NSString stringWithFormat:@"收货人：%@",self.addressInfo.name];
        [self.addressView addSubview:nameLabel];
        
        UILabel *phoneLabel = [[UILabel alloc] init];
        phoneLabel.text = [NSString stringWithFormat:@"%@",self.addressInfo.phone];
        [self.addressView addSubview:phoneLabel];
        
        UILabel *addressLabel = [[UILabel alloc] init];
        addressLabel.text = [NSString stringWithFormat:@"收货地址：%@",self.addressInfo.address];
        [self.addressView addSubview:addressLabel];
        
        UIImageView *arrow = [[UIImageView alloc] init];
        arrow.image = [UIImage imageNamed:@"personal_forward"];
        [self.addressView addSubview:arrow];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.addressView.mas_left).with.offset(10);
            make.top.equalTo(self.addressView.mas_top).with.offset(10);
        }];
        
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel.mas_right).with.offset(30);
            make.top.equalTo(nameLabel);
        }];
        
        [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel);
            make.top.equalTo(nameLabel.mas_bottom).with.offset(20);
        }];
        
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(addressLabel);
            make.right.equalTo(self.addressView.mas_right).with.offset(-10);
            make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];
    } else {
        AlertDialog *dialog = [AlertDialog style:AlertDialogStyleAlert];
        dialog.title = @"设置收货地址";
        dialog.message = @"你还没有收货地址，请先添加收货地址！";
        [dialog addAction:[AlertAction title:@"添加地址" style:AlertActionStyleDefault handler:^{
            AddAddressViewController *controller = [[AddAddressViewController alloc] init];
            [self.navigationController pushViewController:controller animated:NO];
        }]];
        [dialog addAction:[AlertAction title:@"取消" style:AlertActionStyleCancel handler:^{
            [self.navigationController popViewControllerAnimated:NO];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelAddDress" object:nil];
        }]];
        [dialog show:self];
        
    }
}

- (void)gotoEditAddress {
    SelectAddressViewController *controller = [[SelectAddressViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)createBottomView {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(-1, ScreenHieght-40, ScreenWidth+2, 40)];
    bottomView.layer.borderWidth = 0.5;
    bottomView.layer.borderColor = [[UIColor colorR:246 G:246 B:246 alpha:1] CGColor];
    [self.view addSubview:bottomView];
    
    long goodsPrice = 0;
    for (GoodsInfo *info in self.goodsInfos) {
        goodsPrice = goodsPrice + info.goodsPrice;
    }
    UILabel *totalLabel = [[UILabel alloc] init];
    totalLabel.text = [NSString stringWithFormat:@"合计：%ld",goodsPrice];
    [bottomView addSubview:totalLabel];
    
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView).with.offset(10);
        make.centerY.equalTo(bottomView);
    }];
    
    UIButton *confirmButton = [[UIButton alloc] init];
    [confirmButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmOrder) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.backgroundColor = [UIColor colorR:255 G:101 B:0 alpha:1];
    [bottomView addSubview:confirmButton];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right);
        make.height.equalTo(bottomView);
        make.top.equalTo(bottomView.mas_top);
        make.width.equalTo(@(80));
    }];
}

//OrderOfGoodsControl/saveOrderOfGoods.do(token,deliveryName,deliveryPhone,deliveryAddress,goodsId,goodsPrice,goodsCount,goodsParam,cartIds,isCart,cartCount)
//--deliveryName 收货人
//--deliveryPhone  联系方式
//--deliveryAddress  收货地址
//--goodsParam是用户选择的商品参数连接的字符串
//--cartIds 用户选择的购物车id连接的字符串 用;隔开  如:  1;2;3
//--isCart 用户提交订单的方式  必填  0:直接购买 1:通过购物车购买
//--cartCount  用户选择的购物车id的数量 通过购物车提交时必填

//--直接下单时 传memberId,deliveryName,deliveryPhone,deliveryAddress,goodsId,goodsPrice,goodsCount,goodsParam,isCart
//--购物车下单时传 memberId,deliveryName,deliveryPhone,deliveryAddress,cartIds,isCart,cartCount

- (void)confirmOrder {
    [self.actionSheetImg showGGActionSheet];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 160, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64.0f - 80.0f) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    [self.view addSubview:_tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"confirmOrderTabelView"];
    ShoppingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[ShoppingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    GoodsInfo *info = [self.goodsInfos objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.goodsName.text = info.goodsName;
    cell.goodsParameter.text = info.goodsParamValue;
    cell.goodsPrice.text = [NSString stringWithFormat:@"%ld",info.goodsPrice];
    cell.goodsCount.text = [NSString stringWithFormat:@"×%ld",info.goodsCount];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.goodsPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.goodsImage.image = image;
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - GGActionSheet代理方法
-(void)GGActionSheetClickWithActionSheet:(GGActionSheet *)actionSheet Index:(int)index{
    if (self.goodsInfos.count == 1) {
        self.goodsInfo = [self.goodsInfos objectAtIndex:0];
        [GET_SINGLETON_FOR_CLASS(StoreManager) buyGoodsWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue withMemberName:self.addressInfo.name withMemberPhone:self.addressInfo.phone withMemberAddress:self.addressInfo.address withGoodsId:self.goodsInfo.goodsId withGoodsPrice:self.goodsInfo.goodsPrice withGoodCount:self.goodsInfo.goodsCount withGoodsParam:self.goodsInfo.goodsParamValue withCartIds:@"" withIsCart:0 withCartCount:0];
    } else {
        NSString *cartIds = @"";
        for (ShoppingGoodsInfo *info in self.goodsInfos) {
            cartIds = [NSString stringWithFormat:@"%@;%ld",cartIds,info.goodsCartId];
        }
        cartIds = [cartIds substringWithRange:NSMakeRange(1, cartIds.length - 1)];
        [GET_SINGLETON_FOR_CLASS(StoreManager) buyGoodsWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue withMemberName:self.addressInfo.name withMemberPhone:self.addressInfo.phone withMemberAddress:self.addressInfo.address withGoodsId:0 withGoodsPrice:0 withGoodCount:0 withGoodsParam:@"" withCartIds:cartIds withIsCart:1 withCartCount:self.goodsInfos.count];
    }
}
-(void)alipay{
    NSLog(@"%@",GET_SINGLETON_FOR_CLASS(StoreManager).payIdString);
    
    NSString *appScheme=@"zhifubao1";
    [[AlipaySDK defaultService] payOrder:GET_SINGLETON_FOR_CLASS(StoreManager).payIdString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        //[self hiddenHub1];
        if ([resultDic[@"resultStatus"] intValue]==9000) {
            [self showtext:@"支付成功"];
        } else{
            [self showtext:resultDic[@"memo"]];
        }

    }];
}
-(void)wxpay{
    PayReq *request = [[PayReq alloc] init] ;
    request.partnerId = @"10000100";
    request.prepayId= @"1101000000140415649af9fc314aa427";
    request.package = @"Sign=WXPay";
    request.nonceStr= @"a462b76e7436e98e0ed6e13c64b4fd1c";
    request.timeStamp= @"1397527777";
    request.sign= @"582282D72DD2B03AD892830965F428CB16E7A256";
    [WXApi sendReq:request];
}

-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            caseWXSuccess:
            
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
            
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
}
-(GGActionSheet *)actionSheetImg{
    if (!_actionSheetImg) {
        _actionSheetImg = [GGActionSheet ActionSheetWithImageArray:@[@"alipay233",@"wechatpay233"] delegate:self];
        _actionSheetImg.cancelDefaultColor = [UIColor redColor];
    }
    return _actionSheetImg;
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
