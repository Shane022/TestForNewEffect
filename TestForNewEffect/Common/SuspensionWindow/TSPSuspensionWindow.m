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
#if 1
    CGPoint point = [gesture translationInView:self];
    NSLog(@"X:%f;Y:%f",point.x,point.y);
    
    gesture.view.center = CGPointMake(gesture.view.center.x + point.x, gesture.view.center.y + point.y);
    [gesture setTranslation:CGPointMake(0, 0) inView:self];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (gesture.state == UIGestureRecognizerStateEnded) {
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
#else
    
    CGPoint point = [gesture translationInView:self];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGRect originalFrame = self.frame;
    if (originalFrame.origin.x >= 0 && originalFrame.origin.x+originalFrame.size.width <= width) {
        originalFrame.origin.x += point.x;
    }
    if (originalFrame.origin.y >= 0 && originalFrame.origin.y+originalFrame.size.height <= height) {
        originalFrame.origin.y += point.y;
    }
    self.frame = originalFrame;
    [gesture setTranslation:CGPointZero inView:self];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        _btnSuspension.enabled = NO;
    }else if (_btnSuspension.state == UIGestureRecognizerStateChanged){
    } else {
        CGRect frame = self.frame;
        //记录是否越界
        BOOL isOver = NO;
        if (frame.origin.x < 0) {
            frame.origin.x = 0;
            isOver = YES;
        } else if (frame.origin.x+frame.size.width > width) {
            frame.origin.x = width - frame.size.width;
            isOver = YES;
        }
        if (frame.origin.y < 0) {
            frame.origin.y = 0;
            isOver = YES;
        } else if (frame.origin.y+frame.size.height > height) {
            frame.origin.y = height - frame.size.height;
            isOver = YES;
        }
        if (isOver) {
            [UIView animateWithDuration:0.3 animations:^{
                self.frame = frame;
            }];
        }
        _btnSuspension.enabled = YES;
    }
#endif
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
