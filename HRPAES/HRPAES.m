//
//  HRPAES.m
//  HRPAES
//
//  Created by Hao Runpeng on 14-9-15.
//  Copyright (c) 2014年 Hao Runpeng. All rights reserved.
//

#import "HRPAES.h"
#import "AES.h"

@interface HRPAES ()

@property (nonatomic,readonly) NSOperationQueue *queue;
@property (nonatomic,readonly) NSOperationQueue *mainQueue;

@end

@implementation HRPAES

@synthesize queue = _queue;

- (void)addAESStringTask:(HRPAESStringTask *)task
{
  [self.queue addOperationWithBlock:^{
    AES *aes = [self aesWithTask:task];
    
    if (task.functionType == AESFunctionTypeEncrypt) {
      task.outputString = [aes encryptString:task.inputString withKey:task.key progress:^(double p) {
        [self.mainQueue addOperationWithBlock:^{
           self.progressBlock(task,p);
        }];
      }];
    }
    else {
      task.outputString = [aes decryptString:task.inputString withKey:task.key progress:^(double p) {
        [self.mainQueue addOperationWithBlock:^{
          self.progressBlock(task,p);
        }];
      }];
    }
    [self.mainQueue addOperationWithBlock:^{
      self.completionBlock(task);
      [self.delegate AESTaskDidComplete:task];
    }];
    
  }];
}

- (void)addAESDataTask:(HRPAESDataTask *)task
{
  [self.queue addOperationWithBlock:^{
    AES *aes = [self aesWithTask:task];
    
    if (task.functionType == AESFunctionTypeEncrypt) {
      task.outputData = [aes encrypteData:task.inputData withKey:task.key progress:^(double p) {
        [self.mainQueue addOperationWithBlock:^{
          self.progressBlock(task,p);
        }];
      }];
    }
    else {
      task.outputData = [aes decrypteData:task.inputData withKey:task.key progress:^(double p) {
        [self.mainQueue addOperationWithBlock:^{
          self.progressBlock(task,p);
        }];
      }];
    }
    [self.mainQueue addOperationWithBlock:^{
      self.completionBlock(task);
      [self.delegate AESTaskDidComplete:task];
    }];
    
  }];
}

- (void)addAESFileTask:(HRPAESFileTask *)task
{
  [self.queue addOperationWithBlock:^{
    AES *aes = [self aesWithTask:task];
    NSError *error = nil;
    if (task.functionType == AESFunctionTypeEncrypt) {
      task.isSuccess = [aes encryptFile:task.inPath toFile:task.outPath withKey:task.key progress:^(double p) {
        [self.mainQueue addOperationWithBlock:^{
          self.progressBlock(task,p);
        }];
      } error:&error];
    }
    else {
      task.isSuccess = [aes decryptFile:task.inPath toFile:task.outPath withKey:task.key progress:^(double p) {
        [self.mainQueue addOperationWithBlock:^{
          self.progressBlock(task,p);
        }];
      } error:&error];
    }
    task.error = error;
    [self.mainQueue addOperationWithBlock:^{
      self.completionBlock(task);
      [self.delegate AESTaskDidComplete:task];
    }];
  }];
}

- (AES *)aesWithTask:(HRPAESTask*)task
{
  AES *aes = nil;
  switch (task.keybitType) {
    case AESKeybitType128:
      aes = [AES AES128];
      break;
    case AESKeybitType192:
      aes = [AES AES192];
      break;
    case AESKeybitType256:
      aes = [AES AES256];
      break;
    default:
      break;
  }
  return aes;
}

#pragma mark -
#pragma mark Properties

- (NSOperationQueue *)queue
{
  if (!_queue) {
    _queue = [[NSOperationQueue alloc] init];
    _queue.maxConcurrentOperationCount = 3;
  }
  
  return _queue;
}

- (NSOperationQueue *)mainQueue
{
  return [NSOperationQueue mainQueue];
}

#pragma mark -
#pragma mark Singleton Definition

static id instance = nil;

+ (instancetype)getInstance
{
  @synchronized(self){
    if (!instance) {
      instance = [[self alloc] init];
    }
  }
  return instance;
}

+ (instancetype)allocWithZone:(NSZone *)zone
{
  @synchronized(self){
    if (!instance) {
      instance = [super allocWithZone:zone];
    }
  }
  return instance;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
  return self;
}

@end
