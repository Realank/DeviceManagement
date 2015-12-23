//
//  DeviceDetailViewController.h
//  DeviceManagement
//
//  Created by Realank on 15/12/23.
//  Copyright © 2015年 Realank. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DeviceInfo;
@interface DeviceDetailViewController : UIViewController

@property (nonatomic, assign) BOOL isAddNew;
@property (nonatomic, strong) DeviceInfo* deviceInfo;

@end
