//
//  DeviceManageModel.h
//  DeviceManagement
//
//  Created by Realank on 15/12/23.
//  Copyright © 2015年 Realank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfo : NSObject

@property (nonatomic, strong) NSString* deviceName;
@property (nonatomic, strong) NSString* deviceSeriesNo;
@property (nonatomic, strong) NSString* deviceOwner;

+ (DeviceInfo*) deviceInfoFromDictionary:(NSDictionary*) dict;
- (NSDictionary*) toDict;

@end

@interface DeviceManageModel : NSObject

+(instancetype) sharedInstance;

- (NSArray*)devices;
- (BOOL)addDevice:(DeviceInfo*) device;
- (BOOL)removeDevice:(DeviceInfo*) device;
- (BOOL)changeDeviceInfo:(DeviceInfo*) device;


// clue for improper use (produces compile time error)
+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
-(instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+(instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

@end
