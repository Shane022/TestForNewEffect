//
//  TSPSuspensionWindow.m
//  TestForNewEffect
//
//  Created by dvt04 on 17/6/28.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "TSPSuspensionWindow.h"

@implementation TSPSuspensionWindow
{
    UIPanGestureRecognizer *_dragGesture;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (void)setupButton
{
    self.backgroundColor = [UIColor clearColor];
    self.windowLevel = UIWindowLevelAlert + 1;
    [self makeKeyAndVisible];
    
    _btnSuspension = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnSuspension setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
    [_btnSuspension setBackgroundColor:[UIColor orangeColor]];
    [_btnSuspension setTitle:@"test" forState:UIControlStateNormal];
    [_btnSuspension setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnSuspension addTarget:self action:@selector(onHitBtnTest:) forControlEvents:UIControlEventTouchUpInside];
    _btnSuspension.layer.masksToBounds = YES;
    _btnSuspension.layer.cornerRadius = self.frame.size.width/2;
    [self addSubview:_btnSuspension];
    
    UIPanGestureRecognizer *dragGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveView:)];
    [self addGestureRecognizer:dragGesture];
}

#pragma mark - drag test
- (void)moveView:(UIPanGestureRecognizer *)gesture
{
    CGPoint point = [gesture translationInView:self];
    NSLog(@"X:%f;Y:%f",point.x,point.y);
    
    gesture.view.center = CGPointMake(gesture.view.center.x + point.x, gesture.view.center.y + point.y);
    [gesture setTranslation:CGPointMake(0, 0) inView:self];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (gesture.state == UIGestureRecognizerStateEnded) {
        // 顶部和底部吸附
        if (gesture.view.frame.origin.y < 64 || gesture.view.center.y + gesture.view.frame.size.height/2 > screenHeight - 64) {
            [UIView animateWithDuration:0.2 animations:^{
                if (gesture.view.frame.origin.y < 64) {
                    [gesture.view setCenter:CGPointMake(gesture.view.center.x, gesture.view.frame.size.height/2)];
                } else if (gesture.view.center.y + gesture.view.frame.size.height/2 > screenHeight - 64) {
                    [gesture.view setCenter:CGPointMake(gesture.view.center.x, screenHeight - gesture.view.frame.size.height/2)];
                }
            }];
        } else {
            // 两侧吸附
            if (gesture.view.frame.origin.x < screenWidth/2) {
                [UIView animateWithDuration:0.2 animations:^{
                    [gesture.view setCenter:CGPointMake(gesture.view.frame.size.width/2 + 5, gesture.view.center.y)];
                }];
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    [gesture.view setCenter:CGPointMake(screenWidth - gesture.view.frame.size.width/2 - 5, gesture.view.center.y)];
                }];
            }
        }
    }
}

- (void)onHitBtnTest:(id)sender
{
    NSLog(@"test");
}

- (void)show
{
    self.window.hidden = NO;
    self.btnSuspension.hidden = NO;
}

- (void)hidden
{
    self.window.hidden = YES;
    self.btnSuspension.hidden = YES;
}

- (void)dealloc
{
    NSLog(@"TSPSuspensionWindow dealloc");
}

@end
