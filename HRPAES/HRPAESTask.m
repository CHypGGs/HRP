//
//  AESTask.m
//  HRPAES
//
//  Created by Hao Runpeng on 14-9-16.
//  Copyright (c) 2014年 Hao Runpeng. All rights reserved.
//

#import "HRPAESTask.h"

@implementation HRPAESTask

- (instancetype)initWithIdentifier:(NSString *)identifier
{
  self = [super init];
  if (self) {
    _identifier = identifier;
  }
  return self;
}

+ (instancetype)taskWithIdentifier:(NSString *)identifier
{
  return [[HRPAESTask alloc] initWithIdentifier:identifier];
}

@end

@implementation HRPAESStringTask

@end

@implementation HRPAESDataTask

@end

@implementation HRPAESFileTask

@end
