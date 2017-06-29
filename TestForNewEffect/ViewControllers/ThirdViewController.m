//
//  ThirdViewController.m
//  TestForNewEffect
//
//  Created by dvt04 on 17/6/29.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "ThirdViewController.h"
#import "TSPSuspensionWindow.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
#if 0
    // 显示悬浮窗
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if ([window isKindOfClass:[TSPSuspensionWindow class]]) {
            TSPSuspensionWindow *suspensionWindow = (TSPSuspensionWindow *)window;
            [suspensionWindow show];
        }
    }
#endif
}

- (IBAction)onHitBtnShowSuspensionView:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showSuspensionView" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
