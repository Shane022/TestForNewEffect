//
//  UIViewController+ShowSuspensionView.m
//  TestForNewEffect
//
//  Created by dvt04 on 17/6/29.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "UIViewController+ShowSuspensionView.h"
#import "TSPSuspensionWindow.h"
#import "ThirdViewController.h"

@implementation UIViewController (ShowSuspensionView)


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

- (void)viewWillAppear:(BOOL)animated
{
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if ([window isKindOfClass:[TSPSuspensionWindow class]]) {
            TSPSuspensionWindow *suspensionWindow = (TSPSuspensionWindow *)window;
            if ([self isKindOfClass:[ThirdViewController class]]) {
                [suspensionWindow hidden];
            } else {
                [suspensionWindow show];
            }
        }
    }
}

#pragma clang diagnostic pop


@end
