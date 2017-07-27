//
//  NSString+Category.h
//  MeiFenPai
//
//  Created by 不丕 on 16/7/8.
//  Copyright © 2016年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access
#import <QuartzCore/QuartzCore.h>
@interface NSString (Category)
- (NSString *)md5;
@end
