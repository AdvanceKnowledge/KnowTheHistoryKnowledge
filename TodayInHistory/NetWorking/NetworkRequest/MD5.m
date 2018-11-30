//
//  MD5.m
//  WYLSwift
//
//  Created by 王延磊 on 2018/11/2.
//  Copyright © 2018 追@寻. All rights reserved.
//

#import "MD5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation MD5
+ (NSString *)md5WithString:(NSString *)str{
    
    //    return @"";
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}
@end
