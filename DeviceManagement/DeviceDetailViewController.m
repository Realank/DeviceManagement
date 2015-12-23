//
//  DeviceDetailViewController.m
//  DeviceManagement
//
//  Created by Realank on 15/12/23.
//  Copyright © 2015年 Realank. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import "DeviceManageModel.h"

@interface DeviceDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *seriesNoTF;
@property (weak, nonatomic) IBOutlet UITextField *ownerTF;

@end

@implementation DeviceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    [self.navigationItem setRightBarButtonItem:barBtn animated:NO];
    
    if (self.isAddNew) {
        self.title = @"添加设备";
    }else {
        self.title = @"设备详情";
        self.nameTF.text = self.deviceInfo.deviceName;
        self.nameTF.enabled = NO;
        self.seriesNoTF.text = self.deviceInfo.deviceSeriesNo;
        self.ownerTF.text = self.deviceInfo.deviceOwner;
    }
}

- (void)done{
    if (self.isAddNew) {
        DeviceInfo* deviceInfo = [[DeviceInfo alloc]init];
        deviceInfo.deviceName = self.nameTF.text;
        deviceInfo.deviceSeriesNo = self.seriesNoTF.text;
        deviceInfo.deviceOwner = self.ownerTF.text;
        if ([[DeviceManageModel sharedInstance] addDevice:deviceInfo]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
                //errow
        }
    }else{
        self.deviceInfo.deviceSeriesNo = self.seriesNoTF.text;
        self.deviceInfo.deviceOwner = self.ownerTF.text;
        if ([[DeviceManageModel sharedInstance] changeDeviceInfo:self.deviceInfo]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            //errow
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
