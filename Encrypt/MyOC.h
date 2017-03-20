//
//  MyOC.h
//  Encrypt
//
//  Created by WillowRivers on 2017/3/16.
//  Copyright © 2017年 WillowRivers. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef MyOC_h
#define MyOC_h
@interface MyOC : NSObject
{
    
}
+ (NSString *) md5:(NSString *) input ;
+(NSData *)AES256ParmEncryptWithKey:(NSString *)key Encrypttext:(NSData *)text;   //加密
+(NSData *)AES256ParmDecryptWithKey:(NSString *)key Decrypttext:(NSData *)text;   //解密
+(NSString *) aes256_encrypt:(NSString *)key Encrypttext:(NSString *)text;
+(NSString *) aes256_decrypt:(NSString *)key Decrypttext:(NSString *)text;

#endif /* MyOC_h */
@end
