//
//  FitManage.m
//  MeiFenPai
//
//  Created by 李进 on 15/11/28.
//  Copyright © 2015年 com. All rights reserved.
//

#import "FitManage.h"
//引入IOS自带密码库
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
//#import "NSData+Base64.h"


#define __BASE64( text )        [CommonFunc base64StringFromText:text]
#define __TEXT( base64 )        [CommonFunc textFromBase64String:base64]

#define screewidth [UIScreen mainScreen].bounds.size.width
#define screeheight [UIScreen mainScreen].bounds.size.height

//空字符串
#define     LocalStr_None           @""

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@interface FitManage ()

@property (nonatomic, strong)NSMutableString *stringWithAddedSpaces;

@property (nonatomic, strong)NSMutableArray *temparray;

@end

@implementation FitManage


+ (instancetype)shareManage{
    static FitManage *manage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manage = [[FitManage alloc]init];
    });
    
    return manage;
}

- (CGFloat)fitManageNum:(CGFloat)num{
    
//    num = num * 0.8;
    if (screeheight == 480) {
        num = num * 480/667 -2;
    }else if (screeheight == 568){
        num = num * 568 / 667 -3;
    }else if(screeheight == 736){
        num = num * 736 / 667 + 2;
    }
    
    return num;
}

- (CGFloat)fitManageNumWidth:(CGFloat)num{
    
    if (screeheight == 480) {
        num = num * 320/375 -2;
    }else if (screeheight == 568){
        num = num * 320 / 375 -3;
    }else if(screeheight == 736){
        num = num * 414 / 375 + 2;
    }
    
    return num;

}
#pragma mark 设置不同机型上的边距
+ (CGFloat)backGaugeNum{
    if (screewidth == 414) {
        return 20;
    }else{
        
        return 16;
    }
}

//图片针动画
- (void)imageviewAnimation:(UIImageView *)imageview{
    self.temparray = nil;
    for (int i = 0; i< 22; i++) {
        
        NSString *str = [NSString stringWithFormat:@"succeed_ani_%.2d",i+1];
        [self.temparray addObject:[UIImage imageNamed:str]];
        
    }
        imageview.animationImages = self.temparray;
        imageview.animationDuration = 1 ;
        imageview.animationRepeatCount = 1;
        [imageview startAnimating];

}
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

+ (void)fitManageChangerLabel:(UILabel *)label labelText:(NSString *)lanelStr changStr:(NSString *)changstr changFontSize:(NSInteger)num sign:(NSString *)sign cutOutStyle:(CUTOUTSTYLE)type{
    
//    NSString *point = @".";
    NSRange rang = [lanelStr rangeOfString:sign];
    //从标志符开始截取到最后
    NSString *substr = @"";
    if (type == RANGE) {
       substr = [lanelStr substringWithRange:rang];
    }else if(type == SOLEGo){
        substr = [lanelStr substringFromIndex:rang.location];
    }else{
        substr = [lanelStr substringToIndex:rang.location];
    }
    

    NSString *str = [NSString stringWithFormat:@"%@", substr];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:lanelStr];
    
        [att addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:num]
                    range:[lanelStr rangeOfString:str]];
    label.attributedText = att;
    
}

+ (void)fitManageChangerColorLabel:(UILabel *)label labelText:(NSString *)lanelStr changStr:(NSString *)changstr changFontColor:(UIColor *)color sign:(NSString *)sign cutOutStyle:(CUTOUTSTYLE)type{
    
    NSRange rang = [lanelStr rangeOfString:sign];
    //从标志符开始截取到最后
    NSString *substr = @"";
    if (type == RANGE) {
        substr = [lanelStr substringWithRange:rang];
    }else if(type == SOLEGo){
        substr = [lanelStr substringFromIndex:rang.location];
    }else{
        substr = [lanelStr substringToIndex:rang.location];
    }
    
    
    NSString *str = [NSString stringWithFormat:@"%@", substr];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:lanelStr];
    
    [att addAttribute:NSForegroundColorAttributeName
                value:color
                range:[lanelStr rangeOfString:str]];
    label.attributedText = att;
}

/**
 *  除去非数字字符，确定光标正确位置
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理过后的string
 */
- (NSString *)removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition separate:(NSString *)separate{
    
    NSUInteger originalCursorPosition =*cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    
    for (NSUInteger i=0; i<string.length; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        unichar point = [@"." characterAtIndex:0];
        if(isalnum(characterToAdd)|| characterToAdd == point) {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            [digitsOnlyString appendString:stringToAdd];
        }else {
            if(i<originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    return digitsOnlyString;
}

/**
 *  将空格插入我们现在的string 中，并确定我们光标的正确位置，防止在空格中
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理后有空格的string
 */
- (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition conditionArray:(NSArray *)array separate:(NSString *)separate{
    
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    NSInteger num = [array[0] integerValue];
    for (NSUInteger i=0; i<string.length; i++) {
        
            for (int j = 0; j < array.count; j++) {
                if(i==num) {
                    [stringWithAddedSpaces appendString:separate];
                    
                    if(i<cursorPositionInSpacelessString) {
                        (*cursorPosition)++;
                    }
                    if (j == array.count-1) {
                       num += [array[j] integerValue];
                    }else{
                        num += [array[j+1] integerValue];
                    }
                    
                }
        }
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    return stringWithAddedSpaces;
}


//插入分隔符
- (void)fitManageTextfiledChang:(UITextField *)textField conditionArray:(NSArray *)array separate:(NSString *)separate{
    /**
     *  判断正确的光标位置

     */
    
        NSUInteger targetCursorPostion = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
        
        NSString *phoneNumberWithoutSpaces = [self removeNonDigits:textField.text andPreserveCursorPosition:&targetCursorPostion separate:(NSString *)separate];
        NSString *phoneNumberWithSpaces = [self insertSpacesEveryFourDigitsIntoString:phoneNumberWithoutSpaces andPreserveCursorPosition:&targetCursorPostion conditionArray:array separate:(NSString *)separate];
        
        textField.text = phoneNumberWithSpaces;
        
        UITextPosition *targetPostion = [textField positionFromPosition:textField.beginningOfDocument offset:targetCursorPostion];
        
        [textField setSelectedTextRange:[textField textRangeFromPosition:targetPostion toPosition:targetPostion]];
}

#pragma mark 获取便好设置数据
+ (NSString *)loadsavePhoneData{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"phone"];
}
+ (NSString *)loadsaveSessData{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"app_sess"];
}
+ (NSString *)loadsaveName{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"name"];
}
+ (NSString *)loadsaveIdcard{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"id_card_num"];
}
//返回状态码
+ (NSInteger)statueNUM:(id)result{
    
    NSInteger statuss = [result[@"status"] integerValue];
    return statuss;
}
//获取便好设置中的数据状态
+ (NSInteger)loadDefaultsData:(NSString *)key{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [[defaults objectForKey:key] integerValue];
}
#pragma mark 保存图片路径
//保存图片的路径
- (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName{
    NSData* imageData = UIImageJPEGRepresentation(tempImage,0.5);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
    return fullPathToFile;
}
#pragma mark - 判断字典是否为空
+(BOOL)checkIsNull:(NSDictionary*)dict{
    
    if (nil == dict || [dict isEqual:[NSNull null]] || [dict isEqual:@""] || [dict count] == 0) {
        return YES;
    }
    return NO;
}
#pragma mark - 判断数组是否为空
+(BOOL)checkIsNullForArrar:(NSArray*)array{
    
    if (array == nil || [array isKindOfClass:[NSNull class]] || [array isEqual:@""]|| array.count == 0) {
        return YES;
    }
    return NO;
}
#pragma mark - 判断是否为空
+(NSString *)checkIsNullForString:(NSString*)str defaults:(NSString *)dstr{
    
    if (nil == str || [str isEqual:[NSNull null]] || [str isEqual:@""]||[str isEqual:@"(null)"]||[str isEqual:@"<null>"]||[str isEqual:@"null"]) {
        return dstr;
    }
    return str;
}

//将阿拉伯数字转化成中文数字
+(NSString *)translation:(NSString *)arebic{
    if (arebic == nil) {
        return @"零";
    }
    NSString *str = arebic;
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length -i-1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]])
        {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
            {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]])
                {
                    [sums removeLastObject];
                }
            }else
            {
                sum = chinese_numerals[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum])
            {
                continue;
            }
        }
        
        [sums addObject:sum];
    }
    
    NSString *sumStr = [sums  componentsJoinedByString:@""];
//    NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
    return sumStr;
}

#pragma mark 懒加载
- (NSMutableString *)stringWithAddedSpaces{
    
    if (_stringWithAddedSpaces == nil) {
        
        _stringWithAddedSpaces = [[NSMutableString alloc]init];
    }
    return _stringWithAddedSpaces;
    
}

- (NSMutableArray *)temparray{
    
    if (_temparray == nil) {
        
        _temparray = [NSMutableArray array];
    }
    return _temparray;
}

#pragma mark base64加密
//加密
+ (NSString *)base64StringFromText:(NSString *)text prifix:(NSString *)prifix suffix:(NSString *)suffix{
    
    if (!text || [text isEqualToString:LocalStr_None]) {
        return LocalStr_None;
    }
    
    NSString *name = [NSString string];
    if (prifix && ![prifix isEqualToString:LocalStr_None]) {
        name = [NSString stringWithFormat:@"%@%@",prifix,text];
//        [name stringByAppendingString:f];
    }else{
        name = text;
    }
    
    if (suffix && ![suffix isEqualToString:LocalStr_None]) {
        name = [NSString stringWithFormat:@"%@%@",name,suffix];
//        [name stringByAppendingString:suffix];
    }
    
    NSData *data = [name dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self base64EncodedStringFrom:data];
}
//解密
+ (NSString *)textFromBase64String:(NSString *)base64{
    if (base64 && ![base64 isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY   改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataWithBase64EncodedString:base64];
        //IOS 自带DES解密 Begin    改动了此处
        //data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }else {
        return LocalStr_None;
    }
}

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
+ (NSData *)dataWithBase64EncodedString:(NSString *)string{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length]){
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

//判断是否可以使用摄像头
+(BOOL)canUseCamera {
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有摄像头或摄像头不可用\n请试试在设备的设置-隐私-相机中允许访问相机。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    return YES;
}

//按标志分离字符串
+ (NSArray *)separationstr:(NSString *)str tag:(NSString *)tag{
    
    return [str componentsSeparatedByString:tag]; 
}
+ (NSString *)getCurretVession{
    //获取版本号
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}




@end
