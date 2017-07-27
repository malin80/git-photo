//
//  UIColor+EX.m
//  
//
//  Created by 李进 on 15/11/27.
//
//

#import "UIColor+EX.h"

@implementation UIColor (EX)

+ (instancetype)colorFitNum:(CGFloat)num alpha:(CGFloat)alpha{
    
    if (num == 239) {
        
        num = 242;
    }
    UIColor *color = [UIColor colorWithRed:num/255.00 green:num/255.00  blue:num/255.00  alpha:alpha];
    
    return color;
}

//1,199,145
+ (UIColor *)interfacegreenFont{
    UIColor *color = [UIColor colorWithRed:1/255.00 green:199/255.00  blue:145/255.00  alpha:1];
    
    return color;
}
+ (instancetype)colorR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha{
    
    UIColor *color = [UIColor colorWithRed:r/255.00 green:g/255.00  blue:b/255.00  alpha:alpha];
    
    return color;
}

+ (UIColor *)greenFont{
//    UIColor *color = [UIColor colorWithRed:13/255.00 green:181/255.00  blue:135/255.00  alpha:1];
    UIColor *color = [UIColor colorWithRgb:@"00bb8a" :1];

    
    return color;
}

+ (UIColor *)grayFont{
    //143,145,157
//    UIColor *color = [UIColor colorWithRed:143/255.00 green:145/255.00  blue:157/255.00  alpha:1];
    UIColor *color = [UIColor colorWithRgb:@"b7b9c1" :1];

    
    return color;
}

//背景颜色
+ (UIColor *)nowBackGrondColor{
    
    //    UIColor *color = [UIColor colorWithRed:124/255.00 green:126/255.00  blue:139/255.00  alpha:1];
    UIColor *color = [UIColor colorWithRgb:@"f2f2f2" :1];
    
    
    return color;
}

+ (UIColor *)hilghtGrayFont{
    
//    UIColor *color = [UIColor colorWithRed:124/255.00 green:126/255.00  blue:139/255.00  alpha:1];
    UIColor *color = [UIColor colorWithRgb:@"858794" :1];

    
    return color;
}

//金钱字体
+ (UIColor *)numMoneyFontColor{
    
//    UIColor *color = [UIColor colorWithRed:249/255.00 green:170/255.00  blue:61/255.00  alpha:1];
    UIColor *color = [UIColor colorWithRgb:@"f9bd4f" :1];
    
    return color;
}
//数字字体
+ (UIColor *)numFontColor{
    
    UIColor *color = [UIColor colorWithRed:254/255.00 green:194/255.00  blue:69/255.00  alpha:1];
    
    return color;
}

//红色字体
+ (UIColor *)redFontColor{
    
    UIColor *color = [UIColor colorWithRed:252/255.00 green:87/255.00  blue:112/255.00  alpha:1];
    
    return color;
}

+ (UIColor *)huangseColor{
    //249,172,96
    UIColor *color = [UIColor colorWithRed:249/255.00 green:172/255.00  blue:96/255.00  alpha:1];
    
    return color;
}
//255,113,131
+ (UIColor *)hongseColor{
//    UIColor *color = [UIColor colorWithRed:255/255.00 green:113/255.00  blue:131/255.00  alpha:1];
    
    UIColor *color = [UIColor colorWithRgb:@"ff717e" :1];
    
    return color;
}

//按钮未选中
+ (UIColor *)butNoCanUser{
    UIColor *color = [UIColor colorWithRgb:@"c7c7cc" :1];
    
    return color;
}

//粉红
+ (UIColor *)fenHongSe{
    UIColor *color = [UIColor colorWithRgb:@"f176a3" :1];
    
    return color;
}

//按钮可以使用
+ (UIColor *)butCanUser{
    UIColor *color = [UIColor colorWithRgb:@"01c791" :1];
    
    return color;
}

+ (UIColor *)butColor{
    UIColor *color = [UIColor colorWithRed:-4/255.00 green:214/255.00  blue:150/255.00  alpha:1];
    
    return color;
}

//横线颜色
+ (UIColor *)lineColor{
//    UIColor *color = [UIColor colorWithRed:0/255.00 green:0/255.00  blue:0/255.00  alpha:0.1];
    UIColor *color = [UIColor colorWithRgb:@"000000" :0.1];

    
    return color;
}

//将16进制转化成rgb
+ (UIColor*) colorWithRgb :(NSString*)rgb :(float)alpha{
    NSString* red = [rgb substringWithRange: NSMakeRange(0, 2)];
    NSString* green = [rgb substringWithRange: NSMakeRange(2, 2)];
    NSString* blue = [rgb substringWithRange: NSMakeRange(4, 2)];
    int red_i, green_i, blue_i;
    sscanf([red cStringUsingEncoding:NSASCIIStringEncoding], "%x", &red_i);
    sscanf([green cStringUsingEncoding:NSASCIIStringEncoding], "%x", &green_i);
    sscanf([blue cStringUsingEncoding:NSASCIIStringEncoding], "%x", &blue_i);
    return [UIColor colorWithRed:red_i/255.0 green:green_i/255.0 blue:blue_i/255.0 alpha:alpha];
}
@end
