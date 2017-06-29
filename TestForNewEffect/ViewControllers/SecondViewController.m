//
//  SecondViewController.m
//  TestForNewEffect
//
//  Created by dvt04 on 17/6/27.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "TSPSuspensionWindow.h"

@interface SecondViewController ()<UITextFieldDelegate, UIGestureRecognizerDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWidgets];
}

- (void)setupWidgets
{
    [self.btnShowPassword setImage:[UIImage imageNamed:@"basic_eye_closed"] forState:UIControlStateNormal];
    [self.btnShowPassword setImage:[UIImage imageNamed:@"basic_eye"] forState:UIControlStateSelected];
    [self.btnShowPassword addTarget:self action:@selector(onHitBtnShowPassword:) forControlEvents:UIControlEventTouchUpInside];
    // 默认是暗文
    self.passwordTextFiled.delegate = self;
    self.passwordTextFiled.secureTextEntry = YES;
    self.passwordTextFiled.keyboardType = UIKeyboardTypeDefault;
    self.passwordTextFiled.returnKeyType = UIReturnKeyDone;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    // TODO:test
#if 0
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(100, 200, 40, 40)];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onHitBtnTest:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 20;
    [self.view addSubview:btn];
    
    UIPanGestureRecognizer *dragGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveView:)];
    [btn addGestureRecognizer:dragGesture];
#endif
}

#pragma mark - drag test
- (void)moveView:(UIPanGestureRecognizer *)gesture
{
    CGPoint point = [gesture translationInView:self.view];
    NSLog(@"X:%f;Y:%f",point.x,point.y);
    
    gesture.view.center = CGPointMake(gesture.view.center.x + point.x, gesture.view.center.y + point.y);
    [gesture setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (gesture.view.frame.origin.x < self.view.frame.size.width/2) {
            [UIView animateWithDuration:0.2 animations:^{
                [gesture.view setCenter:CGPointMake(gesture.view.frame.size.width/2 + 5, gesture.view.center.y)];
            }];
        } else {
            [UIView animateWithDuration:0.2 animations:^{
                [gesture.view setCenter:CGPointMake(self.view.frame.size.width - gesture.view.frame.size.width/2 - 5, gesture.view.center.y)];
            }];
        }
    }
}

- (void)onHitBtnTest:(id)sender
{
    NSLog(@"test");
}

#pragma mark - 明暗文切换
- (void)onHitBtnShowPassword:(id)sender
{
    UIButton *btn = (UIButton *)sender;
#if 1
    // 明暗文切换
    [self.passwordTextFiled becomeFirstResponder];
    self.passwordTextFiled.secureTextEntry = btn.selected;
    if (!self.passwordTextFiled.secureTextEntry) {
        self.passwordTextFiled.keyboardType = UIKeyboardTypeDefault;
    }
#else
    NSString *strTmp = self.passwordTextFiled.text;
    self.passwordTextFiled.text = @"";
    self.passwordTextFiled.secureTextEntry = btn.selected;
    self.passwordTextFiled.text = strTmp;
    if (!self.passwordTextFiled.secureTextEntry) {
        self.passwordTextFiled.keyboardType = UIKeyboardTypeDefault;
    }
#endif
    btn.selected = !btn.selected;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.passwordTextFiled && textField.isSecureTextEntry) {
        textField.text = toBeString;
        return NO;
    }
    return YES;
}

#pragma mark - <UIGestureRecognizerDelegate>
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)hideKeyboard:(UITapGestureRecognizer *)tap
{
    [self.passwordTextFiled resignFirstResponder];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (IBAction)onHitBtnSkip:(id)sender {
    ThirdViewController *thirdViewController = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:thirdViewController animated:YES];
#if 0
    // 隐藏悬浮窗
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if ([window isKindOfClass:[TSPSuspensionWindow class]]) {
            TSPSuspensionWindow *suspensionWindow = (TSPSuspensionWindow *)window;
            [suspensionWindow hidden];
        }
    }
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
