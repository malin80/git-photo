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

@interface UserDataViewController () <UITableViewDelegate, UITableViewDataSource, NavigationBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
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
    self.DQMarryView = [DQMarryDateView new];
    self.DQMarryView.delegate = self;
    [self addNotification];
    [self updateSections];
    [self createTableView];
    [self createBottomButton];
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
    _timeEntryItem = [EntryItem title:@"婚期" content:nil subtitle:@"设置" selector:@selector(gotoSetMarryDay)];
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
- (void)gotoAvatarViewController {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf takePhoto];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf localPhoto];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:^{
            NSLog(@"取消准备照片");
        }];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];
}

//打开相机
- (void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])//相机
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        [self presentViewController:picker animated:YES completion:^{
            NSLog(@"调取相机成功");
        }];
    }
    else{
        NSLog(@"模拟器情况下无法打开");
    }
}
//打开相册
- (void)localPhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])//相册
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{
            NSLog(@"调取相册成功");
        }];
    }
    else{
        NSLog(@"相册打不开应该是出问题了");
    }
}

//当选择一张图片后进入到这个协议方法里
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data1;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data1 = UIImageJPEGRepresentation(image, 1);
        }
        else
        {
            data1 = UIImagePNGRepresentation(image);
        }
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data1 attributes:nil];
        //得到选择后沙盒中图片的完整路径
        NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        NSData *imageData = UIImagePNGRepresentation(image);
//        long long abc = [self fileSizeAtPath:filePath];
//        if (abc < 1024000) {
//            _headerImage = image;
//        }
//        else {
//            //如果图片尺寸过大则压缩
//            UIImage *small = [Help imageWithImageSimple:image scaledToSize:CGSizeMake(image.size.width/4, image.size.height/4)];
//            NSData *data;
//            if (UIImagePNGRepresentation(small) == nil)
//            {
//                data = UIImageJPEGRepresentation(small, 0.25);
//            }
//            else
//            {
//                data = UIImagePNGRepresentation(small);
//            }
//            _headerImage = small;
//        }
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            NSLog(@"关闭相册界面");
        }];
        [self postDataWithData:imageData];
        [self.tableView reloadData];
    }
}

- (void)postDataWithData:(NSData *)data
{
    [GET_SINGLETON_FOR_CLASS(PersonalManager) updateMemberAvatarWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue withUpFile:data];
//    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
//    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
//    __weak typeof(self) weakSelf = self;
//    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
//    [manage POST:Health_GetReportPic parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        //上传图片
//        NSData *data = UIImageJPEGRepresentation(_headerImage, 1.0);
//        [formData appendPartWithFileData:data name:@"report_pic_path" fileName:@"image.png" mimeType:@"png"];
//        //name-->对应数据库存储的字段
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        if ([dict[@"message"] isEqualToString:@"数据插入成功"])
//        {
//            [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//            [weakSelf addAlertControllerWithMessage:@"上传成功"];
//            //沙盒中图片的完整路径
//            NSString *string1 = [NSHomeDirectory() stringByAppendingString:@"/Documents/image.jpg"];
//            NSFileManager *fileManage = [NSFileManager defaultManager];
//            [fileManage removeItemAtPath:string1 error:nil];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error.localizedDescription);
//        [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//        [weakSelf addAlertControllerWithMessage:@"上传失败"];
//    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"您取消了选择图片222");
    }];
}

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

- (void)gotoSetMarryDay {
    [self.DQMarryView startAnimationFunction];
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
    LoginViewController *login=[[LoginViewController alloc]init];
    login.block = ^{
        [login dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:login animated:NO completion:^{
        
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
