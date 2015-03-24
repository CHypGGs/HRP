//
//  AES.h
//  AES
//
//  Created by Duke on 14-9-10.
//  Copyright (c) 2014年 Duke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES : NSObject

+ (AES *)AES128;
+ (AES *)AES192;
+ (AES *)AES256;

- (NSString *)encryptString:(NSString *)string
                    withKey:(NSString *)key
                   progress:(void (^)(double p))progress;

- (NSString *)decryptString:(NSString *)string
                    withKey:(NSString *)key
                   progress:(void (^)(double p))progress;

- (NSData *)encrypteData:(NSData *)data
                 withKey:(NSString *)key
                progress:(void (^)(double p))progress;

- (NSData *)decrypteData:(NSData *)data
                 withKey:(NSString *)key
                progress:(void (^)(double p))progress;

- (BOOL)encryptFile:(NSString *)inPath
             toFile:(NSString *)outPath
            withKey:(NSString *)key
           progress:(void (^)(double p))progress
              error:(NSError **)error;

- (BOOL)decryptFile:(NSString *)inPath
             toFile:(NSString *)outPath
            withKey:(NSString *)key
           progress:(void (^)(double p))progress
              error:(NSError **)error;

@end
