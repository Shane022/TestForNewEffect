//
//  TSPSuspensionWindow.h
//  TestForNewEffect
//
//  Created by dvt04 on 17/6/28.
//  Copyright © 2017年 suma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSPSuspensionWindow : UIWindow

@property (nonatomic, strong) UIButton *btnSuspension;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)show;
- (void)hidden;

@end
