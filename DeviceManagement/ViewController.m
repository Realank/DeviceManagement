//
//  ViewController.m
//  DeviceManagement
//
//  Created by Realank on 15/12/23.
//  Copyright © 2015年 Realank. All rights reserved.
//

#import "ViewController.h"
#import "DeviceManageModel.h"
#import "DeviceDetailViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (IBAction)addDevice:(id)sender {
    
    DeviceDetailViewController *vc = [[DeviceDetailViewController alloc]init];
    vc.isAddNew = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[DeviceManageModel sharedInstance] devices].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSInteger row = indexPath.row;
    DeviceInfo* deviceInfo = [[[DeviceManageModel sharedInstance] devices] objectAtIndex:row ];
    cell.textLabel.text = deviceInfo.deviceName;
    cell.detailTextLabel.text = deviceInfo.deviceOwner;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    DeviceInfo* deviceInfo = [[[DeviceManageModel sharedInstance] devices] objectAtIndex:row ];
    
    DeviceDetailViewController *vc = [[DeviceDetailViewController alloc]init];
    vc.isAddNew = NO;
    vc.deviceInfo = deviceInfo;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger row = indexPath.row;
        if (row < [[DeviceManageModel sharedInstance] devices].count) {
            DeviceInfo* deviceInfo = [[[DeviceManageModel sharedInstance] devices] objectAtIndex:row ];
            [[DeviceManageModel sharedInstance] removeDevice:deviceInfo];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
    }
    
}



@end
