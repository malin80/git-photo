//
//  CameraManDetailViewController.m
//  Photo
//
//  Created by malin  on 2017/8/7.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CameraManDetailViewController.h"
#import "CameraManDetailFirstViewController.h"
#import "CameraManDetailSecondViewController.h"
#import "CameraManDetailThirdViewController.h"
#import "CameraManDetailFourViewController.h"
#import "DressManDetailFirstViewController.h"
#import "DressManDetailSecondViewController.h"
#import "DressManDetailThirdViewController.h"
#import "SelectDressManViewController.h"
#import "NavigationBar.h"
#import "DLTabedSlideView.h"
#import "CameraManager.h"
#import "LoginManager.h"
#import "GGActionSheet.h"
#import "AlertDialog.h"

@interface CameraManDetailViewController () <NavigationBarDelegate, DLTabedSlideViewDelegate,GGActionSheetDelegate>
@property(nonatomic,strong) GGActionSheet *actionSheetImg;
@property (nonatomic, strong) DLTabedSlideView *tabedSlideView;
@property (nonatomic, strong) UIButton *bottomButton;

@end

@implementation CameraManDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
    [self initView];
}

- (void)initView {
    NSString *barTitle = @"";
    if (self.isSelectController) {
        barTitle = @"预约婚纱摄影 摄影师";
    } else {
        barTitle = @"预约摄影师";
    }
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:barTitle];
    bar.delegate = self;
    bar.line.hidden=YES;
    [self.view addSubview:bar];

    self.bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHieght-60, ScreenWidth, 60)];
    self.bottomButton.backgroundColor = [UIColor redColor];
    if (self.isSelectController) {
        [self.bottomButton setTitle:@"确定预约" forState:UIControlStateNormal];
        [self.bottomButton addTarget:self action:@selector(confirmOrder) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.bottomButton setTitle:@"立即预约" forState:UIControlStateNormal];
        [self.bottomButton addTarget:self action:@selector(immediatelyOrder) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:self.bottomButton];
    
    self.tabedSlideView = [[DLTabedSlideView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght-200)];
    self.tabedSlideView.baseController = self;
    self.tabedSlideView.delegate=self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"作品" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"简介" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"评价" image:nil selectedImage:nil];
    DLTabedbarItem *item4 = [DLTabedbarItem itemWithTitle:@"档期" image:nil selectedImage:nil];
    if (self.isSelectController) {
        self.tabedSlideView.tabbarItems = @[item1, item2, item3];
    } else {
        self.tabedSlideView.tabbarItems = @[item1, item2, item3, item4];
    }
    [self.tabedSlideView buildTabbar];
    self.tabedSlideView.selectedIndex = 0;
    [self.view addSubview:self.tabedSlideView];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectDaySuccess:) name:@"selectDaySuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(alipay) name:@"alipayaa" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(wxpay) name:@"wxpayaa" object:nil];
}

- (void)selectDaySuccess:(NSNotification *)notify {
    NSString *time = notify.object;
    GET_SINGLETON_FOR_CLASS(CameraManager).selectedTime = time;
    [self.bottomButton setTitle:[NSString stringWithFormat:@"立即预约 %@",time] forState:UIControlStateNormal];
}

- (void)immediatelyOrder {
    if (!GET_SINGLETON_FOR_CLASS(CameraManager).selectedTime) {
        [self showtext:@"请选择档期"];
        return;
    }
    SelectDressManViewController *controller = [[SelectDressManViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)confirmOrder {
    AlertDialog *dialog = [AlertDialog style:AlertDialogStyleAlert];
    dialog.title = @"提示";
    dialog.message = @"该步骤会产生费用哦！！";
    [dialog addAction:[AlertAction title:@"确定" style:AlertActionStyleDefault handler:^{
        [self.actionSheetImg showGGActionSheet];
    }]];
    [dialog addAction:[AlertAction title:@"取消" style:AlertActionStyleCancel handler:^{
        
    }]];
    [dialog show:self];
}

#pragma mark --- DLTabedSlideViewDelegate ---
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender {
    if (self.isSelectController) {
        return 3;
    } else {
        return 4;
    }
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index {
    if (self.isSelectController) {
        switch (index) {
            case 0:
            {
                DressManDetailFirstViewController *controller = [[DressManDetailFirstViewController alloc] init];
                controller.dressManInfo = GET_SINGLETON_FOR_CLASS(CameraManager).dressManInfo;
                return controller;
            }
            case 1:
            {
                DressManDetailSecondViewController *controller = [[DressManDetailSecondViewController alloc] init];
                controller.dressManInfo = GET_SINGLETON_FOR_CLASS(CameraManager).dressManInfo;
                return controller;
            }
            case 2:
            {
                DressManDetailThirdViewController *controller = [[DressManDetailThirdViewController alloc] init];
                controller.dressManInfo = GET_SINGLETON_FOR_CLASS(CameraManager).dressManInfo;
                return controller;
            }
            default:
                return nil;
        }
    } else {
        switch (index) {
            case 0:
            {
                CameraManDetailFirstViewController *controller = [[CameraManDetailFirstViewController alloc] init];
                controller.cameraManInfo = GET_SINGLETON_FOR_CLASS(CameraManager).cameraManInfo;
                return controller;
            }
            case 1:
            {
                CameraManDetailSecondViewController *controller = [[CameraManDetailSecondViewController alloc] init];
                controller.cameraManInfo = self.cameraManInfo;
                return controller;
            }
            case 2:
            {
                CameraManDetailThirdViewController *controller = [[CameraManDetailThirdViewController alloc] init];
                controller.cameraManInfo = GET_SINGLETON_FOR_CLASS(CameraManager).cameraManInfo;
                return controller;
            }
            case 3:
            {
                CameraManDetailFourViewController *controller = [[CameraManDetailFourViewController alloc] init];
                return controller;
            }
            default:
                return nil;
        }
    }
}

- (void)DLSlideTabbar:(id)sender selectAt:(NSInteger)index {
    
}

#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - GGActionSheet代理方法
-(void)GGActionSheetClickWithActionSheet:(GGActionSheet *)actionSheet Index:(int)index{
    [GET_SINGLETON_FOR_CLASS(CameraManager) orderCameraManWithCameraId:self.cameraManInfo.cameraManId withToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue withDressId:GET_SINGLETON_FOR_CLASS(CameraManager).selectedDressManInfo.dressManId withTime:GET_SINGLETON_FOR_CLASS(CameraManager).selectedTime withType:@"marry" withGroupName:@"摄影" withIndex:index];
}
-(void)alipay{
    NSLog(@"%@",GET_SINGLETON_FOR_CLASS(CameraManager).Paydata);
    
    NSString *appScheme=@"zhifubao1";
    [[AlipaySDK defaultService] payOrder:GET_SINGLETON_FOR_CLASS(CameraManager).Paydata fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        //[self hiddenHub1];
        if ([resultDic[@"resultStatus"] intValue]==9000) {
            [self showtext:@"支付成功"];
        } else{
            [self showtext:resultDic[@"memo"]];
        }
        
    }];
}
-(void)wxpay{
    NSDictionary *dict= GET_SINGLETON_FOR_CLASS(CameraManager).wxDic;
    NSLog(@"%@",dict);
    PayReq *request = [[PayReq alloc] init] ;
    request.partnerId = [dict objectForKey:@"partnerid"];
    request.prepayId= [dict objectForKey:@"prepayid"];;
    request.package = [dict objectForKey:@"package"];;
    request.nonceStr= [dict objectForKey:@"noncestr"];;
    request.timeStamp= [[dict objectForKey:@"timestamp"] intValue];
    NSLog(@"%u",request.timeStamp);
    request.sign= [dict objectForKey:@"sign"];
    [WXApi sendReq:request];
}

-(void) onResp:(BaseResp*)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                break;
            case -1:
                payResoult = @"支付结果:失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
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
