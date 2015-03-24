//
//  AESTask.h
//  HRPAES
//
//  Created by Hao Runpeng on 14-9-16.
//  Copyright (c) 2014年 Hao Runpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AESKeybitType) {
  AESKeybitType128,
  AESKeybitType192,
  AESKeybitType256
};

typedef NS_ENUM(NSInteger, AESFunctionType) {
  AESFunctionTypeEncrypt,
  AESFunctionTypeDecrypt,
};

@interface HRPAESTask : NSObject

@property (nonatomic,copy) NSString *identifier;
@property (nonatomic,copy) NSString *key;

@property (nonatomic) AESKeybitType   keybitType;
@property (nonatomic) AESFunctionType functionType;

- (instancetype)initWithIdentifier:(NSString *)identifier;
+ (instancetype)taskWithIdentifier:(NSString *)identifier;

@end

@interface HRPAESStringTask : HRPAESTask

@property (nonatomic,copy) NSString *inputString;
@property (nonatomic,copy) NSString *outputString;

@end

@interface HRPAESDataTask : HRPAESTask

@property (nonatomic) NSData *inputData;
@property (nonatomic) NSData *outputData;

@end

@interface HRPAESFileTask : HRPAESTask

@property (nonatomic,copy) NSString *inPath;
@property (nonatomic,copy) NSString *outPath;

@property (nonatomic,retain) NSError *error;
@property (nonatomic) BOOL    isSuccess;

@end
