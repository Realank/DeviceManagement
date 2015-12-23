//
//  DeviceManageModel.m
//  DeviceManagement
//
//  Created by Realank on 15/12/23.
//  Copyright © 2015年 Realank. All rights reserved.
//

#import "DeviceManageModel.h"

#define USER_DEFAULT_KEY @"device_dict"

@implementation DeviceInfo

+ (DeviceInfo*) deviceInfoFromDictionary:(NSDictionary*) dict{
    DeviceInfo * deviceInfo = [[DeviceInfo alloc]init];
    
    if (dict.allKeys.count <= 0) {
        return nil;
    }
    
    NSString* deviceName = [dict objectForKey:@"deviceName"];
    if (deviceName.length <= 0) {
        return nil;
    }
    deviceInfo.deviceName = deviceName;
    
    NSString* deviceSeriesNo = [dict objectForKey:@"deviceSeriesNo"];
    if (!deviceSeriesNo) {
        deviceSeriesNo = @"";
    }
    deviceInfo.deviceSeriesNo = deviceSeriesNo;
    
    NSString* deviceOwner = [dict objectForKey:@"deviceOwner"];
    if (!deviceOwner) {
        deviceOwner = @"";
    }
    deviceInfo.deviceOwner = deviceOwner;
    
    return deviceInfo;
    
}
- (NSDictionary*) toDict{
    if (!self || self.deviceName.length <= 0) {
        return nil;
    }
    
    if (!self.deviceSeriesNo) {
        self.deviceSeriesNo = @"";
    }
    if (!self.deviceOwner) {
        self.deviceOwner = @"";
    }
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.deviceName forKey:@"deviceName"];
    [dict setObject:self.deviceSeriesNo forKey:@"deviceSeriesNo"];
    [dict setObject:self.deviceOwner forKey:@"deviceOwner"];
    
    return [dict copy];
}

@end

@interface DeviceManageModel ()

@property (nonatomic, strong) NSMutableArray *deviceList;

@end

@implementation DeviceManageModel

+(instancetype) sharedInstance {
    static dispatch_once_t pred;
    static id shared = nil; //设置成id类型的目的，是为了继承
    dispatch_once(&pred, ^{
        shared = [[super alloc] initUniqueInstance];
    });
    return shared;
}

-(instancetype) initUniqueInstance {
    
    if (self = [super init]) {
        [self fetchDevices];
    }
    
    return self;
}

- (void)fetchDevices{
    NSArray* devices = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULT_KEY];
    if (!devices) {
        devices = [NSArray array];
        [[NSUserDefaults standardUserDefaults] setObject:devices forKey:USER_DEFAULT_KEY];
    }
    _deviceList = [NSMutableArray array];
    for (NSDictionary* deviceDict in devices) {
        DeviceInfo* deviceInfo = [DeviceInfo deviceInfoFromDictionary:deviceDict];
        if (deviceInfo) {
            [_deviceList addObject:deviceInfo];
        }
        
    }
}
- (void)saveDevices{
    NSMutableArray *devices = [NSMutableArray array];
    for (DeviceInfo* deviceInfo in _deviceList) {
        NSDictionary* deviceDict = [deviceInfo toDict];
        if (deviceDict) {
            [devices addObject:deviceDict];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:devices forKey:USER_DEFAULT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray*)devices{
    return [_deviceList copy];
}

- (BOOL)addDevice:(DeviceInfo*) device {
    if (!device || device.deviceName.length <= 0) {
        return NO;
    }
    for (DeviceInfo* oldDevice in _deviceList) {
        if ([oldDevice.deviceName isEqualToString:device.deviceName]) {
            return NO;
        }
    }
    
    [_deviceList addObject:device];
    [self saveDevices];
    return YES;
}

- (BOOL)removeDevice:(DeviceInfo*) device {
    if (!device || device.deviceName.length <= 0) {
        return NO;
    }
    for (DeviceInfo* oldDevice in _deviceList) {
        if ([oldDevice.deviceName isEqualToString:device.deviceName]) {
            [_deviceList removeObject:oldDevice];
            [self saveDevices];
            return YES;
        }
    }

    return NO;
}

- (BOOL)changeDeviceInfo:(DeviceInfo*) device {
    if (!device || device.deviceName.length <= 0) {
        return NO;
    }
    for (DeviceInfo* oldDevice in _deviceList) {
        if ([oldDevice.deviceName isEqualToString:device.deviceName]) {
            oldDevice.deviceSeriesNo = device.deviceSeriesNo;
            oldDevice.deviceOwner = device.deviceOwner;
            [self saveDevices];
            return YES;
        }
    }
    
    return NO;
}


@end
