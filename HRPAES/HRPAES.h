//
//  HRPAES.h
//  HRPAES
//
//  Created by Hao Runpeng on 14-9-15.
//  Copyright (c) 2014年 Hao Runpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRPAESTask.h"

@protocol HRPAESDelegate;

@interface HRPAES : NSObject

@property (nonatomic,weak) id<HRPAESDelegate> delegate;
@property (nonatomic,copy) void (^completionBlock)(HRPAESTask *task);
@property (nonatomic,copy) void (^progressBlock)(HRPAESTask *task,double progress);

- (void)addAESStringTask:(HRPAESStringTask *)task;
- (void)addAESDataTask:(HRPAESDataTask *)task;
- (void)addAESFileTask:(HRPAESFileTask *)task;

+ (instancetype)getInstance;

@end

@protocol HRPAESDelegate <NSObject>

- (void)AESTaskDidComplete:(HRPAESTask *)task;

@end


