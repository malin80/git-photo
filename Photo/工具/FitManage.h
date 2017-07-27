//
//  FitManage.h
//  MeiFenPai
//
//  Created by 李进 on 15/11/28.
//  Copyright © 2015年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef enum {
    SOLEGo = 0,//从标志符往后
    RANGE = 1,//指定范围
    SOLEOut = 2,//标志符往前
} CUTOUTSTYLE;

@interface FitManage : NSObject


+ (instancetype)shareManage;
//获取当前应用版本号
+ (NSString *)getCurretVession;
//按标志分离字符串
+ (NSArray *)separationstr:(NSString *)str tag:(NSString *)tag;
//将阿拉伯数字转化成中文数字
+(NSString *)translation:(NSString *)arebic;
//图片针动画
- (void)imageviewAnimation:(UIImageView *)imageview;
#pragma mark - 判断字典是否为空
+(BOOL)checkIsNull:(NSDictionary*)dict;
#pragma mark - 判断数组是否为空
+(BOOL)checkIsNullForArrar:(NSArray*)array;
#pragma mark - 判断是否为空
+(NSString *)checkIsNullForString:(NSString*)str defaults:(NSString *)dstr;

- (CGFloat)fitManageNum:(CGFloat)num;
- (CGFloat)fitManageNumWidth:(CGFloat)num;
//边距
+ (CGFloat)backGaugeNum;

//保存图片的路径
- (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;

/**
 *  label中显示不同大小的字体
 *
 *  @param label    label
 *  @param str      lanel内容
 *  @param changstr 需要改变的内容
 *  @param num      需要改变的字体大小
 *  @param sign     分离标志
 *  @param type     截取方式
 */

+ (void)fitManageChangerLabel:(UILabel *)label labelText:(NSString *)lanelStr changStr:(NSString *)changstr changFontSize:(NSInteger)num sign:(NSString *)sign cutOutStyle:(CUTOUTSTYLE)type;
/**
 *  label中显示不同颜色的字体
 *
 *  @param label                   label
 *  @param lanelStr                lanel内容
 *  @param changstr                需要改变的东西
 *  @param color                   颜色
 *  @param sign                    范围
 *  @param type                    截取方式
 */
+ (void)fitManageChangerColorLabel:(UILabel *)label labelText:(NSString *)lanelStr changStr:(NSString *)changstr changFontColor:(UIColor *)color sign:(NSString *)sign cutOutStyle:(CUTOUTSTYLE)type;
/**
 *  textfiled插入分隔符
 *
 *  @param textField textfiled
 *  @param array     添加数组只限数字例如 地三个字符要空
 *  @param length    <#length description#>
 *  @param separate  <#separate description#>
 */
- (void)fitManageTextfiledChang:(UITextField *)textField conditionArray:(NSArray *)array separate:(NSString *)separate;

#pragma mark 获取便好设置数据
+ (NSString *)loadsavePhoneData;
+ (NSString *)loadsaveSessData;
+ (NSString *)loadsaveName;
+ (NSString *)loadsaveIdcard;
//获取便好设置中的数据状态
+ (NSInteger)loadDefaultsData:(NSString *)key;
//返回状态码
+ (NSInteger)statueNUM:(id)result;

/******************************************************************************
 函数名称 : + (NSString *)base64StringFromText:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本前后缀
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64StringFromText:(NSString *)text prifix:(NSString *)prifix suffix:(NSString *)suffix;

/******************************************************************************
 函数名称 : + (NSString *)textFromBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 输出参数 : N/A
 返回参数 : (NSString *)    文本
 备注信息 :
 ******************************************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64;

//判断是否可以使用摄像头
+(BOOL)canUseCamera;


@end
