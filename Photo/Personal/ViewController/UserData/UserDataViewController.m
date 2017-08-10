//
//  UserDataViewController.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "UserDataViewController.h"
#import "PhoneNumberViewController.h"
#import "NickNameViewController.h"
#import "UserNameViewController.h"
#import "LoginViewController.h"
#import "ModifyPasswordViewController.h"

#import "NavigationBar.h"
#import "EntrySection.h"
#import "EntryItem.h"
#import "UserDataTableViewCell.h"
#import "AppDelegate.h"
#import "LoginManager.h"
#import "PersonalManager.h"

@interface UserDataViewController () <UITableViewDelegate, UITableViewDataSource, NavigationBarDelegate>
{
    NSMutableArray<EntrySection *> *_sections;
    
    EntryItem *_avatarEntryItem;
    EntryItem *_phoneNumberEntryItem;
    EntryItem *_nickNameEntryItem;
    EntryItem *_sexEntryItem;
    EntryItem *_birthdayEntryItem;
    EntryItem *_userNameEntryItem;
    EntryItem *_timeEntryItem;
    EntryItem *_passwordEntryItem;
    
    UIView *_maskForDatePicker;
}

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation UserDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:@"个人信息"];
    bar.delegate = self;
    [self.view addSubview:bar];
    self.DQBirthView = [DQBirthDateView new];
    self.DQBirthView.delegate = self;
    [self addNotification];
    [self updateSections];
    [self createTableView];
    [self createBottomButton];
    
    _maskForDatePicker = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHieght)];
    _maskForDatePicker.backgroundColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.5];
    UITapGestureRecognizer *tapForDatePicker = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapForDatePicker)];
    [_maskForDatePicker addGestureRecognizer:tapForDatePicker];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMemberInfoSuccess) name:@"updateMemberInfoSuccess" object:nil];
}

#pragma mark --- notification method ---
- (void)updateMemberInfoSuccess {
    [self updateSections];
    [_tableView reloadData];
}

- (void)createBottomButton {
    UIButton *bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHieght- 40, ScreenWidth, 40)];
    [bottomButton setTitle:@"退出账号" forState:UIControlStateNormal];
    bottomButton.backgroundColor = UIColorFromRGB(255, 102, 1, 1);
    [bottomButton addTarget:self action:@selector(closeAccount) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
}

- (void)updateSections {
    _sections = [NSMutableArray array];
    EntrySection *section1 = [[EntrySection alloc] init];
    EntrySection *section2 = [[EntrySection alloc] init];
    EntrySection *section3 = [[EntrySection alloc] init];

    //头像
    _avatarEntryItem = [EntryItem title:@"头像" content:nil subtitle:nil selector:@selector(gotoAvatarViewController)];
    [section1.items addObject:_avatarEntryItem];
    
    //手机
    NSString *phoneNumber = [NSString stringWithFormat:@"%@",GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberPhone];
    _phoneNumberEntryItem = [EntryItem title:@"手机" content:phoneNumber subtitle:nil selector:@selector(gotoPhoneNumberViewController)];
    [section1.items addObject:_phoneNumberEntryItem];
    
    //昵称
    NSString *nickName = [NSString stringWithFormat:@"%@",GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberNickName];
    _nickNameEntryItem = [EntryItem title:@"昵称" content:nickName subtitle:@"修改" selector:@selector(gotoNickNameViewController)];
    [section1.items addObject:_nickNameEntryItem];
    
    //性别
    _sexEntryItem = [EntryItem title:@"性别" content:nil subtitle:@"修改" selector:@selector(gotoSetSex)];
    [section1.items addObject:_sexEntryItem];
    
    //生日
    _avatarEntryItem = [EntryItem title:@"生日" content:nil subtitle:@"修改" selector:@selector(gotoSetBirthDay)];
    [section2.items addObject:_avatarEntryItem];
    
    //姓名
    if (![GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberName isEqualToString:@"未设置"]) {
        NSString *name = [NSString stringWithFormat:@"%@",GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberName];
        _userNameEntryItem = [EntryItem title:@"姓名" content:name subtitle:@"修改" selector:@selector(gotoUserNameViewController)];
    } else {
        _userNameEntryItem = [EntryItem title:@"姓名" content:nil subtitle:@"修改" selector:@selector(gotoUserNameViewController)];
    }
    [section2.items addObject:_userNameEntryItem];
    
    //婚期
    _timeEntryItem = [EntryItem title:@"婚期" content:nil subtitle:@"设置" selector:@selector(gotoAvatarViewController)];
    [section2.items addObject:_timeEntryItem];
    
    //密码
    _passwordEntryItem = [EntryItem title:@"密码" content:@"******" subtitle:@"修改" selector:@selector(gotoModifyPasswordViewController)];
    [section3.items addObject:_passwordEntryItem];
    
    [_sections addObject:section1];
    [_sections addObject:section2];
    [_sections addObject:section3];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght - 64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    
    [self.view addSubview:_tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    UserDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UserDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    EntryItem *item = _sections[indexPath.section].items[indexPath.row];
    cell.title.text = item.title;
    cell.content.text = item.content;
    cell.subtitle.text = item.subtitle;
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.avatarView.hidden = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EntryItem *item = _sections[indexPath.section].items[indexPath.row];
    [self performSelectorOnMainThread:item.selector withObject:nil waitUntilDone:YES];
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_sections[indexPath.section].items[indexPath.row].title isEqualToString:@"头像"]) {
        return 80;
    } else {
        return 40;
    }
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    footerView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

#pragma mark --- cell method ---
- (void)gotoPhoneNumberViewController {
    PhoneNumberViewController *controller = [[PhoneNumberViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)gotoNickNameViewController {
    NickNameViewController *controller = [[NickNameViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)gotoUserNameViewController {
    UserNameViewController *controller = [[UserNameViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)gotoSetBirthDay {
   [self.DQBirthView startAnimationFunction];
}
//点击选中哪一行 的代理方法
- (void)clickDQBirthDateViewEnsureBtnActionAgeModel:(DQAgeModel *)ageModel andConstellation:(NSString *)str{
    NSString *stra = [NSString stringWithFormat:@"%@年 %@月 %@日 ",ageModel.year,ageModel.month,ageModel.day];

}
- (void)gotoSetSex {
    LTPickerView* pickerView = [LTPickerView new];
    pickerView.dataSource = @[@"女",@"男"];//设置要显示的数据
    pickerView.defaultStr = @"女";//默认选择的数据
    [pickerView show];//显示
    //回调block
    pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
//        //obj:LTPickerView对象
//        //str:选中的字符串
//        //num:选中了第几行
//        NSLog(@"选择了第%d行的%@",num,str);
//        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"LTPickerView" message:[NSString stringWithFormat:@"选择了第%d行的%@",num,str] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alert show];
        LoginManager *manager = GET_SINGLETON_FOR_CLASS(LoginManager);
        [GET_SINGLETON_FOR_CLASS(PersonalManager) updateMemberInfoWithNickName:manager.memberInfo.memberNickName withMemberName:manager.memberInfo.memberName withMemberSex:str withMemberMarry:manager.memberInfo.memberMarry withMemberBirthday:manager.memberInfo.memberBirthday withToken:manager.memberInfo.safeCodeValue];
    };
    
}

- (void)gotoModifyPasswordViewController {
    ModifyPasswordViewController *controller = [[ModifyPasswordViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
}

#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)closeAccount {
    LoginViewController *controller = [[LoginViewController alloc] init];
    [self.navigationController presentViewController:controller animated:NO completion:^{
        
    }];
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
